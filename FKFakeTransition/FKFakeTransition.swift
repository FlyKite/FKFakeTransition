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

public class FKFakeTransition: NSObject {
    var window: UIWindow
    init(_ keyWindow: UIWindow) {
        window = keyWindow
    }
    
    func shotWindow() -> UIImage? {
//        let view = UIScreen.main.snapshotView(afterScreenUpdates: true)
        let view = self.window.snapshotView(afterScreenUpdates: true)
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, true, UIScreen.main.scale)
//        self.window.drawHierarchy(in: self.window.bounds, afterScreenUpdates: true)
        self.window.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func shotWindow(_ rect: CGRect) -> UIImage? {
        let screenshot = self.shotWindow()
        UIGraphicsBeginImageContextWithOptions(rect.size, true, UIScreen.main.scale)
        let frame = CGRect(origin: CGPoint(x: -rect.origin.x, y: -rect.origin.y), size: self.window.bounds.size)
        screenshot?.draw(in: frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
