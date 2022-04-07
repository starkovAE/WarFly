//
//  Cloud.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import GameplayKit
final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    static  func polulate(at point: CGPoint?) -> Cloud {
        let cloudImgeName = configureName()
        let cloud = Cloud(imageNamed: cloudImgeName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.zPosition = 10 //чтобы был зазор, вдруг чего добавим
        cloud.name = "backgroundSprite"
        cloud.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        cloud.run(move(from: cloud.position))
        
        return cloud
    }
    //MARK: - Конфигурирует изображения облака
    static private func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3) //так как у нас 4 изображения
         let randomNumber = distribution.nextInt()
        let imageName = "cl" + "\(randomNumber)"
        
        return imageName
    }
    //MARK: - Конфигурирует масштаб облака
    static private var randomScaleFactor: CGFloat {
       let distribution = GKRandomDistribution(lowestValue: 20, highestValue: 30)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    //MARK: - move() отвечает за движение облаков
    private static func move(from point: CGPoint) -> SKAction {
        //точка в которую происходит движение
        let movePoint = CGPoint(x: point.x, y: -200) //x не меняется ( по х одно значение) объект движется к нижней точке экрана - 200
        //исходная позиция
        let moveDistance = point.y + 200
        //начальная скорость
        let moveSpeed: CGFloat = 150.0
        let duration = moveDistance / moveSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
        
    }
}
