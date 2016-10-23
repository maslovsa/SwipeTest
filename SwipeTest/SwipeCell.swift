//
//  SwipeCell.swift
//  SwipeTest
//
//  Created by Maslov Sergey on 10.10.16.
//  Copyright © 2016 ROKO. All rights reserved.
//

import UIKit

class SwipeCell: UITableViewCell {
    
    @IBOutlet private weak var myContentView: UIView!
    var lastDir: UISwipeGestureRecognizerDirection?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(SwipeCell.handlePan(_:)))
        gesture.cancelsTouchesInView = false
        gesture.delegate = self
        self.myContentView.addGestureRecognizer(gesture)
    }
    
    func handlePan(_ recognizer:UIPanGestureRecognizer) {
        if recognizer.state != .ended {
            return 
        }
        
        let velocity = recognizer.velocity(in: self.myContentView)
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

    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if otherGestureRecognizer.view is UITableView { // Allows Parent TableView to scroll
            return true
        }
        return false
    }
}
