//
//  TableViewCellHelper.swift
//  quoteboard
//
//  Created by Matthew Siu on 28/6/2022.
//

import Foundation

import Foundation
import UIKit

// MARK: - Main purpose is to help configuration cell initialization in a faster and centralized way
protocol TableViewCellConfiguration: RawRepresentable where Self.RawValue == String {}

protocol CollectionViewCellConfiguration: TableViewCellConfiguration {}

extension TableViewCellConfiguration {
    var nib: UINib? {
        return UINib(nibName: self.rawValue, bundle: nil)
    }
    
    var reuseId: String {
        return self.rawValue
    }
}
