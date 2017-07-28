//
//  FKPaperFoldingTransition.swift
//  FKFakeTransition
//
//  Created by FlyKite on 2017/7/29.
//  Copyright © 2017年 FlyKite. All rights reserved.
//

import UIKit

public class FKPaperFoldingTransition: FKFakeTransitionCreator {
    public static func create(with keyWindow: UIWindow) -> FKFakeTransitioning {
        let transition = FKPaperFoldingTransitioning(keyWindow)
        return transition
    }
}

class FKPaperFoldingTransitioning: FKFakeTransition, FKFakeTransitioning {

}
