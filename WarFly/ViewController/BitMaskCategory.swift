//
//  BitMaskCategory.swift
//  WarFly
//
//  Created by Александр Старков on 11.04.2022.
//

import SpriteKit
//для масок используется тип UINT32
//битовая маска - это набор битов, которые подходят под такую запись 0x1 <<0
struct BitMaskCategory {
    static let player: UInt32 = 0x1 << 0 // 000000000000...01      1
    static let enemy: UInt32 = 0x1 << 1  // 0000000000000...10     2
    static let powerUp: UInt32 = 0x1 << 2 // 0000000000000...100   4
    static let shot: UInt32 = 0x1 << 3  // 0000000000000...1000    8
}
