//
//  PauseScene.swift
//  WarFly
//
//  Created by Александр Старков on 29.04.2022.
//

import SpriteKit

class PauseScene: SKScene {
    override func didMove(to view: SKView) {
    
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        
        
        let header = ButtonNode(titled: "pause", backgroundName: "header_background")
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
        
        //Нормальная запись
        let titles = ["restart", "options", "resume"]
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
        
    }
    
    //MARK: - touchesBegan() метод касаний
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }//касание внутри этой сцены (self)
        let node = self.atPoint(location)
        
        if node.name == "restart" { //если свойство имени равно  = runButton
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition) //осуществляем сам переход
        }
    }
    
    
}


