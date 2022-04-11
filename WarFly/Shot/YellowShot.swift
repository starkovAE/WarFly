//
//  YellowShot.swift
//  WarFly
//
//  Created by Александр Старков on 11.04.2022.
//

import SpriteKit

class YellowShot: Shot {
    init() {
        
        let textureAtlas = Assets.shared.yellowAmmoAtlas
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
