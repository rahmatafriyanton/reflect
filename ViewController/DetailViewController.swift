//
//  DetailViewController.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 28/04/22.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ActionToUpdate {

	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	private var models = [LearningSessionItem]()


	var detailLearning: LearningItem?
	var currentSession: [LearningSessionItem] = []
	@IBOutlet weak var learningTitle: UILabel!
	@IBOutlet weak var tableView: UITableView!

	@IBOutlet weak var currentSessionResource: UILabel!

	@IBOutlet weak var currentSessionReflection: UILabel!
	@IBOutlet weak var currentSessionTitle: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		learningTitle.text = detailLearning?.title
		tableView.delegate = self
		tableView.dataSource = self

		getAllLearningSessionData()
		getCurrentSession(filter: detailLearning?.currentSession ?? "")
    }

	func getCurrentSession(filter: String) {
		let fetch = LearningSessionItem.fetchRequest()
		fetch.predicate = NSPredicate(format: "id == %@", filter)

		currentSession = try! context.fetch(fetch)

		if (!currentSession.isEmpty) {
			currentSessionTitle.text = currentSession[0].title
			currentSessionResource.text = currentSession[0].resources != "" ? currentSession[0].resources : "-"
			currentSessionReflection.text = currentSession[0].reflection != "" ? currentSession[0].reflection : "-"
		} else {
			currentSessionTitle.text = "-"
		}
	}


	//Table View Data Flow
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) else { return }
		if cell.isSelected == true {
			cell.isSelected = false
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return models.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = models[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "learningSessionCell", for: indexPath)

		cell.textLabel?.text = model.title
		return cell
	}

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let action = UIContextualAction(style: .destructive, title: "Delete") {action, view, completionHandler in
			let data = self.models[indexPath.row]

			self.context.delete(data)
			do {
				try self.context.save()
				self.getAllLearningSessionData()
			} catch {

			}
		}
		return UISwipeActionsConfiguration(actions: [action])
	}



	// Core Data
	func getAllLearningSessionData() {
		do {
			models = try context.fetch(LearningSessionItem.fetchRequest())
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		} catch {

		}
	}


	func deleteLearningSessionData(item: LearningSessionItem) {
		context.delete(item)

		// Update Current Session Here
		do {
			try context.save()
		} catch {

		}
	}

	func updateLearningSessionData(item: LearningSessionItem, newData: LearningSessionModel) {
		item.title = newData.title
		item.desc  = newData.desc
		item.reflection = newData.reflection

		// Update Current Session Here

		do {
			try context.save()
		} catch {

		}
	}

	//Button Add Learning Session
	@IBAction func addLearningSession(_ sender: Any) {
		performSegue(withIdentifier: "goToAddLearningSession", sender: self)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "goToAddLearningSession") {
			let destVC = segue.destination as? AddLearningSessionViewController
			destVC?.actionToUpdate = self
			destVC?.learningItemID = detailLearning?.id
		}
	}

	func updateCurrentSession(data: LearningSessionModel) {
		
	}

	func updateCurrentSessionAfter(data: LearningSessionModel) {
		if (data.isCurrentSession) {
			updateCurrentSession(item: detailLearning!, newData: data)
		}

		getAllLearningSessionData()
		getCurrentSession(filter: detailLearning?.currentSession ?? "")
		self.tableView.reloadData()
	}

	func updateCurrentSession(item: LearningItem, newData: LearningSessionModel) {
		item.currentSession = newData.id
		do {
			try context.save()
		} catch {

		}
	}
}
