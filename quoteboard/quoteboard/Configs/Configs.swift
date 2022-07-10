//
//  Configs.swift
//  keyboardEditor
//
//  Created by Matthew Siu on 17/6/2022.
//

import Foundation

@objc
class Configs: NSObject{
    
    enum Source{
        case app, keyboard
    }
}

extension Configs{
    enum Env{
        static var AppGroup = "group.com.nipohcuis.quoteboard.keys"
    }
    
    enum Storage{
        static var sentences = "quotes.sentences"
        static var groups = "quotes.groups"
    }
    
    enum Info {
        static let companyLink = "https://pugskystudio.com/"
        static let companyName = "Pugsky Studio"
        static let email = "pugsky.studio@gmail.com"
        static let developerAppStoreLink = "https://apps.apple.com/hk/developer/pongyin-siu/id1536337835"
        static let appLink = "quoteboard://"
    }
}
