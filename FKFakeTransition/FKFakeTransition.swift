//
//  FKFakeTransition.swift
//  FKFakeTransition
//
//  Created by FlyKite on 2017/7/28.
//  Copyright © 2017年 FlyKite. All rights reserved.
//

import UIKit

public protocol FKFakeTransitionCreator {
    
    /// Create FKFakeTransitioning with key window.
    ///
    /// - parameter keyWindow: The key window of Application
    /// - returns: The transition
    static func create(with keyWindow: UIWindow) -> FKFakeTransitioning
}

public protocol FKFakeTransitioning {
    
    /// This function should call before push a ViewController into NavigationController to add a screenshot on key window.
    func prepareFakeTransitioning()
    
    /// This function should call in viewDidLoad of the controller pushed into NavigationController, then transition will be performed.
    func performFakeTransitioning()
}

public class FKFakeTransition {
    var window: UIWindow
    init(_ keyWindow: UIWindow) {
        window = keyWindow
    }
    
    func shotWindow(_ rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(rect.size, true, UIScreen.main.scale)
        let frame = CGRect(origin: CGPoint(x: -rect.origin.x, y: -rect.origin.y), size: self.window.bounds.size)
        self.window.drawHierarchy(in: frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
