//
//  LearningModel.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 27/04/22.
//

import Foundation


struct LearningModel {
	var id: String = AppHelper.randomString()
	var title: String
	var currentSession: String?
	var createdAt: Date
}


struct LearningSessionModel {
	var id: String = AppHelper.randomString()
	var title: String
	var desc: String
	var reflection: String
	var resource: String
	var isCurrentSession: Bool
}
