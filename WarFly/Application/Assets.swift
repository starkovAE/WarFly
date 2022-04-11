//
//  Assets.swift
//  WarFly
//
//  Created by Александр Старков on 11.04.2022.
//


import SpriteKit
//MARK: - Этот класс будет СинглТоном - это такой класс, который имеет всего один экземпляр
class Assets {
static let shared = Assets()
    
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    
    func preloadAssets() {
        //подгрузили атласы
        playerPlaneAtlas.preload {
            print("PlayerPlaneAtalasPreload")
        }
        greenPowerUpAtlas.preload {
            print("GreenPowerUpAtalasPreload")
        }
        bluePowerUpAtlas.preload {
            print("BluePowerUpAtalasPreload")
        }
        enemy_1Atlas.preload {
            print("Enemy_1AtalasPreload")
        }
        enemy_2Atlas.preload {
            print("Enemy_2AtalasPreload")
        }
        yellowAmmoAtlas.preload {
            print("yellowShotAtalasPreload")
        }
    }
}
