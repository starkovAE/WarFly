//
//  GameScene.swift
//  WarFly
//
//  Created by Александр Старков on 06.04.2022.
//ТУТ РЕАЛИЗАУЕТСЯ ВСЯ ЛОГИКА СЦЕНЫ

import SpriteKit
import GameplayKit


class GameScene: ParentScene {
    
    var backgroundMusic: SKAudioNode!
    //создаем игрока
    private var player: PlayerPlain!
    private  let hud = HUD()
    private let screenSize = UIScreen.main.bounds.size
    
    private var lives = 3 {//как только количество жизней меняется от 3, выполняется код ниже
        //при изменении значения данного свойства будет отрабатывать код ниже
        didSet {
            switch lives {
            case 3:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = false
            case 2:
                hud.life1.isHidden = false
                hud.life2.isHidden = false
                hud.life3.isHidden = true
            case 1:
                hud.life1.isHidden = false
                hud.life2.isHidden = true
                hud.life3.isHidden = true
            default:
                break
            }
        }
    }
    
    //MARK: - didMove(to View:)
    override func didMove(to view: SKView) {
        gameSettings.loadGameSettings()
        //делаем проверку на то что нам разрешена музыка и то что мызки на данной сцене не было (чтобы не было наложений)
        if gameSettings.isMusic && backgroundMusic == nil {
            
            if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "m4a") {
                backgroundMusic = SKAudioNode(url: musicURL)
                addChild(backgroundMusic
                )
            }
        }
        
        self.scene?.isPaused = false
        guard sceneManager.gameScene == nil else { return } //если тру (значит сцена еще не создана) - идет дальше по коду, если false (значит сцена уже есть) - выходит из метода
        sceneManager.gameScene = self //произошла загрузка текущей сцены (присвоили свойству gameScene - текущую сцену)
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero //силу гравитации приравниванием к 0, чтобы самолеты не падали
        //Проверяем существует ли данная сцена уже?
        
        configurateStartScene()
        spawnClouds()
        spawnIsland()
        
        self.player.performFly() //вызываем метод полета
        
        spawnPowerUp()
        spawnEmenies()
        createHUD()
    }
    private func createHUD() {
        addChild(hud)
        hud.configureUI(screenSize: screenSize)
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
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas
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
        enumerateChildNodes(withName: "bluePowerUp") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent() //удаляем их со сцены, если их позция ниже у = -100
                
                
            }
        }
        
        enumerateChildNodes(withName: "greenPowerUp") { node, stop in
            if node.position.y <= -100 {
                node.removeFromParent() //удаляем их со сцены, если их позция ниже у = -100
                
                
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
        guard let location = touches.first?.location(in: self) else { return }//касание внутри этой сцены (self)
        let node = self.atPoint(location)
        
        if node.name == "pause" { //если свойство имени равно  = runButton
            let transition = SKTransition.doorway(withDuration: 1.0)
            let pauseScene = PauseScene(size: self.size)
            pauseScene.scaleMode = .aspectFill
            sceneManager.gameScene = self
            self.scene?.isPaused = true
            self.scene?.view?.presentScene(pauseScene, transition: transition) //осуществляем сам переход
        } else {
            
            playerFire()
        }
        
    }
}// закрвыает класс

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let explosion = SKEmitterNode(fileNamed: "EnemyExplosion") else { return }
        explosion.zPosition = 25
        //пытаемся получить точкв которой соприкасается наша пуля с врагом либо самолет с врагом
        let contactPoint = contact.contactPoint //получили точку
        explosion.position = contactPoint //разместили взрыв по этим координатам
        let waitForExplosionAction = SKAction.wait(forDuration: 1.0)
        
        let contactCategory: BitMaskCategory  = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
            
        case[.enemy, .player]: print("enemy vs player")
            if contact.bodyA.node?.name == "Sprite" { //то мы точно знаем, что это не наш самолет. А наш враг
                if  contact.bodyA.node?.parent != nil { //если не удален родитель
                    contact.bodyA.node?.removeFromParent() //удаляем
                    lives -= 1 //уменьшаем количество жизней
                }
                
            } else {
                if  contact.bodyB.node?.parent != nil { //если не удален родитель
                    contact.bodyB.node?.removeFromParent() //удаляем
                    lives -= 1 //уменьшаем количество жизней
                }
                
            }
            addChild(explosion)
            self.run(waitForExplosionAction) {
                explosion.removeFromParent()
            }
            if lives == 0 {
                let gameOverScene = GameOverScene(size: self.size)
                gameOverScene.scaleMode = .aspectFill
                let transition = SKTransition.doorsCloseVertical(withDuration: 1.0)
                self.scene?.view?.presentScene(gameOverScene, transition: transition) //осуществляем сам переход
            }
            
        case[.powerUp, .player]: print("powerUp vs player")
           
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil { //равен ли один из родителей или оба родителя сталкивающихся объектов нил, если они равны или один из них равен нил. тогда мы ничего не делаем, если не равен мы падаем внутрь конструкции
              
                if contact.bodyA.node?.name == "bluePowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    lives = 3
                    player.bluePowerUp()
                } else if contact.bodyB.node?.name == "bluePowerUp" {
                    contact.bodyB.node?.removeFromParent()
                    lives = 3
                    player.bluePowerUp()
                }
                
                if contact.bodyA.node?.name == "greenPowerUp" {
                    contact.bodyA.node?.removeFromParent()
                    player.greenPowerUp()
                    
                    
                } else {
                    contact.bodyB.node?.removeFromParent()
                    player.greenPowerUp()
                }
            }
    
        case[.enemy, .shot]: print("enemy vs shot")
            if contact.bodyA.node?.parent != nil && contact.bodyB.node?.parent != nil { //если родитель равен нил, значит столкновение произошло
                //если не нил(если столкновение не произошло)
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                if gameSettings.isSound {
                    self.run(SKAction.playSoundFileNamed("hitSound", waitForCompletion: false))
                }
                hud.score += 5
                addChild(explosion)
                self.run(waitForExplosionAction) {
                    explosion.removeFromParent()
                }
            }
        default:
            preconditionFailure("Unable to detect collision category")
            
        }
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
