//
//  PowerUp.swift
//  WarFly
//
//  Created by Александр Старков on 08.04.2022.
//

import SpriteKit

class PowerUp: SKSpriteNode {
    
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
    var animationSpriteArray = [SKTexture]()
    
    init() {
        let greenTexture = textureAtlas.textureNamed("missle_green_01")
        super.init(texture: greenTexture, color: .clear, size: initialSize)
        self.name = "powerUp"
        self.zPosition = 20
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - performRotation() - выполнение вращения (анимации)
    func performRotation() {
        
        for i in 1...15 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: "missle_green_\(number)"))
        }
        //загружаем текстуры
        SKTexture.preload(animationSpriteArray) { //этот код выполнится после того как массив animationSpriteArray загрузится
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false) //with -  массив, который мы хотим анимировать, timePerFrame - разница между кадрами (в секундах), resize - изменение размера в процессе анимации, restore -  возвращение в первоначальное состояние после прохождения последнего frame
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        
            
        }
    }
    
    
    
    
    
    
}
