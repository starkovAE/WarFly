//
//  Island.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgroundSpriteable {
    
    static func polulate(at point: CGPoint?) -> Island {
        let islandImgeName = configureIslandName()
        let island = Island(imageNamed: islandImgeName)
        island.setScale(randomScaleFactor)
        island.position = point ?? randomPoint()
        island.zPosition = 1 //zPosition - величина отностельно родителя (выше фона)
        island.run(rotateForRandomAngle())
        island.name = "Sprite" //у этих спрайтов теперь есть имя
        island.anchorPoint = CGPoint(x: 0.5, y: 1.0) //хотим, чтобы когда верхняя граница node уходит за пределы экрана, тогда он сможет удалилться
        island.run(move(from:  island.position)) //вызвали метод
        return island
    }
    //MARK: - Конфигурирует изображения острова
    private static  func configureIslandName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4) //так как у нас 4 изображения
         let randomNumber = distribution.nextInt()
        let imageName = "is" + "\(randomNumber)"
        
        return imageName
    }
    //MARK: - Конфигурирует масштаб острова
    private static  var randomScaleFactor: CGFloat {
       let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    //MARK: - Конфигурирует вращение острова
    private static  func rotateForRandomAngle() -> SKAction {
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
         let randomNumber = CGFloat(distribution.nextInt())
        return SKAction.rotate(toAngle: randomNumber * CGFloat(Double.pi / 180), duration: 0)// вызываем метод который будет вращать острова (передаем ему значение в радианах, делаем duration = 0, чтобы острова сразу же при появлении вращались)
    
    }
    //MARK: - Конфигурируем перемещение
    private static func move(from point: CGPoint) -> SKAction {
        //точка в которую происходит движение
        let movePoint = CGPoint(x: point.x, y: -200) //x не меняется ( по х одно значение) объект движется к нижней точке экрана - 200
        //исходная позиция
        let moveDistance = point.y + 200
        //начальная скорость
        let moveSpeed: CGFloat = 100.0
        let duration = moveDistance / moveSpeed
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
        
    }
}
