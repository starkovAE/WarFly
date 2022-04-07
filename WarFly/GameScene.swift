//
//  GameScene.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    //создаем менеджера управления положения телефона
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    
    //создаем игрока
var player: SKSpriteNode!
    override func didMove(to view: SKView) {
        
        configurateStartScene()
        spawnClouds()
        spawnIsland()
      
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
        
        //создаем облако и добавляем его на экран
//        let cloud = Cloud.polulate()
//        self.addChild(cloud)
//        
        player = PlayerPlain.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        
        
        motionManager.accelerometerUpdateInterval = 0.2 //как часто акселерометр должен обновлять ускорения
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in //data - это данные которые получим с сенсоров
            if let data = data { //если получили данные, извлекаем их в локальную дата
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3 //получаем данные акселерометра и немного убавляем их (делаем их не линейными, немного искажаем)
            }
        }
    }
    //MARK: - Метод srawnClouds(), который будет генирировать облака
    private func spawnClouds() {
        let spawnCloudWait = SKAction.wait(forDuration: 1) //каждую секунду будет генерироваться облако
        let spawnCloudAction = SKAction.run { //внутри этого блока кода будет создаваться свое облако
            let cloud = Cloud.polulate() //срабатывает метод populate с рандомным созданием точки
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
            let island = Island.polulate() //срабатывает метод populate с рандомным созданием точки
            self.addChild(island)
        }
        //нужно создать последовательность, которая будет
        let spawnIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spawnIslandForever = SKAction.repeatForever(spawnIslandSequence) //метод, который повторяет действия вечно
        
        run(spawnIslandForever)
        
    }
    //MARK: - didSimulatePhysics (после симуляции) - отрабатывает, когда вся физика была просчитана для определенного кадра
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        //перемещение самолета
        player.position.x += xAcceleration * 50
        //ограничение самолета по границе экрана
        if player.position.x < -70 { //если самолет зашел налево на - 70
            player.position.x = self.size.width + 70 //мы добавляем к его правойпозиции, позицию экрана + 70
        } else if player.position.x > self.size.width + 70 { //если ушел направо на 70
            player.position.x = -70 //вычитаем  70
        }
        
    }
}
