//
//  QuoteManagementRouter.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - The main interface to be called by others
protocol QuoteManagementRoutingLogic
{
    
}

// MARK: - The possible elements that can be
protocol QuoteManagementDataPassing
{
    var dataStore: QuoteManagementDataStore? { get }
}

// MARK: - Main router body
class QuoteManagementRouter: NSObject, QuoteManagementRoutingLogic, QuoteManagementDataPassing
{
    weak var viewController: QuoteManagementViewController?
    var dataStore: QuoteManagementDataStore?
}

// MARK: - Routing and datapassing for one nav action
extension QuoteManagementRouter {

}
