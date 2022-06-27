//
//  InstallKeyboardGuideRouter.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - The main interface to be called by others
protocol InstallKeyboardGuideRoutingLogic
{
    
}

// MARK: - The possible elements that can be
protocol InstallKeyboardGuideDataPassing
{
    var dataStore: InstallKeyboardGuideDataStore? { get }
}

// MARK: - Main router body
class InstallKeyboardGuideRouter: NSObject, InstallKeyboardGuideRoutingLogic, InstallKeyboardGuideDataPassing
{
    weak var viewController: InstallKeyboardGuideViewController?
    var dataStore: InstallKeyboardGuideDataStore?
}

// MARK: - Routing and datapassing for one nav action
extension InstallKeyboardGuideRouter {

}
