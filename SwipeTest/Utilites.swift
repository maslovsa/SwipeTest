//
//  Utilites.swift
//  SwipeTest
//
//  Created by Maslov Sergey on 23.10.16.
//  Copyright © 2016 ROKO. All rights reserved.
//

import UIKit


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
