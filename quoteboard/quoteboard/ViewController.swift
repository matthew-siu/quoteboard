//
//  ViewController.swift
//  keyboardEditor
//
//  Created by Matthew Siu on 21/5/2022.
//

import UIKit

class ViewController: UIViewController, HomeViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Settings"
        
//        let vc = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        addChild(vc)
//        self.view.addSubview(vc.view)
//        vc.view.frame = view.bounds
//        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        vc.didMove(toParent: self)
//        vc.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }
    
    func selectSentence(sentence: String?) {
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("UIPasteboard.general.string = \(UIPasteboard.general.string ?? "")")
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "Install"
        case 1:
            return "Preference"
        case 2:
            return "About"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 1) ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = UITableViewCell()
        switch indexPath.section{
        case 0:
            view.textLabel?.text = "Install Quotes Keyboard"
        case 1:
            view.textLabel?.text = (indexPath.row == 0) ? "Interface" : "Quote Management"
        case 2:
            view.textLabel?.text = "About Us"
        default:
            view.textLabel?.text = ""
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.routeToPage(indexPath: indexPath)
    }
    
    
}

extension ViewController {
    func routeToPage(indexPath: IndexPath){
        print("routeToPage: section=\(indexPath.section), row=\(indexPath.row)")
        if (indexPath.section == 0 && indexPath.row == 0){
            let request = InstallKeyboardGuideBuilder.BuildRequest()
            let vc = InstallKeyboardGuideBuilder.createScene(request: request)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if (indexPath.section == 1 && indexPath.row == 0){
            let request = PlaygroundBuilder.BuildRequest()
            let vc = PlaygroundBuilder.createScene(request: request)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if (indexPath.section == 1 && indexPath.row == 1){
            let request = QuoteManagementBuilder.BuildRequest()
            let vc = QuoteManagementBuilder.createScene(request: request)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if (indexPath.section == 2 && indexPath.row == 0){
            let request = AboutUsBuilder.BuildRequest()
            let vc = AboutUsBuilder.createScene(request: request)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
