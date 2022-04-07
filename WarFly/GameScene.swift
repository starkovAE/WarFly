//
//  GameScene.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//ТУТ РЕАЛИЗАУЕТСЯ ВСЯ ЛОГИКА СЦЕНЫ

import SpriteKit
import GameplayKit


class GameScene: SKScene {

    //создаем игрока
var player: PlayerPlain!
    override func didMove(to view: SKView) {
        
        configurateStartScene()
        spawnClouds()
        spawnIsland()
        let deadLine = DispatchTime.now() + .nanoseconds(1) //создали время, которое наступит через 10^-9 сек
        DispatchQueue.main.asyncAfter(deadline: deadLine) { [unowned self] in //остраняем запуск на одну наносекунду
            self.player.performFly() //вызываем метод полета
        }
        
        let powerUp = PowerUp()
        powerUp.performRotation()
        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(powerUp)
        
        }
//MARK: - configurateStartScene()
    private func configurateStartScene() {
        let sprite = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
        sprite.position = CGPoint(x: 200, y: 200)
        print(anchorPoint)
        self.addChild(sprite)
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size //чтобы фон был по размеру экрана
        self.addChild(background) //добавляем на экран
        
        
        //узнаем размер экрана пользователя
        let screen = UIScreen.main.bounds
      
        //создаем остров
        let island1 = Island.polulate(at: CGPoint(x: 100, y: 200))
     
        self.addChild(island1)
        
        let island2 = Island.polulate(at: CGPoint(x: self.size.width - 100, y: self.size.height - 200))
    
        self.addChild(island2)
        

        player = PlayerPlain.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        
        
       
    }
    //MARK: - Метод srawnClouds(), который будет генирировать облака
    private func spawnClouds() {
        let spawnCloudWait = SKAction.wait(forDuration: 1) //каждую секунду будет генерироваться облако
        let spawnCloudAction = SKAction.run { //внутри этого блока кода будет создаваться свое облако
            let cloud = Cloud.polulate(at: nil) //срабатывает метод populate с рандомным созданием точки
            self.addChild(cloud)
        }
        //нужно создать последовательность, которая будет
        let spawnCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spawnCloudForever = SKAction.repeatForever(spawnCloudSequence) //метод, который повторяет действия вечно
        
        run(spawnCloudForever)
        
    }
    
    //MARK: - Метод srawnClouds(), который будет генирировать острова
    private func spawnIsland() {
        let spawnIslandWait = SKAction.wait(forDuration: 2) //каждую секунду будет генерироваться облако
        let spawnIslandAction = SKAction.run { //внутри этого блока кода будет создаваться свое облако
            let island = Island.polulate(at: nil) //срабатывает метод populate с рандомным созданием точки
            self.addChild(island)
        }
        //нужно создать последовательность, которая будет
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence) //метод, который повторяет действия вечно
        
        run(spawnIslandForever)
        
    }
    //MARK: - didSimulatePhysics (после симуляции) - отрабатывает, когда вся физика была просчитана для определенного кадра
    override func didSimulatePhysics() {
        
        player.checkPosition() //вызываем метод
        
        enumerateChildNodes(withName: "backgroundSprite") { node, stop in //node - это сам объхект, который мы получили при переборе, stop - это флаг, который возвращает либо тру либо фолс
            if node.position.y < -199 {
                node.removeFromParent() //все node (облака и острова) ниже нуля будут удаляться
            }
        }
    }
}
