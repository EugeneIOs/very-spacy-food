//
//  MenuItemDataProvider.swift
//  Very Spacy Food
//
//  Copyright © 2020 Very Good Security. All rights reserved.
//

import Foundation

final class MenuItemDataProvider {
	static func getAvailableMenuItems() -> [MenuItem] {
			return [
					MenuItem(imgName: "menu_item_1", name: "Pluto roll", ingredients: "Fresh salmon with avocado, philadelphia, and cucumber, spruced with a pinch of sesame", weight: "360g", price: 14.49, associatedColor: .spacyPink),
					MenuItem(imgName: "menu_item_2", name: "Mars Pizza", ingredients: "This pizza is topped with authentic Italian salami, peppers, Parmesan cheese, and spices", weight: "680g", price: 12.25, associatedColor: .spacyRed),
					MenuItem(imgName: "menu_item_3", name: "Sunburger", ingredients: "Pure beef topped with a fresh tomato, chopped onions, ketchup, mustard, and a slice of melty cheddar", weight: "500g", price: 17.15, associatedColor: .spacyOrange),
					MenuItem(imgName: "menu_item_4", name: "Alien noodle", ingredients: "Buttery, garlicky noodles served with a boiled egg, green beans, and juicy jumbo shrimp", weight: "640g", price: 13.49, associatedColor: .spacyGreen),
					MenuItem(imgName: "menu_item_5", name: "Venus fries", ingredients: "Crunchy potato fries with tomato sauce dip is a nutrishious side dish", weight: "150", price: 8.99, associatedColor: .spacyYellow)
			]
	}
}
