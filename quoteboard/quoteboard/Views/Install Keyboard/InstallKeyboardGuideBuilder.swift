//
//  InstallKeyboardGuideBuilder.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class InstallKeyboardGuideBuilder
{
    
    // - Storyboard
    private static let _storyboard = UIStoryboard(name: "InstallKeyboardGuideViewController", bundle: nil)
    
    // - Creator
    class func createScene(request: BuildRequest) -> InstallKeyboardGuideViewController
    {
        let viewController = _storyboard.instantiateViewController(ofType: InstallKeyboardGuideViewController.self)
        let interactor = InstallKeyboardGuideInteractor(request: request)
        let presenter = InstallKeyboardGuidePresenter()
        let router = InstallKeyboardGuideRouter()
        
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
extension InstallKeyboardGuideBuilder {
    struct BuildRequest {

    }
}
