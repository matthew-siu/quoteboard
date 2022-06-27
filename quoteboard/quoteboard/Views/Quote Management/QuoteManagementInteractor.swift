//
//  QuoteManagementInteractor.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Requests from view
protocol QuoteManagementBusinessLogic
{
    func loadInitialState()
}

// MARK: - Datas retain in interactor defines here
protocol QuoteManagementDataStore
{
    
}

// MARK: - Interactor Body
class QuoteManagementInteractor: QuoteManagementBusinessLogic, QuoteManagementDataStore
{
    // VIP Properties
    var presenter: QuoteManagementPresentationLogic?
    var worker: QuoteManagementWorker?
    
    // State
    
    
    // Init
    init(request: QuoteManagementBuilder.BuildRequest) {
        
    }
}

// MARK: - Business
extension QuoteManagementInteractor {
    func loadInitialState(){
        let groups = Storage.getObject(suiteName: Configs.Env.AppGroup, Configs.Storage.groups, to: SavedScenes.self)
        let sentences = Storage.getObject(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, to: SavedSentences.self)
        
        self.presenter?.displayInitialState(scenes: groups, sentences: sentences)
    }
}
