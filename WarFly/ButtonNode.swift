//
//  ButtonNode.swift
//  WarFly
//
//  Created by Александр Старков on 29.04.2022.
//

import SpriteKit

class ButtonNode: SKSpriteNode {
//Создаем ярлык
    let label: SKLabelNode = {
        let l = SKLabelNode(text: "Whatever")
        l.fontColor = UIColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1)
        l.fontName = "AmericanTypewriter-Bold"
        l.fontSize = 30
        l.horizontalAlignmentMode = .center
        l.verticalAlignmentMode = .center
        l.zPosition = 2
        return l
    } ()
    
    init(titled title: String, backgroundName: String) {
        let texture = SKTexture(imageNamed: backgroundName)
        super.init(texture: texture, color: .clear, size: texture.size())
        label.text = title.uppercased()
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
