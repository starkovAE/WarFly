//
//  PlayerPlain.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//

import SpriteKit
import CoreMotion

class PlayerPlain: SKSpriteNode {
    
    //создаем менеджера управления положения телефона
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    //Создаем массивы текстур (для анимации полета самолета)
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    
    static func populate(at point: CGPoint) -> PlayerPlain {
        //текстура может меняться, а изображение нет
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlain = PlayerPlain(texture: playerPlaneTexture)
        playerPlain.setScale(0.5) //масштаб
        playerPlain.position = point
        playerPlain.zPosition = 20
        return playerPlain
    }
  //MARK: - checkPosition() - отвечает за  проверку позции самолета
    func checkPosition() {
        //перемещение самолета
        self.position.x += xAcceleration * 50
        //ограничение самолета по границе экрана
        if self.position.x < -70 { //если самолет зашел налево на - 70
            self.position.x = screenSize.width + 70 //мы добавляем к его правойпозиции, позицию экрана + 70
        } else if self.position.x > screenSize.width + 70 { //если ушел направо на 70
            self.position.x = -70 //вычитаем  70
        }
    }
    //MARK: - performFly() - выполнение полета
    func performFly() {
        planeAnimationFillArray() //перед тем, как полетели. Нужно подгрузить текстуры
        motionManager.accelerometerUpdateInterval = 0.2 //как часто акселерометр должен обновлять ускорения
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in //data - это данные которые получим с сенсоров
            if let data = data { //если получили данные, извлекаем их в локальную дата
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3 //получаем данные акселерометра и немного убавляем их (делаем их не линейными, немного искажаем)
            }
        }
        
    }
    //MARK: - planeAnimationFillArray() - метод, наполнения массивов для анимации
    private func planeAnimationFillArray() {
        SKTextureAtlas.preloadTextureAtlases([SKTextureAtlas(named: "PlayerPlane")]) {
        
            self.leftTextureArrayAnimation = { //значение этого массива - это будет то, что возвращается из этого массива
                
                var array = [SKTexture]() //путсой массив
                for i in stride(from: 13, through: 1, by: -1) { //перебираем от 13 до 1 с шагом - 1 (для левого поворота)
                    let number = String(format: "%02d", i) //наше число должно быть преобразовано в строку со следующим видом
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture) //получился массив из текстур
                }
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
            } ()
        
            self.rightTextureArrayAnimation = {
                
                var array = [SKTexture]() //путсой массив
                for i in stride(from: 13, through: 26, by: 1) {
                    let number = String(format: "%02d", i) //наше число должно быть преобразовано в строку со следующим видом
                    let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
                    array.append(texture) //получился массив из текстур
                }
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
            } ()
            
            self.forwardTextureArrayAnimation = {
                
                var array = [SKTexture]() //путсой массив
                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
                array.append(texture) //получился массив из текстур
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
            } ()
            
            
        }
        
    }
}
