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
    let refreshControl = UIRefreshControl()
    
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
//        self.tableView.dropDelegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.register(TableViewCell.header.nib, forHeaderFooterViewReuseIdentifier: TableViewCell.header.reuseId)
        self.tableView.register(TableViewCell.itemCell.nib, forCellReuseIdentifier: TableViewCell.itemCell.reuseId)
        
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.hideKeyboardWhenTappedAround()
        
        self.setupUI()
        self.interactor?.loadInitialState()
    }
    
    func setupUI(){
        self.title = "Quote Management"
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.interactor?.loadInitialState()
        self.refreshControl.endRefreshing()
    }
}

// MARK:- View Display logic entry point
extension QuoteManagementViewController: UITableViewDelegate, UITableViewDataSource, QuoteTableViewHeaderDelegate, QuoteTableViewCellDelegate {
    
    // ----------- cell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.vm.list.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewCell.header.reuseId) as! QuoteTableViewHeader
        headerView.delegate = self
        headerView.setText(index: section, name: self.vm.list[section].sceneName)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func editSceneNameBtnDidPress(index: Int) {
        let groupName = self.vm.list[index].sceneName
        
        let alert = UIAlertController(title: "Rename", message: "Group \(index) name: \(groupName)", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = groupName
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            if let name = textField?.text, name != ""{
                self.renameGroup(name: name, at: index)
            }
        }))
        alert.addAction(.init(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    // ----------- item
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.list[section].setences.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.itemCell.reuseId, for: indexPath) as! QuoteTableViewCell
        cell.setText(sentence: self.vm.list[indexPath.section].setences[indexPath.row].sentence, indexPath: indexPath)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func saveQuote(sentence: String, at indexPath: IndexPath){
        self.editSentence(sentence: sentence, at: indexPath)
    }
}

extension QuoteManagementViewController: UITableViewDragDelegate{
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        return [dragItem]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
            print("from \(sourceIndexPath) to \(destinationIndexPath)")
        let mover = self.vm.list[sourceIndexPath.section].setences.remove(at: sourceIndexPath.row)
        self.vm.list[destinationIndexPath.section].setences.insert(mover, at: 0)
        self.moveSentence(sentence: mover, to: destinationIndexPath.section)
        
    }
    
    // on drag to new destination, determine whether can switch position
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == proposedDestinationIndexPath.section {
            return sourceIndexPath
        }
        return IndexPath(row: 0, section: proposedDestinationIndexPath.section)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action1 = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            if let cell = tableView.cellForRow(at: indexPath) as? QuoteTableViewCell{
                cell.enableEdit()
            }
            completionHandler(true)
        }
        action1.backgroundColor = .systemBlue
        let action2 = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            self?.deleteSentence(indexPath: indexPath)
            completionHandler(true)
        }
        action2.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [action1, action2])
    }
}

extension QuoteManagementViewController{
    func displayInitialState(vm: QuoteManagement.ViewModel){
        self.vm = vm
        self.tableView.reloadData()
    }
    
    func deleteSentence(indexPath: IndexPath){
        let sentence = self.vm.list[indexPath.section].setences[indexPath.row]
        self.interactor?.deleteSentence(sentence: sentence)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.interactor?.loadInitialState()
        }
    }
    
    func moveSentence(sentence: SavedSentence, to index: Int){
        self.interactor?.moveSentence(old: sentence, to: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.interactor?.loadInitialState()
        }
    }
    
    func editSentence(sentence: String, at indexPath: IndexPath){
        let old = self.vm.list[indexPath.section].setences[indexPath.row]
        self.interactor?.updateSentence(old: old, to: sentence)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.interactor?.loadInitialState()
        }
    }
    
    func renameGroup(name: String, at index: Int){
        self.interactor?.renameGroup(name: name, at: index)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.interactor?.loadInitialState()
        }
    }
}
