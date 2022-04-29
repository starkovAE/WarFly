//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by Александр Старков on 11.04.2022.
//

import SpriteKit
//для масок используется тип UINT32
//битовая маска - это набор битов, которые подходят под такую запись 0x1 <<0
extension SKPhysicsBody {
    var category: BitMaskCategory {
        get {
            return BitMaskCategory(rawValue: self.categoryBitMask)
        }
        
        set {
            self.categoryBitMask = newValue.rawValue
        }
    }
}
struct BitMaskCategory: OptionSet {
    
    let rawValue: UInt32

    static let none = BitMaskCategory(rawValue: 0 << 0) // 000000000000..0 - битовая маска, которая в себя ничего не включает
    static let player = BitMaskCategory(rawValue: 1 << 0) // 000000000000...01      1
    static let enemy = BitMaskCategory(rawValue: 1 << 1) // 0000000000000...10     2
    static let powerUp = BitMaskCategory(rawValue: 1 << 2) // 0000000000000...100   4
    static let shot = BitMaskCategory(rawValue: 1 << 3) // 0000000000000...1000    8
    static let all = BitMaskCategory(rawValue: UInt32.max ) // 111111111111 - 32 единицы
}


