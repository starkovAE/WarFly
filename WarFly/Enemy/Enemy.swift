//
//  Enemy.swift
//  WarFly
//
//  Created by Александр Старков on 08.04.2022.
//

import SpriteKit

class Enemy: SKSpriteNode {

    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    
    init(enemyTexture: SKTexture) {
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5 //изображение смотрит вверх - поэтому мы меняем направление (отобразим самолет вертикально)
        self.zPosition = 20
        self.name = "Sprite"
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = BitMaskCategory.enemy
        self.physicsBody?.collisionBitMask = BitMaskCategory.player | BitMaskCategory.shot
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player | BitMaskCategory.shot
        
    }
    //MARK: - flySpiral() - метод, полета по спирали
    func flySpiral() {
        let screenSize = UIScreen.main.bounds  //размеры экрана
        let timeHorizotal: Double = 3
        let timeVertical: Double = 5

        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizotal) //50 - из за размеров самолета
        moveLeft.timingMode = .easeInEaseOut //чтобы не было такого сильного отскока от границ
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizotal)
        moveRight.timingMode = .easeInEaseOut
        
        let randomNumber = Int(arc4random_uniform(2))//работает от 0  до указанного числа (но не включает указанное число)
        //если randomNumber равен 0, значит мы летим налево, если нет направо
        //ИПОЛЬЗУЕМ ТЕРНАРНЫЙ ОПЕРАТОР
        let asideMovementSequence = randomNumber == EnemyDiraction.left.rawValue ? SKAction.sequence([moveLeft, moveRight]): SKAction.sequence([moveRight, moveLeft])
        
        //randomNumber == EnemyDiraction.left.rawValue - условие
       //если true - SKAction.sequence([moveLeft, moveRight])
        
        let foreverAsideMovement = SKAction.repeatForever(asideMovementSequence)
        //Движение вертикально
        let forwardMovemet = SKAction.moveTo(y: -105, duration: timeVertical)
        //создаем группу движения
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovemet])
        
        self.run(groupMovement)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}//закрывает класс

enum EnemyDiraction: Int {
    case left = 0 //если присовили здесь 0, значит, автоматом присвоилось ниже 1
    case right
}

