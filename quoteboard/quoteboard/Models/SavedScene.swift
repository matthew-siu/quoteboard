//
//  SavedScene.swift
//  quoteboard
//
//  Created by Matthew Siu on 28/6/2022.
//

import Foundation

typealias SavedScenes = [SavedScene]

struct SavedScene: Codable{
    var groupIndex: Int
    var name: String
    var uts: Double
    
    static func getAllScenes() -> SavedScenes{
        return Storage.getObject(suiteName: Configs.Env.AppGroup, Configs.Storage.groups, to: SavedScenes.self) ?? []
    }
    
    static func renameScene(name: String, at index: Int){
        var scenes = self.getAllScenes()
        let scene = scenes.first(where: {$0.groupIndex == index}) ?? .init(groupIndex: index, name: name, uts: Date().timeIntervalSince1970)
        scenes.removeAll(where: {$0.groupIndex == index})
        scenes.append(scene)
        Storage.saveObj(suiteName: Configs.Env.AppGroup, Configs.Storage.groups, scenes)
    }
}
