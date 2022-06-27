//
//  AboutUsBuilder.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AboutUsBuilder
{
    
    // - Storyboard
    private static let _storyboard = UIStoryboard(name: "AboutUsViewController", bundle: nil)
    
    // - Creator
    class func createScene(request: BuildRequest) -> AboutUsViewController
    {
        let viewController = _storyboard.instantiateViewController(ofType: AboutUsViewController.self)
        let interactor = AboutUsInteractor(request: request)
        let presenter = AboutUsPresenter()
        let router = AboutUsRouter()
        
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
extension AboutUsBuilder {
    struct BuildRequest {

    }
}
