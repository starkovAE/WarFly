//
//  ParentScene.swift
//  WarFly
//
//  Created by Александр Старков on 05.05.2022.
//

import SpriteKit
//РОДИТЕЛЬСКАЯ СЦЕНА

class ParentScene: SKScene {
    
    let gameSettings = GameSettings() //теперь есть доступ к этому классу из любого класса наследника
    let sceneManager = SceneManager.shared //получили единственный экземпляр
    var backScene: SKScene?  //свойство сцены - которая была предыдущей (опциональнаяБ потому что не все сцены требуют возврата)
    
    //MARK: - функция, которая устанавливает заголовок
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
        
        
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor(red: 0.15, green: 0.15, blue: 0.3, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
