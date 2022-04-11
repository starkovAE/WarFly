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
        spawnPowerUp()
       // spawnEnemy(count: 5)
       spawnEmenies()
        }
    
    //MARK: - createPowerUp()
    private func spawnPowerUp() {
        //создаем powerUp
 
        let spawnAction = SKAction.run {
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? BluePowerUp() : GreenPowerUp()
            let randomPositionX = arc4random_uniform(UInt32(self.size.width - 30))
            
            powerUp.position = CGPoint(x: CGFloat(randomPositionX), y: self.size.height + 100) //происходит зарождения powerUp. на рандомной позции по оси х и по у = высота экрана + 100
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        
        let randomTimeSpawn = Double(arc4random_uniform(11) + 10) //создаются от 0 до 10 и потом еще + 10
        let waitAction = SKAction.wait(forDuration: randomTimeSpawn)
        
        self.run(SKAction.repeatForever(SKAction.sequence([spawnAction, waitAction])))
        
      
    }
    
    //MARK: - spawnEnemies()
    private func spawnEmenies() {
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        self.run(SKAction.repeatForever(SKAction.sequence([waitAction, spawnSpiralAction])))
    }
    
    
    
    
    //MARK: - spawnEnemy() - (пер.) порождать врагов
    private func spawnSpiralOfEnemies() {
        //создаем врага
        let enemyTextureAtlas1 = SKTextureAtlas(named: "Enemy_1")
        let enemyTextureAtlas2 = SKTextureAtlas(named: "Enemy_2")
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            
            let randomNumber = Int(arc4random_uniform(2)) //рандомное число. Либо 0 либо 1
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlases[randomNumber]
            
            let waitAction = SKAction.wait(forDuration: 1.0) //интервал ожидания порождения врагов
            let spawnEnemy = SKAction.run { [unowned self] in
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureNames[13]) //получили имя текстуры
                
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 110)
                self.addChild(enemy)
                enemy.flySpiral()
            }
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatAction)
        }
        
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
        
        enumerateChildNodes(withName: "Sprite") { node, stop in //node - это сам объхект, который мы получили при переборе, stop - это флаг, который возвращает либо тру либо фолс
            if node.position.y <= -100 {
                node.removeFromParent() //все node (облака и острова) ниже нуля будут удаляться
                
        
            }
        }
        //Для удаления выстрела (так как он летит снизу вверх)
        enumerateChildNodes(withName: "shotSprite") { node, stop in //node - это сам объхект, который мы получили при переборе, stop - это флаг, который возвращает либо тру либо фолс
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent() //все node (облака и острова) ниже нуля будут удаляться
                
               
            }
        }
    }
    //MARK: - playerFire() 
    private func playerFire() {
        let shot = YellowShot()
        shot.position = self.player.position //позиция выстрела будет совпадать с центром самолета
        shot.startMovement()
        self.addChild(shot)
    }
    //MARK: -touchesBegan() -  Что мы должны делать, когда зафиксированы прикосновения к экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
}
