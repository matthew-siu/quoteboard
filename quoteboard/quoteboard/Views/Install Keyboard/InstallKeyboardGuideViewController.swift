//
//  InstallKeyboardGuideViewController.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Display logic, receive view model from presenter and present
protocol InstallKeyboardGuideDisplayLogic: AnyObject
{

}

// MARK: - View Controller body
class InstallKeyboardGuideViewController: UITableViewController, InstallKeyboardGuideDisplayLogic
{
    // VIP
    var interactor: InstallKeyboardGuideBusinessLogic?
    var router: (NSObjectProtocol & InstallKeyboardGuideRoutingLogic & InstallKeyboardGuideDataPassing)?
    
    
    @IBOutlet weak var goToAppSettingBtn: UIButton!
    @IBOutlet weak var goToAppSettingAltLabel: UILabel!
    
    @IBOutlet weak var goToKeybaordSettingBtn: UIButton!
    @IBOutlet weak var goToKeyboardSettingAltLabel: UILabel!
    
    @IBOutlet weak var openKeyboardLabel: UILabel!
    @IBOutlet weak var openKeyboardDescriptionLabel: UILabel!
    
    
    @IBAction func appSettingBtnDidPress(_ sender: Any) {
        print("appSettingBtnDidPress: \(UIApplication.openSettingsURLString)")
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func keybaordSettingBtnDidPress(_ sender: Any) {
        let urlStr = "App-prefs:General&path=Keyboard/KEYBOARDS"
        guard let settingsUrl = URL(string: urlStr) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
    
    
}

// MARK: - View Lifecycle
extension InstallKeyboardGuideViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 80
        self.tableView.separatorStyle = .none
        
        self.setupUI()
        
    }
    
    func setupUI(){
        self.title = "Install Quote Keyboard"
        
        self.goToAppSettingBtn.setTitle("Click here to open App settings", for: .normal)
        self.goToAppSettingAltLabel.text = "The keyboard need your permission to access the pasteboard. You need to enable the \"Full Access\" for most features. \n\nWe do not collect or transmit any of your information to any parties."
        
        self.goToKeybaordSettingBtn.setTitle("Click here to add our keyboard", for: .normal)
        self.goToKeyboardSettingAltLabel.text = "Or manually open Setting > General > Keyboard > Keyboards > Click \"Add New Keyboard...\".\n\nChoose \"Quote Clipboard - Quoteboard\"."
        
        self.openKeyboardLabel.text = "Enjoy!"
        self.openKeyboardDescriptionLabel.text = "Open keyboard in any textbox or chat. Switch to Quoteboard and save all reusable sentences!"
        
    }
}

// MARK:- View Display logic entry point
extension InstallKeyboardGuideViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
