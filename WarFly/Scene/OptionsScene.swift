//
//  OptionsScene.swift
//  WarFly
//
//  Created by Александр Старков on 05.05.2022.
//

import SpriteKit

class OptionsScene: ParentScene {
    
    override func didMove(to view: SKView) {
      
        setHeader(withName: "options", andBackground: "header_background")
        
        
        let music = ButtonNode(titled: nil, backgroundName: "music")
        music.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY) //размещаем кнопку на экране
        music.name = "music" //даем имя
        music.label.isHidden = true //прячем ярлык
        addChild(music) //добавляем на сцену
        
        let sound = ButtonNode(titled: nil, backgroundName: "sound")
        sound.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY) //размещаем кнопку на экране
        sound.name = "sound" //даем имя
        sound.label.isHidden = true //прячем ярлык
        addChild(sound) //добавляем на сцену
        
        let back = ButtonNode(titled: "back", backgroundName: "button_background")
        back.position = CGPoint(x: self.frame.midX, y: self.frame.midY - 100) //размещаем кнопку на экране
        back.name = "back" //даем имя
        back.label.name = "back"
        addChild(back) //добавляем на сцену
        
        
    }
  
    
    //MARK: - touchesBegan() метод касаний (проверяем какую кнопку нажали)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else { return }//касание внутри этой сцены (self)
        let node = self.atPoint(location)
        
        if node.name == "music" {
           print("music")
            
        } else if node.name == "sound" {
            print("sound")
        } else if node.name == "back" { //если имя соответсует resume - мы должны вернуться на старую сцену
            
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition) //осуществляем сам переход
        }
    }
}
