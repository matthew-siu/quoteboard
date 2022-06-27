//
//  SavedSentence.swift
//  keyboardEditor
//
//  Created by Matthew Siu on 17/6/2022.
//

import Foundation

typealias SavedSentences = [SavedSentence]

struct SavedSentence: Codable{
    let sentence: String
    let groupId: Int
    let uts: Double
}
