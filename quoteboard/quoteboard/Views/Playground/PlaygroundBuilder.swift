//
//  PlaygroundBuilder.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class PlaygroundBuilder
{
    
    // - Storyboard
    private static let _storyboard = UIStoryboard(name: "PlaygroundViewController", bundle: nil)
    
    // - Creator
    class func createScene(request: BuildRequest) -> PlaygroundViewController
    {
        let viewController = _storyboard.instantiateViewController(ofType: PlaygroundViewController.self)
        let interactor = PlaygroundInteractor(request: request)
        let presenter = PlaygroundPresenter()
        let router = PlaygroundRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}

/*
    MARK: - Scene building raw materials
    - All params inject here
*/
extension PlaygroundBuilder {
    struct BuildRequest {

    }
}
