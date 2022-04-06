//
//  Background.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit

class Background: SKSpriteNode { //фон

    static func populateBackground(at point: CGPoint) -> Background {
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0 //для очередности объектов
        return background
    }
}
