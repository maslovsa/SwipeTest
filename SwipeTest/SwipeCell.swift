//
//  SwipeCell.swift
//  SwipeTest
//
//  Created by Maslov Sergey on 10.10.16.
//  Copyright © 2016 ROKO. All rights reserved.
//

import UIKit

let kIgnoreHysteresis: CGFloat = 5.0

class SwipeCell: UITableViewCell {
    
    @IBOutlet private weak var myContentView: UIView!
    var lastDir: UISwipeGestureRecognizerDirection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(SwipeCell.handlePan(_:)))
        gesture.cancelsTouchesInView = false
        self.myContentView.addGestureRecognizer(gesture)
    }
    
    func handlePan(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state != .ended {
            return 
        }
        
        let velocity = recognizer.velocity(in: self.myContentView)
        guard abs(velocity.x) >= kIgnoreHysteresis || abs(velocity.y) >= kIgnoreHysteresis  else {
            return
        }
        
        let direction = getDirectionFromVelocity(velocity)
        
        if lastDir != nil {
            if lastDir! != direction {
                self.lastDir = direction
                print(lastDir!.description)
            }
        } else {
            lastDir = direction
            print(lastDir!.description)
        }
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //print("-----------------")
        return true
    }
    
    func getDirectionFromVelocity(_ velocity: CGPoint) -> UISwipeGestureRecognizerDirection{
        if abs(velocity.x) > abs(velocity.y) {
            if velocity.x > 0 {
                return .right
            } else {
                return .left
            }
        } else {
            if velocity.y > 0 {
                return .down
            } else {
                return .up
            }
        }
    }

}

extension UISwipeGestureRecognizerDirection {
    var  description: String {
        switch self {
        case UISwipeGestureRecognizerDirection.left:
            return "left"
        case UISwipeGestureRecognizerDirection.right:
            return "right"
        case UISwipeGestureRecognizerDirection.up:
            return "up"
        default:
            return "down"
        }
    }
}
