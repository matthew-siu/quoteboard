//
//  AboutUsInteractor.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Requests from view
protocol AboutUsBusinessLogic
{
    
}

// MARK: - Datas retain in interactor defines here
protocol AboutUsDataStore
{
    
}

// MARK: - Interactor Body
class AboutUsInteractor: AboutUsBusinessLogic, AboutUsDataStore
{
    // VIP Properties
    var presenter: AboutUsPresentationLogic?
    var worker: AboutUsWorker?
    
    // State
    
    
    // Init
    init(request: AboutUsBuilder.BuildRequest) {
        
    }
}

// MARK: - Business
extension AboutUsInteractor {

}
