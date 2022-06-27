//
//  AboutUsRouter.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - The main interface to be called by others
protocol AboutUsRoutingLogic
{
    
}

// MARK: - The possible elements that can be
protocol AboutUsDataPassing
{
    var dataStore: AboutUsDataStore? { get }
}

// MARK: - Main router body
class AboutUsRouter: NSObject, AboutUsRoutingLogic, AboutUsDataPassing
{
    weak var viewController: AboutUsViewController?
    var dataStore: AboutUsDataStore?
}

// MARK: - Routing and datapassing for one nav action
extension AboutUsRouter {

}
