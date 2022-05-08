//
//  GameSettings.swift
//  WarFly
//
//  Created by Александр Старков on 08.05.2022.
//

import SpriteKit

class GameSettings: NSObject {
    let ud = UserDefaults.standard
    
    var isMusic = true
    var isSound = true
    
    
    let musicKey = "music"
    let soundKey = "sound"
    override init() {
        super.init()
        
        loadGameSettings()
    }
    func saveGameSettings() {
        ud.set(isMusic, forKey: musicKey)
        ud.set(isSound, forKey: soundKey)
    }
    func loadGameSettings() {
        guard ud.value(forKey: musicKey) != nil && ud.value(forKey: soundKey) != nil else { return } //проверяем наличие значений
        isMusic = ud.bool(forKey: musicKey)
        isSound = ud.bool(forKey: soundKey)
    }
}
