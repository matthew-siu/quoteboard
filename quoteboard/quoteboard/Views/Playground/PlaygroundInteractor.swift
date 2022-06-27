//
//  PlaygroundInteractor.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Requests from view
protocol PlaygroundBusinessLogic
{
    
}

// MARK: - Datas retain in interactor defines here
protocol PlaygroundDataStore
{
    
}

// MARK: - Interactor Body
class PlaygroundInteractor: PlaygroundBusinessLogic, PlaygroundDataStore
{
    // VIP Properties
    var presenter: PlaygroundPresentationLogic?
    var worker: PlaygroundWorker?
    
    // State
    
    
    // Init
    init(request: PlaygroundBuilder.BuildRequest) {
        
    }
}

// MARK: - Business
extension PlaygroundInteractor {

}
