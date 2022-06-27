//
//  UIStoryboardExtension.swift
//  ffts-ios
//
//  Created by Ding Lo on 27/10/2021.
//

import Foundation

import UIKit

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
    
}
