//
//  StartNode.swift
//  PracticeMaze
//
//  Created by Jiajun's Computer on 7/22/20.
//  Copyright © 2020 Jiajun Yan. All rights reserved.
//

import UIKit
import SpriteKit

class StartNode {
    let node : SKShapeNode
    init(endRect: CGRect, corRad: CGFloat) {
        node = SKShapeNode(rect: endRect, cornerRadius: corRad)
        node.fillColor = .black
        node.strokeColor = .yellow
        node.lineWidth = 3
    }
}
