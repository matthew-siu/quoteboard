//
//  AboutUsViewController.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Display logic, receive view model from presenter and present
protocol AboutUsDisplayLogic: AnyObject
{

}

// MARK: - View Controller body
class AboutUsViewController: UITableViewController, AboutUsDisplayLogic
{
    // VIP
    var interactor: AboutUsBusinessLogic?
    var router: (NSObjectProtocol & AboutUsRoutingLogic & AboutUsDataPassing)?
    
    @IBOutlet weak var companyBtn: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var creditListText: UILabel!
    @IBOutlet weak var copyEmailLinkBtn: UIButton!
    
    @IBAction func onClickCopyEmail(_ sender: Any) {
        print("onClickCopyEmail")
        UIPasteboard.general.string = Configs.Info.email
    }
    
    @IBAction func exploreMore(_ sender: Any) {
        guard let url = URL(string: Configs.Info.developerAppStoreLink) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func browseCompanyWebsite(_ sender: Any) {
        guard let url = URL(string: Configs.Info.companyLink) else { return }
        UIApplication.shared.open(url)
    }
    
}

// MARK: - View Lifecycle
extension AboutUsViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "About Us"
        self.companyBtn.setTitle(Configs.Info.companyName, for: .normal)
        self.emailLabel.text = Configs.Info.email
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String{
            self.versionLabel.text = "v\(appVersion)"
        }
        self.creditListText.text = "Dave Ho, Cliff Chan"
        self.tableView.isScrollEnabled = true
        self.copyEmailLinkBtn.layer.cornerRadius = 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: .init(x: 0, y: 0, width: self.width, height: 55))
//        headerView.backgroundColor =
        let headerLabel = UILabel(frame: .init(x: 20, y: 0, width: self.width - 24, height: 40))
        switch section{
            case 0: headerLabel.text = "General"
            case 1: headerLabel.text = "Disclaimer"
            case 2: headerLabel.text = "Credits"
        default:
            headerLabel.text = ""
        }
        headerLabel.sizeToFit()
        headerLabel.center.y = headerView.center.y
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.backgroundColor = UIColor.SoftUI.major
    }
}

// MARK:- View Display logic entry point
extension AboutUsViewController {

}
