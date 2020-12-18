//
//  VGSAppClipEventHandler.swift
//  VeryGoodSpacyFoodClip
//
//  Copyright © 2020 Very Good Security. All rights reserved.
//

import Foundation
import UIKit

final class VGSAppClipEventHandler {

	private let window: UIWindow

	// MARK: - Initializer

	init(_ window: UIWindow) {
		self.window = window
	}

	// MARK: - Public

	func canHandleActivity(_ userActivity: NSUserActivity) -> Bool {
		return VGSAppClipRouteEvent(userActivity: userActivity) != nil
	}

	func handleRouteEvent(_ event: VGSAppClipRouteEvent) {
		switch event {
		case .orderProduct(let id):
			let viewController = ViewController()
		}
	}
}
