//
//  HUD.swift
//  WarFly
//
//  Created by Александр Старков on 29.04.2022.
//

import SpriteKit

class HUD: SKScene {
    //MARK: - Элементы пользовательского интерфейса
    let scoreBacground = SKSpriteNode(imageNamed: "scores")
    let scoreLabel = SKLabelNode(text: "10000")
    let menuButton = SKSpriteNode(imageNamed: "menu")
    let life1 = SKSpriteNode(imageNamed: "life")
    let life2 = SKSpriteNode(imageNamed: "life")
    let life3 = SKSpriteNode(imageNamed: "life")
    
    //MARK: - configureUI()
    func configureUI(screenSize: CGSize) {
        scoreBacground.position = CGPoint(x: scoreBacground.size.width + 10, y: screenSize.height - scoreBacground.size.height / 2 - 25)
        scoreBacground.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        scoreBacground.zPosition = 99
        addChild(scoreBacground)
        
        scoreLabel.horizontalAlignmentMode = .right // выравнивание по горизонтали
        scoreLabel.verticalAlignmentMode = .center //по вертикали
        scoreLabel.position = CGPoint(x: -10, y: 3)
        scoreLabel.zPosition = 100
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 30
        scoreBacground.addChild(scoreLabel)//помещаем на scoreBacground
        
        menuButton.position = CGPoint(x: 20, y: 20)
        menuButton.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        menuButton.zPosition = 100
        addChild(menuButton)
        
        let lifes = [life1,life2,life3]
        for (index, life) in lifes.enumerated() { //enumerated() - возращает не только элемент массива но  и его индекс
            life.position = CGPoint(x: screenSize.width - CGFloat(index + 1) * (life.size.width + 3), y: 20)
            life.zPosition = 100
            life.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            addChild(life)
        }
        
        
        
        
    }
}
