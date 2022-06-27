//
//  QuoteManagementViewController.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Display logic, receive view model from presenter and present
protocol QuoteManagementDisplayLogic: AnyObject
{
    func displayInitialState(vm: QuoteManagement.ViewModel)
}

// MARK: - View Controller body
class QuoteManagementViewController: UIViewController, QuoteManagementDisplayLogic
{
    // VIP
    var interactor: QuoteManagementBusinessLogic?
    var router: (NSObjectProtocol & QuoteManagementRoutingLogic & QuoteManagementDataPassing)?
    
    @IBOutlet weak var tableView: UITableView!
    
    enum TableViewCell: String, TableViewCellConfiguration {
        case header = "QuoteTableViewHeader"
        case itemCell = "QuoteTableViewCell"
    }
    
    var vm: QuoteManagement.ViewModel = .init(list: [])
}

// MARK: - View Lifecycle
extension QuoteManagementViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.dragDelegate = self
        self.tableView.dropDelegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        
        self.tableView.register(TableViewCell.header.nib, forHeaderFooterViewReuseIdentifier: TableViewCell.header.reuseId)
        self.tableView.register(TableViewCell.itemCell.nib, forCellReuseIdentifier: TableViewCell.itemCell.reuseId)
        
        self.setupUI()
        self.interactor?.loadInitialState()
    }
    
    func setupUI(){
        self.title = "Quote Management"
    }
}

// MARK:- View Display logic entry point
extension QuoteManagementViewController: UITableViewDelegate, UITableViewDataSource, QuoteTableViewHeaderDelegate {
    
    // ----------- cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.vm.list.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewCell.header.reuseId) as! QuoteTableViewHeader
        headerView.delegate = self
        headerView.setText(index: section, name: "Group \(section)")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func editSceneNameBtnDidPress(index: Int) {
        // show alert
    }
    
    // ----------- item
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.itemCell.reuseId, for: indexPath) as! QuoteTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}

extension QuoteManagementViewController: UITableViewDragDelegate, UITableViewDropDelegate{
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
}

extension QuoteManagementViewController{
    func displayInitialState(vm: QuoteManagement.ViewModel){
        self.vm = vm
        self.tableView.reloadData()
    }
}
