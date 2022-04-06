//
//  Island.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgroundSpriteable {
    static func polulateSpite(at point: CGPoint) -> Island {
        let islandImgeName = configureIslandName()
        let island = Island(imageNamed: islandImgeName)
        island.setScale(randomScaleFactor)
        island.position = point
        island.zPosition = 1 //zPosition - величина отностельно родителя (выше фона)
        island.run(rotateForRandomAngle())
        
        return island
    }
    //MARK: - Конфигурирует изображения острова
    static func configureIslandName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4) //так как у нас 4 изображения
         let randomNumber = distribution.nextInt()
        let imageName = "is" + "\(randomNumber)"
        
        return imageName
    }
    //MARK: - Конфигурирует масштаб острова
    static var randomScaleFactor: CGFloat {
       let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    //MARK: - Конфигурирует вращение острова
    static func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
         let randomNumber = CGFloat(distribution.nextInt())
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)// вызываем метод который будет вращать острова (передаем ему значение в радианах, делаем duration = 0, чтобы острова сразу же при появлении вращались)
    
    }
}
