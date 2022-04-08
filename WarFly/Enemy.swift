//
//  Enemy.swift
//  WarFly
//
//  Created by Александр Старков on 08.04.2022.
//

import SpriteKit

class Enemy: SKSpriteNode {

    static var textureAtlas: SKTextureAtlas?
    
    init() {
        let texture = Enemy.textureAtlas?.textureNamed("airplane_4ver2_13")
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5 //изображение смотрит вверх - поэтому мы меняем направление (отобразим самолет вертикально)
        self.zPosition = 20
        self.name = "Sprite"
        
    }
    //MARK: - flySpiral() - метод, полета по спирали
    func flySpiral() {
        let screenSize = UIScreen.main.bounds  //размеры экрана
        let timeHorizotal: Double = 3
        let timeVertical: Double = 10

        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizotal) //50 - из за размеров самолета
        moveLeft.timingMode = .easeInEaseOut //чтобы не было такого сильного отскока от границ
        let moveRight = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizotal)
        moveRight.timingMode = .easeInEaseOut
        let asideMovementSequence = SKAction.sequence([moveLeft, moveRight])
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
    
}
