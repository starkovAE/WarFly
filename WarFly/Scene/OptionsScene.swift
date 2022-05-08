//
//  OptionsScene.swift
//  WarFly
//
//  Created by Александр Старков on 05.05.2022.
//

import SpriteKit

class OptionsScene: ParentScene {
    
var isMusic: Bool!
    var isSound: Bool!
    
    override func didMove(to view: SKView) {
      
        isMusic = gameSettings.isMusic
        isSound = gameSettings.isSound
        
        
        setHeader(withName: "options", andBackground: "header_background")
        
        let backgroundNameForMusic = isMusic == true ? "music": "nomusic" //проверяем тру или фолс (в зависимотси будет меняться картинка)
        
        let music = ButtonNode(titled: nil, backgroundName: backgroundNameForMusic)
        music.position = CGPoint(x: self.frame.midX - 50, y: self.frame.midY) //размещаем кнопку на экране
        music.name = "music" //даем имя
        music.label.isHidden = true //прячем ярлык
        addChild(music) //добавляем на сцену
        
        let backgroundNameForSound = isSound == true ? "sound" : "nosound"
        
        let sound = ButtonNode(titled: nil, backgroundName: backgroundNameForSound)
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
          isMusic = !isMusic
            updatePicture(node: node as! SKSpriteNode, property: isMusic)
        } else if node.name == "sound" {
            isSound = !isSound
            updatePicture(node: node as! SKSpriteNode, property: isSound)
        } else if node.name == "back" { //если имя соответсует resume - мы должны вернуться на старую сцену
            //когда мы надимаем кнопку выхода должно произойти сохранение настроик
            gameSettings.isMusic = isMusic
            gameSettings.isSound = isSound //присваиваем новые значения
    
            gameSettings.saveGameSettings()//сохраняем
            
            
            let transition = SKTransition.crossFade(withDuration: 1.0) //осуществляем переход - transition,  (crossFade - использует эффект расстворения и переходит на другую сцену)
            guard let backScene = backScene else { return }
            backScene.scaleMode = .aspectFill
            self.scene?.view?.presentScene(backScene, transition: transition) //осуществляем сам переход
        }
    }
    func updatePicture(node: SKSpriteNode, property: Bool) {
        if let name = node.name {
            node.texture = property ? SKTexture(imageNamed: name) : SKTexture(imageNamed: "no" + name)
        }
    }
}
