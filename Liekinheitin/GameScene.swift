//
//  GameScene.swift
//  Liekinheitin
//
//  Created by Jonne Itkonen on 27.9.2016.
//  Copyright © 2016 Jonne Itkonen. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var pökät : SKNode?
    private var poppa : SKNode?
    private var pökäAlku: CGPoint?
    private var auts: SKAction?

    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self

        self.pökät = self.childNode(withName: "//pökät")
        self.pökäAlku = self.pökät?.position

        self.poppa = self.childNode(withName: "//poppa")

        let hyp = SKAction.moveBy(x: -50, y: 200, duration: TimeInterval(0.1))
        let takas = SKAction.move(to: pökäAlku!, duration: TimeInterval(1))
        self.auts = SKAction.sequence([hyp, takas])

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == 0x02 {        // A = pökät, B = poppa
            contact.bodyB.node?.run(auts!)
        } else if contact.bodyB.categoryBitMask == 0x02 { // A = poppa, B = pökät
            contact.bodyA.node?.run(auts!)
        }
    }

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 124:
            if var x = self.pökät?.position.x {
                x += 3
                if x > 10 { x = -220 }
                self.pökät?.position.x = x
            }
            break
        case 126:
            let p = self.poppa as? SKSpriteNode
            p?.color = (p?.color.withAlphaComponent(0.16))!
        case 125:
            let p = self.poppa as? SKSpriteNode
            p?.color = (p?.color.withAlphaComponent(0.0))!
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
}
