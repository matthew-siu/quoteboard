//
//  PlaygroundViewController.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Display logic, receive view model from presenter and present
protocol PlaygroundDisplayLogic: AnyObject
{

}

// MARK: - View Controller body
class PlaygroundViewController: UIViewController, PlaygroundDisplayLogic
{
    // VIP
    var interactor: PlaygroundBusinessLogic?
    var router: (NSObjectProtocol & PlaygroundRoutingLogic & PlaygroundDataPassing)?
    
    @IBOutlet weak var howToInstallLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBAction func howToInstallBtnDidPress(_ sender: Any) {
        let request = InstallKeyboardGuideBuilder.BuildRequest()
        let vc = InstallKeyboardGuideBuilder.createScene(request: request)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func quoteManagementBtnDidPress(_ sender: Any) {
        let request = QuoteManagementBuilder.BuildRequest()
        let vc = QuoteManagementBuilder.createScene(request: request)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

// MARK: - View Lifecycle
extension PlaygroundViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setupUI()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupUI(){
        self.title = "Playground"
        self.howToInstallLabel.text = "1. If you haven't installed the keyboard, please click here"
        self.instructionLabel.text = "- Tap the textbox to open our keyboard.\n- Double click or copy some sample texts and preview them in our keyboard.\n- Save to your designated scene.\n"
        
    }
}

// MARK:- View Display logic entry point
extension PlaygroundViewController {

}
