//
//  PlaygroundRouter.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - The main interface to be called by others
protocol PlaygroundRoutingLogic
{
    
}

// MARK: - The possible elements that can be
protocol PlaygroundDataPassing
{
    var dataStore: PlaygroundDataStore? { get }
}

// MARK: - Main router body
class PlaygroundRouter: NSObject, PlaygroundRoutingLogic, PlaygroundDataPassing
{
    weak var viewController: PlaygroundViewController?
    var dataStore: PlaygroundDataStore?
}

// MARK: - Routing and datapassing for one nav action
extension PlaygroundRouter {

}
