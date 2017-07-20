//
//  ViewController.swift
//  Swiggy-Assignment
//
//  Created by Pavan Goyal on 19/07/17.
//  Copyright © 2017 Pavan Goyal. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class VariantsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var proceedButton: UIButton!
    
    static let variantHeaderGroup = "VariantGroupHeader"
    static let variantItemCell = "VariationItemCell"
    let apiUrl = "https://api.myjson.com/bins/3b0u2"
    var variantList: VariantList!
    var selectedIndexPaths = [String: IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        showLoaderView()
        Alamofire.request(apiUrl).responseObject { [weak self] (response: DataResponse<VariantList>) in
            guard let weakSelf = self, let variantList = response.value else {
                return
            }
            weakSelf.variantList = variantList
            weakSelf.setUpTableView()
            weakSelf.showTableView()
            weakSelf.tableView.reloadData()
        }
    }
    
    @IBAction func proceedButtonTapped(_ sender: UIButton) {
        if let excludedItemsArray = self.variantList.mainVariant?.excludeList {
            var excludedItemsFromSelectedIndexPaths = [ExcludedItem]()
            for (_, selectedIndexPath) in selectedIndexPaths {
                let (gId, vId) = getIds(from: selectedIndexPath)
                let excludedItem = ExcludedItem(groupId: gId, variationId: vId)
                excludedItemsFromSelectedIndexPaths.append(excludedItem)
            }
            
            var isPresent = false
            for excludedItems in excludedItemsArray {
                if check(excludedItems: excludedItems, presentIn: excludedItemsFromSelectedIndexPaths) {
                    isPresent = true
                    break
                }
            }
            if isPresent {
                // show error
            } else {
                // safely proceed user to next screen
            }
        } else {
           // safely proceed user to next screen. because no excludedList present
        }
    }
}

extension VariantsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.variantList.mainVariant?.variantGroups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let variationGroups = self.variantList.mainVariant?.variantGroups else {
            return 0
        }
        let variationGroup = variationGroups[section]
        guard let variations = variationGroup.variations else {
            return 0
        }
        return variations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let variationItemCell = tableView.dequeueReusableCell(withIdentifier: VariantsListViewController.variantItemCell, for: indexPath) as? VariationItemCell, let variationGroups = self.variantList.mainVariant?.variantGroups else {
            return UITableViewCell()
        }
        let variationGroup = variationGroups[indexPath.section]
        guard let variations = variationGroup.variations, let groupId = variationGroup.groupId else {
            return UITableViewCell()
        }
        let variation = variations[indexPath.row]
        var isSelected: Bool?
        if let selectedIndexPath = selectedIndexPaths[groupId] {
            if indexPath == selectedIndexPath {
                isSelected = true
            } else {
                isSelected = false
            }
        } else {
            if let isDefault = variation.isDefault {
                if isDefault == 1 {
                    selectedIndexPaths[groupId] = indexPath
                } else {
                    
                }
            } else {
                
            }
        }
        variationItemCell.updateVariationItemCell(with: variation, isSelected: isSelected)
        return variationItemCell
    }
}

extension VariantsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return VariationItemCell.height()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return VariantGroupHeader.height()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: VariantsListViewController.variantHeaderGroup) as? VariantGroupHeader, let variationGroups = self.variantList.mainVariant?.variantGroups else {
            return nil
        }
        let variationGroup = variationGroups[section]
        headerView.updateHeaderView(with: variationGroup)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let variationGroups = self.variantList.mainVariant?.variantGroups else {
            return
        }
        let variationGroup = variationGroups[indexPath.section]
        guard let groupId = variationGroup.groupId else {
            return
        }
        selectedIndexPaths[groupId] = indexPath
        tableView.reloadData()
    }
}

extension VariantsListViewController {
    
    func setUpTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorColor = UIColor.clear
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: VariantsListViewController.variantHeaderGroup, bundle: nil), forHeaderFooterViewReuseIdentifier: VariantsListViewController.variantHeaderGroup)
        self.tableView.register(UINib(nibName: VariantsListViewController.variantItemCell, bundle: nil), forCellReuseIdentifier: VariantsListViewController.variantItemCell)
    }
    
    func showTableView() {
        self.tableView.isHidden = false
        self.proceedButton.isHidden = false
        self.loaderView.isHidden = true
    }
    
    func showLoaderView() {
        self.tableView.isHidden = true
        self.proceedButton.isHidden = true
        self.loaderView.isHidden = false
    }
    
    func hideLoaderAndTableView() {
        self.tableView.isHidden = true
        self.proceedButton.isHidden = true
        self.loaderView.isHidden = true
    }
    
    func check(excludedItems: [ExcludedItem], presentIn otherExcludedItems: [ExcludedItem]) -> Bool {
        var allItemsPresent = true
        for excludedItem in excludedItems {
            if !check(excludedItem: excludedItem, presentIn: otherExcludedItems) {
                allItemsPresent = false
                break
            }
        }
        return allItemsPresent
    }
    
    func check(excludedItem: ExcludedItem, presentIn otherExcludedItems: [ExcludedItem]) -> Bool {
        var itemIsPresent = false
        for otherExcludedItem in otherExcludedItems {
            if excludedItem == otherExcludedItem {
                itemIsPresent = true
                break
            }
        }
        return itemIsPresent
    }
    
    func getIds(from indexPath:IndexPath) -> (String?, String?) {
        var groupId: String?
        var variationId: String?
        guard let variationGroups = self.variantList.mainVariant?.variantGroups else {
            return(groupId, variationId)
        }
        let variationGroup = variationGroups[indexPath.section]
        guard let variations = variationGroup.variations else {
            groupId = variationGroup.groupId
            return(groupId, variationId)
        }
        let variation = variations[indexPath.row]
        groupId = variationGroup.groupId
        variationId = variation.variationId
        return(groupId, variationId)
    }
}

