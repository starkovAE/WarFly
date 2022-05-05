//
//  ParentScene.swift
//  WarFly
//
//  Created by Александр Старков on 05.05.2022.
//

import SpriteKit
//РОДИТЕЛЬСКАЯ СЦЕНА

class ParentScene: SKScene {
    
    let sceneManager = SceneManager.shared //получили единственный экземпляр
    var backScene: SKScene?  //свойство сцены - которая была предыдущей (опциональнаяБ потому что не все сцены требуют возврата)
    
    //MARK: - функция, которая устанавливает заголовок
    func setHeader(withName name: String?, andBackground backgroundName: String) {
        
        let header = ButtonNode(titled: name, backgroundName: backgroundName)
        header.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
        self.addChild(header)
        
        
    }
    func setColorBackground(redColor red: CGFloat, greenColor green: CGFloat, blueColor blue: CGFloat, alphaPosition alpha: CGFloat ) {
        self.backgroundColor = SKColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}
