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
        
        //острова:
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
