//
//  InstallKeyboardGuideInteractor.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Requests from view
protocol InstallKeyboardGuideBusinessLogic
{
    
}

// MARK: - Datas retain in interactor defines here
protocol InstallKeyboardGuideDataStore
{
    
}

// MARK: - Interactor Body
class InstallKeyboardGuideInteractor: InstallKeyboardGuideBusinessLogic, InstallKeyboardGuideDataStore
{
    // VIP Properties
    var presenter: InstallKeyboardGuidePresentationLogic?
    var worker: InstallKeyboardGuideWorker?
    
    // State
    
    
    // Init
    init(request: InstallKeyboardGuideBuilder.BuildRequest) {
        
    }
}

// MARK: - Business
extension InstallKeyboardGuideInteractor {

}
