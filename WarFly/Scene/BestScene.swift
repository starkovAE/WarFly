//
//  BestScene.swift
//  WarFly
//
//  Created by Александр Старков on 05.05.2022.
//

import SpriteKit

class BestScene: ParentScene {

//    let score = HUD()
//    "\(score.scoreLabel)"
    
    override func didMove(to view: SKView) {
        
        setColorBackground(redColor: 0.15, greenColor: 0.15, blueColor: 0.3, alphaPosition: 1.0)
        
        setHeader(withName: "best", andBackground: "header_background")
       
        let back = ButtonNode(titled: "back", backgroundName: "button_background")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100) //размещаем кнопку на экране
        back.name = "back" //даем имя
        back.label.name = "back"
        addChild(back) //добавляем на сцену
        
        let currentScore = ButtonNode(titled: "10000", backgroundName: "button_background")
        currentScore.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 10) //размещаем кнопку на экране
        currentScore.name = "currentScore" //даем имя
        currentScore.label.name = "currentScore"
        addChild(currentScore) //добавляем на сцену
                
    }
  
    
    //MARK: - touchesBegan() метод касаний (проверяем какую кнопку нажали)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }//касание внутри этой сцены (self)
        let node = self.atPoint(location)
        
      if node.name == "back" { //если имя соответсует resume - мы должны вернуться на старую сцену
            
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition) //осуществляем сам переход
        }
    }

}
