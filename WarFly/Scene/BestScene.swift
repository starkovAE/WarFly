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
    var places = [10, 100, 10000]
    override func didMove(to view: SKView) {
 
        setHeader(withName: "best", andBackground: "header_background")
       
        let titles = ["back"]
        for (index, title) in titles.enumerated() {
            let button = ButtonNode(titled: title, backgroundName: "button_background")
            button.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 200 + CGFloat(100 * index))
            button.name = title
            button.label.name = title
            addChild(button)
        }
        
        let topPlaces = places.sorted { $0 > $1 }.prefix(3) // элемент слева чтобы был больше чем справа, обрезаем массив до 3 элементов
        
        for (index, value) in topPlaces.enumerated() {
            
            let topResult = SKLabelNode(text: value.description)
            topResult.fontColor = UIColor(red: 219/255, green: 226/255, blue: 215/255, alpha: 1)
            topResult.fontName = "AmericanTypewriter-Bold"
            topResult.fontSize = 30
            topResult.position = CGPoint(x: self.frame.midX, y: self.frame.midY - CGFloat(index * 60)) //в зависимости от индекса будет расположение ниже
            addChild(topResult)
          
        }      
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
