//
//  GreenPowerUp.swift
//  WarFly
//
//  Created by Александр Старков on 08.04.2022.
//

import SpriteKit
class GreenPowerUp: PowerUp {
    init() {
        let textureAtlas = Assets.shared.greenPowerUpAtlas
        super.init(textureAtlas: textureAtlas)
        name = "greenPowerUp"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
