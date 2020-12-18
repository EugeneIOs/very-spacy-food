//
//  MenuViewController.swift
//  Spacy Food
//
//  Created by Dima on 13.03.2020.
//  Copyright © 2020 Very Good Security. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var counterLabel: UILabel!
    
    var securedCardData: SecuredCardData? {
        didSet {
            let title = securedCardData == nil ? "Add payment method" : "Checkout"
            checkoutButton.setTitle(title, for: .normal)
        }
    }
    var orderPrice: Double = 0.0
    var orderItemsCount: Int = 0 {
        didSet {
            counterLabel.text = "\(orderItemsCount)"
        }
    }
    lazy var menuItems: [MenuItem] = {
			return MenuItemDataProvider.getAvailableMenuItems()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.addGradient(UIColor.midBlueColorsSet)
    }
    
    @IBAction func checkoutAction(_ sender: UIButton) {
        if let securedCardData = securedCardData {
            guard orderItemsCount > 0 else {
                showAlert(title: "Ooops!", text: "Seems you didn't choose any item yet...")
                return
            }
            proceedToCheckout([Any](), cardData: securedCardData)
        } else {
            showCollectCardDataView()
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as? MenuItemCell
        
        let menuItem = menuItems[indexPath.row]
        cell?.name.text = menuItem.name
        cell?.ingredients.text = menuItem.ingredients
        cell?.price.text = "$\(menuItem.price)"
        cell?.itemImage.image = UIImage(named: menuItem.imgName)
        
        cell?.onAddItemClicked = { [weak self] in
            self?.orderItemsCount += 1
            self?.orderPrice += menuItem.price
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = menuItems[indexPath.row]
        let detailsVC = UIStoryboard.main.instantiateViewController(withIdentifier: "MenuItemDetailsViewController") as! MenuItemDetailsViewController
        detailsVC.menuItem = selectedItem
        detailsVC.onItemAdded = { [weak self] item in
            self?.orderItemsCount += 1
            self?.orderPrice += selectedItem.price
        }
        detailsVC.modalPresentationStyle = .overCurrentContext
        self.present(detailsVC, animated: true, completion: nil)
    }
}

//MARK: - Navigation
extension MenuViewController {
    
    private func showCollectCardDataView() {
        let collectCardVC = UIStoryboard.main.instantiateViewController(withIdentifier: "CollectCreditCardDataViewController") as! CollectCreditCardDataViewController
        collectCardVC.modalPresentationStyle = .overCurrentContext
        collectCardVC.onCompletion = { [weak self] (cardData) in
            self?.securedCardData = cardData
        }
        print("TOGGLE DEVICE KEYBOARD IF XCODE DIDN'T!!!")
        self.present(collectCardVC, animated: false, completion: nil)
    }
    
    private func proceedToCheckout(_ orderItems: [Any], cardData: SecuredCardData) {
        let checkoutVC = UIStoryboard.main.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController
        checkoutVC.orderPrice = orderPrice
        checkoutVC.securedCardData = cardData
        self.navigationController?.pushViewController(checkoutVC, animated: true)
    }

}

//MARK: - Helpers
extension MenuViewController {

    func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
    }
}
