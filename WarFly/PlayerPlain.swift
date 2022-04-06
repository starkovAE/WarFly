//
//  PlayerPlain.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit

class PlayerPlain: SKSpriteNode {
    
    static func populate(at point: CGPoint) -> SKSpriteNode {
        //текстура может меняться, а изображение нет
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlain = SKSpriteNode(texture: playerPlaneTexture)
        playerPlain.setScale(0.5) //масштаб
        playerPlain.position = point
        playerPlain.zPosition = 20
        return playerPlain
    }
    
    
    
}
