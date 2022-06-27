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
class AboutUsViewController: UIViewController, AboutUsDisplayLogic
{
    // VIP
    var interactor: AboutUsBusinessLogic?
    var router: (NSObjectProtocol & AboutUsRoutingLogic & AboutUsDataPassing)?
    
    
}

// MARK: - View Lifecycle
extension AboutUsViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
}

// MARK:- View Display logic entry point
extension AboutUsViewController {

}
