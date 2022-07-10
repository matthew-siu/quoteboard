//
//  SavedSentence.swift
//  keyboardEditor
//
//  Created by Matthew Siu on 17/6/2022.
//

import Foundation

typealias SavedSentences = [SavedSentence]

struct SavedSentence: Codable, Equatable{
    var sentence: String
    var groupId: Int
    var uts: Double
    
    static func getAllSentences() -> SavedSentences{
        return Storage.getObject(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, to: SavedSentences.self) ?? []
    }
    
    static func addSentence(sentence: String, groupId: Int = 0){
        var sentences = getAllSentences()
        sentences.insert(.init(sentence: sentence, groupId: groupId, uts: Date().timeIntervalSince1970), at: 0)
        Storage.saveObj(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, sentences)
    }
    
    static func updateSentence(old: SavedSentence, to sentence: String){
        var sentences = getAllSentences()
        var new = old
        new.sentence = sentence
        sentences.removeAll(where: {$0 == old})
        sentences.insert(new, at: 0)
        Storage.saveObj(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, sentences)
    }
    
    static func moveSentence(old: SavedSentence, to index: Int){
        var sentences = getAllSentences()
        var new = old
        new.groupId = index
        sentences.removeAll(where: {$0 == old})
        sentences.insert(new, at: 0)
        Storage.saveObj(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, sentences)
    }
    
    static func deleteSentence(sentence: SavedSentence){
        var sentences = getAllSentences()
        sentences.removeAll(where: {$0 == sentence})
        Storage.saveObj(suiteName: Configs.Env.AppGroup, Configs.Storage.sentences, sentences)
    }
}
