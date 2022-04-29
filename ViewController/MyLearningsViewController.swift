//
//  ViewController.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 27/04/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DismissPageDelegate {
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	var selectedRow: LearningItem?
	@IBOutlet weak var tableView: UITableView!
	private var models = [LearningItem]()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem()

		tableView.delegate = self
		tableView.dataSource = self

		let nib = UINib(nibName: "LearningTableViewCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "cell")

		getAllLearningData()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { return }
		if cell.isSelected == true {
			cell.isSelected = false
		}

		selectedRow = models[indexPath.row]

		performSegue(withIdentifier: "goToLearningDetail", sender: self)
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LearningTableViewCell
		cell.title.text = model.title
		cell.currentSession.text = "-"
		return cell
	}


	// Core Data
	func getAllLearningData() {
		do {
			models = try context.fetch(LearningItem.fetchRequest())
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		} catch {

		}
	}

	

	func deleteLearningData(item: LearningItem) {
		context.delete(item)
		do {
			try context.save()
		} catch {

		}
	}

	func updateLearningData(item: LearningItem, newData: LearningModel) {
		item.title = newData.title
		item.currentSession = newData.currentSession
		do {
			try context.save()
		} catch {

		}
	}

	func didTapSave() {
		getAllLearningData()
		self.tableView.reloadData()
	}

	
	@IBAction func addTapAction(_ sender: Any) {
		performSegue(withIdentifier: "goToAddLearning", sender: self)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToAddLearning" {
			let destVC = segue.destination as? AddLearningViewController
			destVC?.dismissDelegate = self
		}

		if segue.identifier == "goToLearningDetail" {
			let destVC = segue.destination as? DetailViewController
			destVC?.detailLearning = selectedRow
		}
	}
	
}
