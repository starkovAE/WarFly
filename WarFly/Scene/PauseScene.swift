//
//  PauseScene.swift
//  WarFly
//
//  Created by Александр Старков on 29.04.2022.
//

import SpriteKit

class PauseScene: ParentScene {
    
    override func didMove(to view: SKView) {
        
        setColorBackground(redColor: 0.15, greenColor: 0.15, blueColor: 0.3, alphaPosition: 1.0)
        
        setHeader(withName: "pause", andBackground: "header_background")
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
    //MARK: - update() - метод обновления сцены (60 раз в секунду)
    override func update(_ currentTime: TimeInterval) {
        if let gameScene = sceneManager.gameScene {
            if !gameScene.isPaused  { //если это равно false
                gameScene.isPaused = true //сделаем тру
                print("changedd")
            }
        }
    }
    
    //MARK: - touchesBegan() метод касаний
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }//касание внутри этой сцены (self)
        let node = self.atPoint(location)
        
        if node.name == "restart" { //если свойство имени равно  = runButton
            sceneManager.gameScene = nil //удаляем из gameScene - нашу сцену
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition) //осуществляем сам переход
            
        } else if node.name == "resume" { //если имя соответсует resume - мы должны вернуться на старую сцену
            
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            guard let gameScene = sceneManager.gameScene else { return }
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition) //осуществляем сам переход
            
        } else if node.name == "options" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let optionScene = OptionsScene(size: self.size) //указываем, что размер сцены будет такой же как и текущая сцена
            optionScene.backScene = self //здесь происходит, что текущая сцена (PauseScene) будет обратной для optionScene
            optionScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(optionScene, transition: transition) //осуществляем сам переход
        }
    }
    
    
}


