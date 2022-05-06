//
//  GameOverScene.swift
//  WarFly
//
//  Created by Александр Старков on 06.05.2022.
//

import SpriteKit

class GameOverScene: ParentScene {
    override func didMove(to view: SKView) {
        
        setHeader(withName: "game over", andBackground: "header_background")
        //Нормальная запись
        let titles = ["restart", "options", "best"]
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
            sceneManager.gameScene = nil //удаляем из gameScene - нашу сцену
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(gameScene, transition: transition) //осуществляем сам переход
            
        } else if node.name == "best" { //если имя соответсует resume - мы должны вернуться на старую сцену
            
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            let bestScene = BestScene(size: self.size)
            bestScene.backScene = self
            bestScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(bestScene, transition: transition) //осуществляем сам переход
            
        } else if node.name == "options" {
            
            let transition = SKTransition.crossFade(withDuration: 1.0)
            let optionScene = OptionsScene(size: self.size) //указываем, что размер сцены будет такой же как и текущая сцена
            optionScene.backScene = self //здесь происходит, что текущая сцена (PauseScene) будет обратной для optionScene
            optionScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(optionScene, transition: transition) //осуществляем сам переход
        }
    }
    
}
