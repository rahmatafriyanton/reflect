//
//  AddLearningViewController.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 27/04/22.
//
import UIKit

class AddLearningViewController: UIViewController {
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	var dismissDelegate: DismissPageDelegate!
	@IBOutlet weak var titleTF: UITextField!

	override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = false

        // Do any additional setup after loading the view.
    }

	func createLearningData(learningData: LearningModel ) {
		let newItem = LearningItem(context: context)
		newItem.id = learningData.id
		newItem.title = learningData.title
		newItem.currentSession = learningData.currentSession

		do {
			try context.save()
		} catch {

		}
	}
    

	@IBAction func saveNewLearning(_ sender: Any) {
		if (titleTF.text != "") {
			let newItem = LearningModel(title: titleTF.text ?? "", createdAt: Date())
			self.createLearningData(learningData: newItem)

			dismissDelegate?.didTapSave()
			self.dismiss(animated: true, completion: nil)

		} else {
			return
		}
	}

}
