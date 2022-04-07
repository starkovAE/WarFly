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
    let motionManager = CMMotionManager() //отслеживание поворотов устройства
    var xAcceleration: CGFloat = 0 //для трансформации поворотов в скорость нашего самолета
    let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)//размеры экрана
    
    //Создаем массивы текстур (для анимации полета самолета)
    var leftTextureArrayAnimation = [SKTexture]()
    var rightTextureArrayAnimation = [SKTexture]()
    var forwardTextureArrayAnimation = [SKTexture]()
    
    var moveDiraction: TurnDiraction = .none //(пер.)движение направления
    var stillTurning = false //начался ли у нас уже поворот
    
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
    //MARK: - performFly() - выполнение полета (основной метод)
    func performFly() {
        
        planeAnimationFillArray() //перед тем, как полетели. Нужно подгрузить текстуры
        motionManager.accelerometerUpdateInterval = 0.2 //как часто акселерометр должен обновлять ускорения
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { [unowned self] data, error in //data - это данные которые получим с сенсоров
            if let data = data { //если получили данные, извлекаем их в локальную дата
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3 //получаем данные акселерометра и немного убавляем их (делаем их не линейными, немного искажаем)
                print(self.xAcceleration)
            }
        }
        let plainWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDiractionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionsCheck()
        }
        
        let plainSequence = SKAction.sequence([plainWaitAction, planeDiractionCheckAction]) //создали последовательность акшинов(действий)
        let planeSequenceForever = SKAction.repeatForever(plainSequence)// будем вызвать их постоянно (бесконечно)
        self.run(planeSequenceForever)
 
        
        
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
                
                var array = [SKTexture]() //пустой массив
                let texture = SKTexture(imageNamed: "airplane_3ver2_13")
                array.append(texture) //получился массив из текстур
                
                SKTexture.preload(array, withCompletionHandler: {
                    print("preload is done")
                })
                return array
            } ()
            
        }
    }
    //MARK: - movementDirectionsCheck() - позволяет определить в какую сторону запускать анимацию
    private func movementDirectionsCheck() {
        if xAcceleration > 0.02, moveDiraction != .right, stillTurning == false { //наклоняем телефон направо, и если мы еще не выполнили этот поворот направо, то мы его выполняем
            stillTurning = true
            moveDiraction = .right
            turnPlain(diraction: .right)
            //анимация будет выполняться один раз в одну сторону
        } else if xAcceleration < -0.02, moveDiraction != .left, stillTurning == false { //если полет влево
            stillTurning = true
            moveDiraction = .left
            turnPlain(diraction: .left)
        } else if stillTurning == false  { //если прямо, мы не хотим прерывать анимацию (stillTurning == false). После выполняется следующая анимация
            turnPlain(diraction: .none)
        }
    }
    
    //MARK: - Метод отвечат за запуск аницаию для каждого  конретного направления
    //этот метод вызывается для каждого конкретного поворота
    private func turnPlain(diraction: TurnDiraction) { //(пер.) поворот самолета
        var array = [SKTexture]()
        if diraction == .right {
            array = rightTextureArrayAnimation // этот массив - это временное хранилище текстур направления самолета
        } else if diraction == .left {
            array = leftTextureArrayAnimation
        } else {
            array = forwardTextureArrayAnimation
        }
        let forwardAction = SKAction.animate(withNormalTextures: array, timePerFrame: 0.05, resize: true, restore: false)//прямая анимация
        let backwardAction = SKAction.animate(withNormalTextures: array.reversed(), timePerFrame: 0.05, resize: true, restore: false) //reversed - позволяет развернуть массив, для использования его задом на перед ОБРАТНАЯ АНИМАЦИЯ
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction]) //создаем последовательность, чтобы анимации не накладывались
        self.run(sequenceAction) { [unowned self] in //здесь запускаем анимацию,после того как она завершается. говорим что поворот окончен. И тем самым говорим, что можно запускать новую анимацию.
            self.stillTurning = false
        }
        
    }
    
} //закрывает класс

//MARK: - Enum TurnDiraction - смена направления (поворот)
enum TurnDiraction {
    case left
    case right
    case none
}

