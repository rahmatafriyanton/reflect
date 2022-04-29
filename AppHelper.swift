//
//  AppHelper.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 29/04/22.
//

import Foundation

class AppHelper {
	static func randomString() -> String {
		let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		return String((0..<20).map{ _ in letters.randomElement()! })
	}
}
