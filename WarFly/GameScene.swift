//
//  GameScene.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let sprite = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
        sprite.position = CGPoint(x: 200, y: 200)
        print(anchorPoint)
        self.addChild(sprite)
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size //чтобы фон был по размеру экрана
        self.addChild(background) //добавляем на экран
        
        //острова:
        //узнаем размер экрана пользователя
        let screen = UIScreen.main.bounds
        for _  in 1...5 { //будет 5 островов на экране
            //создаем константу x, которая будет каждый раз конфигурироваться. Генирируем рандомное число, а потом указываем верхнюю границу по x
            let x: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
            let y: CGFloat = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.height)))
            //создаем остров
            let island = Island.polulateIsland(at: CGPoint(x: x, y: y))
            self.addChild(island)
        }
        
    }
}
