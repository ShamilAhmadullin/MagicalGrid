//
//  Random.swift
//  MagicalGrid
//
//  Created by Shamil on 20/02/2019.
//  Copyright © 2019 ShamCode. All rights reserved.
//

import UIKit

final class Random {
    
    static func setRandomColor() -> UIColor {
        let red = drand48()
        let green = drand48()
        let blue = drand48()
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
    }
}
