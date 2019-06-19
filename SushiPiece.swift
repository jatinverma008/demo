//
//  SushiPiece.swift
//  SushiTower
//
//  Created by Parrot on 2019-02-17.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import SpriteKit

// A custom SpriteNode class.
// Used to represent a piece of sushi in the tower.
class SushiPiece: SKSpriteNode {
    
    // MARK: Variables
    // --------------------------------
    
    var stickNode:SKSpriteNode!
    var stickPosition:String = ""
    
    // MARK: Constructor - required nonsense
    // --------------------------------
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        
        // The photo of the sushi roll gets automatically intialized here
        super.init(texture: texture, color: color, size: size)
        
        // Setup your chopstick image & node
        self.stickNode = SKSpriteNode(imageNamed:"chopstick")
        
        // Randomly generate which direciton the chopstick is on
        // randomly generate where the chopstick
        let stickDirection = Int.random(in: 1...3)
        
        if (stickDirection == 1) {
            // no sticks
            self.stickPosition = ""
        }
        if (stickDirection == 2) {
            // stick on left
            self.stickPosition = "left"
            
            // update position of chopstick image
            self.stickNode.position.x = -80;
            
            // add the chopstick to the sushi node
            self.addChild(stickNode)
        }
        else if (stickDirection == 3) {
            // stick on right
            self.stickPosition = "right"
            
            // update position of chopstick image
            self.stickNode.position.x = 80;
            self.stickNode.xScale = -1
            
            // add the chopstick to the sushi node
            self.addChild(stickNode)
        }
    }
    
    // Required nonsense
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark:  Functions
    // --------------------------------
}
