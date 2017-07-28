//
//  FKFakeTransition.swift
//  FKFakeTransition
//
//  Created by FlyKite on 2017/7/28.
//  Copyright © 2017年 FlyKite. All rights reserved.
//

import UIKit

public protocol FKFakeTransitionCreator {
    static func create(with keyWindow: UIWindow) -> FKFakeTransitioning
}

public protocol FKFakeTransitioning {
    
}

class FKFakeTransition {
    var window: UIWindow
    init(_ keyWindow: UIWindow) {
        window = keyWindow
    }
}
