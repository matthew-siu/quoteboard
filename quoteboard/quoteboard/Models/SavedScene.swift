//
//  SavedScene.swift
//  quoteboard
//
//  Created by Matthew Siu on 28/6/2022.
//

import Foundation

typealias SavedScenes = [SavedScene]

struct SavedScene: Codable{
    let groupIndex: Int
    let name: String
    let uts: Double
}
