//
//  QuoteManagementModels.swift
//  quoteboard
//
//  Created by Matthew Siu on 27/6/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - Models will go here
// Defines request, response and corresponding view models
enum QuoteManagement
{
    struct ViewModel {
        var list: [Scene]
        
        struct Scene{
            let index: Int
            let sceneName: String
            var setences: SavedSentences
        }
    }
}
