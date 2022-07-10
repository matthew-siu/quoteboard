//
//  QuoteManagementPresenter.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Presentation logic goes here
protocol QuoteManagementPresentationLogic
{
    func displayInitialState(scenes: SavedScenes, sentences: SavedSentences)
}

// MARK: - Presenter main body
class QuoteManagementPresenter: QuoteManagementPresentationLogic
{
    
    weak var viewController: QuoteManagementDisplayLogic?
    
}

// MARK: - Presentation receiver
extension QuoteManagementPresenter {
    func displayInitialState(scenes: SavedScenes, sentences: SavedSentences){
        print("total sentences: \(sentences.count)")
        print("total scenes: \(scenes.count)")
        
        var list = [QuoteManagement.ViewModel.Scene]()
        for i in 0...10 {
            let groupName = scenes.first(where: {$0.groupIndex == i})?.name ?? "Group \(i)"
            var groupSentences = sentences.filter({$0.groupId == i})
            groupSentences.sort(by: {$0.uts > $1.uts})
            print("groupSentences at \(i) has \(groupSentences.count)")
            list.append(.init(index: i, sceneName: groupName, setences: groupSentences))
        }
        self.viewController?.displayInitialState(vm: .init(list: list))
    }
}
