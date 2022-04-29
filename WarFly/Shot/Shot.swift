//
//  Shot.swift
//  WarFly
//
//  Created by Александр Старков on 11.04.2022.
//

import SpriteKit

class Shot: SKSpriteNode {
    
    let screenSize = UIScreen.main.bounds
    
    private let initialSize = CGSize(width: 187, height: 237)
    private let textureAtlas: SKTextureAtlas!
    private var textureNameBeginWith = "" //с чего начинается имя текстуры
    private var animationSpriteArray = [SKTexture]()
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeginWith = String(textureName.dropLast(6)) //откидыаем 6 символов из строки 01.png
        super.init(texture: texture, color: .clear, size: initialSize)
        self.setScale(0.3)
        self.name = "shotSprite"
        self.zPosition = 30 //чтобы встрел были над всеми, кроме самолета
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskCategory.shot.rawValue
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy.rawValue
        self.physicsBody?.contactTestBitMask = BitMaskCategory.enemy.rawValue
    }
    
    //MARK: - startMovement() - выполнение вертикального движения
    func startMovement() {
        performRotation()
        
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2) //движение в течении 5 секунд от заданой точки до у равному -100
        self.run(moveForward)
    }
    
    
    //MARK: - performRotation() - выполнение вращения (анимации)
  private func performRotation() {
        
        for i in 1...32 {
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


