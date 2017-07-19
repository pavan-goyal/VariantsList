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
    
    let apiUrl = "https://api.myjson.com/bins/3b0u2"
    var variantList: VariantList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoaderView()
        Alamofire.request(apiUrl).responseObject { [weak self] (response: DataResponse<VariantList>) in
            guard let weakSelf = self, let variantList = response.value else {
                return
            }
            weakSelf.variantList = variantList
            weakSelf.showTableView()
            weakSelf.setUpTableView()
            weakSelf.tableView.reloadData()
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
        return UITableViewCell()
    }
}

extension VariantsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension VariantsListViewController {
    
    func setUpTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func showTableView() {
        self.tableView.isHidden = false
        self.loaderView.isHidden = true
    }
    
    func showLoaderView() {
        self.tableView.isHidden = true
        self.loaderView.isHidden = false
    }
}

