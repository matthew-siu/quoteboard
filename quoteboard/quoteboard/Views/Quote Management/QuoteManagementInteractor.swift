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
    func addSentence(sentence: String, groupId: Int)
    func updateSentence(old: SavedSentence, to sentence: String)
    func moveSentence(old: SavedSentence, to index: Int)
    func deleteSentence(sentence: SavedSentence)
    func renameGroup(name: String, at index: Int)
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
        let groups = SavedScene.getAllScenes()
        let sentences = SavedSentence.getAllSentences()
        self.presenter?.displayInitialState(scenes: groups, sentences: sentences)
    }
    
    func addSentence(sentence: String, groupId: Int){
        SavedSentence.addSentence(sentence: sentence, groupId: groupId)
    }
    
    func updateSentence(old: SavedSentence, to sentence: String){
        SavedSentence.updateSentence(old: old, to: sentence)
    }
    
    func moveSentence(old: SavedSentence, to index: Int){
        SavedSentence.moveSentence(old: old, to: index)
    }
    
    func deleteSentence(sentence: SavedSentence){
        SavedSentence.deleteSentence(sentence: sentence)
    }
    
    func renameGroup(name: String, at index: Int){
        SavedScene.renameScene(name: name, at: index)
    }
}
