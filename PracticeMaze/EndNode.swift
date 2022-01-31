//
//  EndNode.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 7/22/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit
import SpriteKit

class EndNode {
    let node : SKShapeNode
    init(endRect: CGRect, corRad: CGFloat) {
        node = SKShapeNode(rect: endRect, cornerRadius: corRad)
        node.lineWidth = 3
        node.physicsBody = SKPhysicsBody(edgeLoopFrom: endRect.insetBy(dx: 0.3*endRect.width, dy: 0.3*endRect.height))
        node.physicsBody?.categoryBitMask = 1
        node.physicsBody?.collisionBitMask = 2
        node.physicsBody?.fieldBitMask = 1
        node.physicsBody?.contactTestBitMask = 3
        node.fillColor = .black
        node.strokeColor = .blue
    }
}
