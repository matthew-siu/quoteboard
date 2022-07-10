//
//  HomeViewController.swift
//  keyboardEditor
//
//  Created by Matthew Siu on 21/5/2022.
//

import UIKit

protocol HomeViewDelegate{
    func selectSentence(sentence: String?)
}

protocol HomeLogic{
    func copySentence(sentence: String)
    func defineSource(from src: Configs.Source)
}

class HomeViewController: BaseViewController {

    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var rightBarTableView: UITableView!
    @IBOutlet weak var horizontalLine: UIView!
    @IBOutlet weak var preSaveSentenceLabel: UILabel!
    
    var delegate: HomeViewDelegate?
    var source: Configs.Source = .keyboard
    var allSentenceList: SavedSentences = []
    var allSceneList: SavedScenes = []
    var currentGroupId: Int = 0
    var sentenceList: SavedSentences{
        return self.allSentenceList.filter({$0.groupId == currentGroupId}).sorted(by: {$0.uts > $1.uts})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.rightBarTableView.delegate = self
        self.rightBarTableView.dataSource = self
        
        self.mainTableView.allowsSelection = true
        self.rightBarTableView.allowsSelection = true
        
        self.initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
        
        if let copiedText = UIPasteboard.general.string {
            self.preSaveSentenceLabel.text = copiedText
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        
    }
    
    @IBAction func saveSentenceBtnDidPress(_ sender: Any) {
        if let sentence = self.preSaveSentenceLabel.text, !Utils.isEmpty(sentence){
            self.saveSentence(sentence: sentence)
            self.mainTableView.reloadData()
        }
        
    }
    
    @IBAction func goToAppBtnDidPress(_ sender: Any) {
//        guard let url = URL(string: Configs.Info.appLink) else { return }
//        self.openURL(url: url as NSURL)
        self.redirectToHostApp()
        
    }
    
    func redirectToHostApp() {

        let url = URL(string: Configs.Info.appLink)
        var responder = self as UIResponder?
        let selectorOpenURL = sel_registerName("openURL:")
        while (responder != nil) {
            if (responder?.responds(to: selectorOpenURL))! {
                let _ = responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder!.next
        }
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    private func initUI(){
        self.horizontalLine.backgroundColor = .gray
        self.preSaveSentenceLabel.text = "Highlight your favourite words and save it!"
        self.preSaveSentenceLabel.textColor = .darkGray
        self.allSentenceList = self.getSentences()
        self.allSceneList = self.getScenes()
        self.mainTableView.reloadData()
        self.rightBarTableView.selectRow(at: .init(row: 0, section: 0), animated: false, scrollPosition: .top)
        
        if self.traitCollection.userInterfaceStyle == .dark {
            
        } else {
        }
    }
}

extension HomeViewController: HomeLogic{
    func copySentence(sentence: String){
        self.preSaveSentenceLabel.text = sentence
    }
    
    func defineSource(from src: Configs.Source){
        self.source = src
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == mainTableView) {
            return self.sentenceList.count
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = UITableViewCell()
        if (tableView == mainTableView) {
            view.textLabel?.text = sentenceList[indexPath.row].sentence
            view.textLabel?.numberOfLines = 2
        }else{
            let groupName = self.allSceneList.first(where: {$0.groupIndex == indexPath.row})?.name ?? "Group \(indexPath.row)"
            view.textLabel?.text = groupName
            view.backgroundColor = .darkGray
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
        if tableView == mainTableView {
            let sentence = self.sentenceList[indexPath.row].sentence
            self.delegate?.selectSentence(sentence: sentence)
        }else{
            self.currentGroupId = indexPath.row
            self.mainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableView == mainTableView {
            let deleteBtn = UIContextualAction(style: .normal,
                                             title: "Delete") { [weak self] (action, view, completionHandler) in
                self?.handleDelete(uuid: self?.sentenceList[indexPath.row].uts)
                completionHandler(true)
            }
            deleteBtn.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteBtn])
            return configuration
        }else{
            let deleteBtn = UIContextualAction(style: .normal,
                                             title: "Edit") { [weak self] (action, view, completionHandler) in
                
                if (self?.source == .keyboard){
                    print("navigate to app")
                    // route to the app
                    
                }else if (self?.source == .app){
                    print("edit now")
                    self?.showAlert("Scene", _msg: "Rename the group to:", completion: { name in
                        
                    })
                }
                completionHandler(true)
            }
            deleteBtn.image = UIImage(named: "pencil")?.resized(toWidth: 32)
            deleteBtn.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteBtn])
            return configuration
        }
    }
}

extension HomeViewController {
    func getSentences() -> SavedSentences{
        return SavedSentence.getAllSentences()
    }
    
    func getScenes() -> SavedScenes{
        return SavedScene.getAllScenes()
    }
    
    func saveSentence(sentence: String, groupId: Int? = nil){
        let groupId = (groupId != nil) ? groupId ?? 0 : self.currentGroupId
        print("save sentence to group \(groupId)")
        self.allSentenceList.insert(.init(sentence: sentence, groupId: groupId, uts: Date().timeIntervalSince1970), at: 0)
        Storage.saveObj(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, self.allSentenceList)
    }
    
    func handleDelete(uuid: Double?){
        guard let uuid = uuid else{return}
        self.allSentenceList.removeAll(where: {$0.uts == uuid})
        Storage.saveObj(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, self.allSentenceList)
        self.mainTableView.reloadData()
    }
}
