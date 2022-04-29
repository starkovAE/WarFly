//
//  MenuScene.swift
//  WarFly
//
//  Created by Александр Старков on 11.04.2022.
//

import SpriteKit

class MenuScene: SKScene {
    
//MARK: - didMove(to view:)
    override func didMove(to view: SKView) {
        if Assets.shared.isLoaded {
            Assets.shared.preloadAssets() // подгружаем атласы
            Assets.shared.isLoaded = true
        }
    
        self.backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
        let header = SKSpriteNode(imageNamed: "header1")
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
        
        //Нормальная запись 
        let titles = ["play", "options", "best"]
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(100 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
        //Длинный вариант
        
//        let button1 = ButtonNode(titled: "play", backgroundName: "button_background")
//        button1.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        button1.name = "play"
//        button1.label.name = "play"
//        addChild(button1)
//        
//        let button2 = ButtonNode(titled: "options", backgroundName: "button_background")
//        button2.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100)
//        button2.name = "options"
//        button2.label.name = "options"
//        addChild(button2)
//        
//        let button3 = ButtonNode(titled: "best", backgroundName: "button_background")
//        button3.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200)
//        button3.name = "best"
//        button3.label.name = "best"
//        addChild(button3)
    }
    
    //MARK: - touchesBegan() метод касаний
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }//касание внутри этой сцены (self)
        let node = self.atPoint(location)
        
        if node.name == "play" { //если свойство имени равно  = runButton
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition) //осуществляем сам переход
        }
    }
    
    
}
