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
}
