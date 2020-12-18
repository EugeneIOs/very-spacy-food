//
//  VGSAppClipRouteEvent.swift
//  VeryGoodSpacyFoodClip
//
//  Copyright © 2020 Very Good Security. All rights reserved.
//

import Foundation

enum VGSAppClipRouteEvent {
	case orderProduct(_ id: String)

	enum Constants {
		enum Paths {
			static let orderProduct = "order-product"
		}
	}

	init?(userActivity: NSUserActivity) {
		guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
					let url = userActivity.webpageURL else {
			print("not webpage URL activity")
			return nil }

		guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
		let queryItems = components.queryItems else {
			return nil
		}

		let constants = Constants.Paths.self
		switch url.path {
		case constants.orderProduct:
			guard let item = queryItems.first, let orderCode = item.value as? String else {
				return nil
			}

			self = .orderProduct(orderCode)
			return
		default:
			return nil
		}
	}
}
