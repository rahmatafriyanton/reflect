//
//  AppProtocol.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 28/04/22.
//

import Foundation

protocol DismissPageDelegate {
	func didTapSave()
}

protocol ActionToUpdate {
	func updateCurrentSessionAfter(data: LearningSessionModel)
}
