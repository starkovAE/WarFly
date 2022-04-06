//
//  Cloud.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable { //прилоагательное, которым мы сможем назвать наш объект если он подписан на этот протокол
    static func polulateSpite(at point: CGPoint) -> Self
    
}

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    static  func polulateSpite(at point: CGPoint) -> Cloud {
        let cloudImgeName = configureName()
        let cloud = Cloud(imageNamed: cloudImgeName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point
        cloud.zPosition = 10 //чтобы был зазор, вдруг чего добавим

        
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
}
