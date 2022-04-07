//
//  GameBackgroundSpritable + Extention.swift
//  WarFly
//
//  Created by Александр Старков on 07.04.2022.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable { //прилоагательное, которым мы сможем назвать наш объект если он подписан на этот протокол
    static func polulate() -> Self
    static func randomPoint() -> CGPoint

    
}
//сделаем расширение для протокола
extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint { //данный метод позволяет использовать рандомные точки для генерации sprits
        let screen = UIScreen.main.bounds
        //destribution - нужен для вычисления y
        let destribution = GKRandomDistribution(lowestValue: Int(screen.size.height + 100), highestValue: Int(screen.size.height + 200))
        let y = CGFloat(destribution.nextInt())
        //вычисление х
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        return CGPoint(x: x, y: y) //возвращаем рандомную точку (которая по у располагается от 100 до 200 выше экрана, а по х от 0 до ширины экрана по горизонтали)
    }
}
