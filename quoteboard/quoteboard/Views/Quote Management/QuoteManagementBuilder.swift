//
//  QuoteManagementBuilder.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class QuoteManagementBuilder
{
    
    // - Storyboard
    private static let _storyboard = UIStoryboard(name: "QuoteManagementViewController", bundle: nil)
    
    // - Creator
    class func createScene(request: BuildRequest) -> QuoteManagementViewController
    {
        let viewController = _storyboard.instantiateViewController(ofType: QuoteManagementViewController.self)
        let interactor = QuoteManagementInteractor(request: request)
        let presenter = QuoteManagementPresenter()
        let router = QuoteManagementRouter()
        
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
extension QuoteManagementBuilder {
    struct BuildRequest {

    }
}
