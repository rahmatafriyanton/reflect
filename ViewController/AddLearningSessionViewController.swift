//
//  AddLearningSessionViewController.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 28/04/22.
//

import UIKit

class AddLearningSessionViewController: UIViewController {

	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	var actionToUpdate: ActionToUpdate!

	@IBOutlet weak var sessionTitle: UITextField!
	@IBOutlet weak var desc: UITextView!
	@IBOutlet weak var reflection: UITextView!
	@IBOutlet weak var resources: UITextField!
	@IBOutlet weak var isCurrent: UISwitch!

	var learningItemID: String?

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	
	@IBAction func addNewLearningSession(_ sender: Any) {
		if (formValidation()) {
			let newItem = LearningSessionModel(title: sessionTitle.text!,
											   desc: desc.text!,
											   reflection: reflection.text!,
											   resource: resources.text!,
											   isCurrentSession: isCurrent.isOn)

			self.createLearningData(data: newItem)
			actionToUpdate?.updateCurrentSessionAfter(data: newItem)
			self.dismiss(animated: true, completion: nil)
		} else {
			let alert = UIAlertController(title: "Warning", message: "Fill all required field!", preferredStyle: UIAlertController.Style.alert)
			alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}

	func createLearningData(data: LearningSessionModel ) {
		let newItem = LearningSessionItem(context: context)
		newItem.id = data.id
		newItem.title = data.title
		newItem.resources = data.resource
		newItem.reflection = data.reflection
		newItem.desc = data.desc
		newItem.learningItemID = learningItemID

		do {
			try context.save()
		} catch {

		}
	}

	func formValidation() -> Bool {
		if (sessionTitle.text == "" && desc.text == "") {
			return false
		}
		return true
	}
	
}
