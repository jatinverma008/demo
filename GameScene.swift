//
//  GameScene.swift
//  SushiTower
//
//  Created by Parrot on 2019-02-14.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let cat = SKSpriteNode(imageNamed: "character1")
    let sushiBase = SKSpriteNode(imageNamed:"roll")
    
    
    
    
    
    
    override func didMove(to view: SKView) {
        // add background
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.zPosition = -1
        addChild(background)
        
        // add cat
        cat.position = CGPoint(x:self.size.width*0.25, y:100)
        addChild(cat)
        
        // add base sushi pieces
        sushiBase.position = CGPoint(x:self.size.width*0.5, y: 100)
        addChild(sushiBase)
        
        for i in 0...5 {
            spawnSushi()
        }
        [ 200, 300, 400, 500, 600 ]
        
        
        
    }//jatin   
    
    var tower:[SushiPiece]  = []
    var stickPositionArray:[String] = []
    
    func spawnSushi() {
        
        
        // 1. check how many pieces are in teh tower
        let numPieces = self.tower.count
        
        // if 0 pieces, put piece at the starting position
        let specialSushi = SushiPiece(imageNamed:"roll")
        
        if (numPieces  == 0) {
            // add sushi at starting position
            specialSushi.position = CGPoint(x:self.size.width*0.5, y: 200)
        }
        else if (numPieces > 0) {
            // 1. get the previous piece
            let previousPiece = self.tower[self.tower.count-1]
            
            // 2. add the new pieces at 50 pixel above it
            specialSushi.position = CGPoint(
                x:self.size.width*0.5,
                y:previousPiece.position.y + 100)
        }
        
        // add sushi to the screen
        addChild(specialSushi)
        
        // add the sushi to the tower
        tower.append(specialSushi)
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    var catPosition:String = "left"
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // This is the shortcut way of saying:
        //      let mousePosition = touches.first?.location
        //      if (mousePosition == nil) { return }
        guard let mousePosition = touches.first?.location(in: self) else {
            return
        }
        
        print(mousePosition)
        
        
        // ----------------------------------------------------
        // Things you do inside the touchesBegan Function:
        // A - CAT MOVEMENT: when user taps, decide if you should switch cat position from left/right
        // B - GAME OVER LOGIC: check if chopstick and cat are on same side. If yes, lose a life.
        // C - ANIMATION: show an animation of the cat punching the sushi
        // D - ANIMATION: after hitting the sushi, make tower fall down
        // ----------------------------------------------------
        
        
        
        // -----------------------------
        // PART A:  CAT MOVEMENT
        // If user taps left side, move cat left
        // If user taps right side, move cat right
        // -----------------------------
        
        // 1. Calculate x position of center of screen  (width / 2)
        // 2. Check where the user clicked
        // 3. If left, change cat position to x = 25% of screen width   (left side)
        // 4. If right, change cat position to x = 80% of screen width  (right side)
        
        
        // GREAT LETS TRY IT!
        let CENTER = self.size.width / 2
        if (mousePosition.x < CENTER) {
            // left
            // - move cat to x = 25% of width
            cat.position = CGPoint(x:self.size.width*0.25, y:100)
            
            let leftHandUpAction = SKAction.scaleX(to: 1, duration: 0)
            self.cat.run(leftHandUpAction)
            
            self.catPosition = "left"
        }
        else {
            // right
            // - move cat to x = 80% of width
            cat.position = CGPoint(x:self.size.width*0.80, y:100)
            let rightHandUpAction = SKAction.scaleX(to: -1, duration: 0)
            self.cat.run(rightHandUpAction)
            
            
            self.catPosition = "right"
            
        }
        
        
        // -----------------------------
        // PART B:  GAME LOGIC
        // ARE STICK AND CAT IN SAME POSITION?
        // --- IF YES = DIE
        // -----------------------------
        
        // 1. get the position of the stick  (left / right)
        // 2. get the position of the cat   (left / right)
        // 3. compare the cat position and stick postion    (left == left, right == right)
        
        if (self.tower.count > 0) {
            var bottomSushiPiece = self.tower[0]
            
            print("Cat Position: \(self.catPosition)")
            print("Stick Position: \(bottomSushiPiece.stickPosition)")
            if (catPosition == bottomSushiPiece.stickPosition) {
                print("PLAYER DIES!!!")
            }
        }
        
        
        
        // -----------------------------
        // PART C:  ANIMATION OF CAT
        // Show an animation of the cat punching the towser
        // -----------------------------
        
        // 1. get the images in the animation and store them in a textures array
        var punchTextures:[SKTexture] = []
        for i in 1...3 {
            let fileName = "character\(i)"
            //print("Adding: \(fileName) to array")
            punchTextures.append(SKTexture(imageNamed: fileName))
        }
        punchTextures.append(SKTexture(imageNamed:"character1"))
        
        // 2. Tell Spritekit to use that array to create your animation
        let punchingAnimation = SKAction.animate(
            with: punchTextures,
            timePerFrame: 0.2)
        
        // 3. Repeat the animation once
        self.cat.run(punchingAnimation)
        
        
        
        
        // -----------------------------
        // PART D:  ANIMATION OF TOWER DROPPING
        // Show an animation of the tower falling down
        // -----------------------------
        
        // 1. Get the bottom piece of sushi from the towser
        // 2. Remove that sushi from the screen
        // 3. Remove the sushi from the tower array
        // 4. Loop through remaining sushi pieces and update their y-position by (-100px)
        //      - We choose -100 because we want the pieces to MOVE DOWN
        
        
        // 1. GET THE SUSHI FROM THE TOWER
        if (self.tower.count > 0) {
            let currentSushi = self.tower[0]  // self.tower.first
            
            if (currentSushi != nil) {
                // 2. REMOVE THE SUSHI FROM THE SCREEN
                currentSushi.removeFromParent()
                
                // 3. REMOVE THE SUSHI FROM THE TOWER
                self.tower.remove(at: 0)
                
                print("Number of pieces left in tower: \(self.tower.count)")
            }
        }
        
        
        // 4. move all pieces down
        for (index, piece) in self.tower.enumerated() {
            //print("Piece \(index) y-position: \(piece.position.y)")
            piece.position.y = piece.position.y - 100
        }
        
    } // end touches began
    
}

