//
//  Cloud.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable { //прилоагательное, которым мы сможем назвать наш объект если он подписан на этот протокол
    static func polulate() -> Self
    static func randomPoint() -> CGPoint

    
}
//сделаем расширение для протокола
extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        //destribution - нужен для вычисления y
        let destribution = GKRandomDistribution(lowestValue: Int(screen.size.height + 100), highestValue: Int(screen.size.height + 200))
        let y = CGFloat(destribution.nextInt())
        //вычисление х
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y) //возвращаем рандомную точку (которая по у располагается от 100 до 200 выше экрана, а по х от 0 до ширины экрана по горизонтали)
    }
}


final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    static  func polulate() -> Cloud {
        let cloudImgeName = configureName()
        let cloud = Cloud(imageNamed: cloudImgeName)
        cloud.setScale(randomScaleFactor)
        cloud.position = randomPoint()
        cloud.zPosition = 10 //чтобы был зазор, вдруг чего добавим

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
