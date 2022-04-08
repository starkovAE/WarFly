//
//  PowerUp.swift
//  WarFly
//
//  Created by Александр Старков on 08.04.2022.
//

import SpriteKit

class BluePowerUp: PowerUp {
    
    init() {
        let textureAtlas = SKTextureAtlas(named: "BluePowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GreenPowerUp: PowerUp {
    init() {
        let textureAtlas = SKTextureAtlas(named: "GreenPowerUp")
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PowerUp: SKSpriteNode {
    
    let initialSize = CGSize(width: 52, height: 52)
    let textureAtlas: SKTextureAtlas!
    var textureNameBeginWith = "" //с чего начинается имя текстуры
    var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0] //не работает 
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeginWith = String(textureName.dropLast(6)) //откидыаем 6 символов из строки 01.png
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.7)
        self.name = "powerUp"
        self.zPosition = 20
    }
    
    
    //MARK: - performRotation() - выполнение вращения (анимации)
    func performRotation() {
        
        for i in 1...15 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeginWith + number.description))
        }
        //загружаем текстуры
        SKTexture.preload(animationSpriteArray) { //этот код выполнится после того как массив animationSpriteArray загрузится
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false) //with -  массив, который мы хотим анимировать, timePerFrame - разница между кадрами (в секундах), resize - изменение размера в процессе анимации, restore -  возвращение в первоначальное состояние после прохождения последнего frame
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        
            
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}//закрывает класс
