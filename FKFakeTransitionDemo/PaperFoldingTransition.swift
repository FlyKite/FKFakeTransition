//
//  PaperFoldingTransition.swift
//  MessagePlugin
//
//  Created by 风筝 on 2017/7/28.
//  Copyright © 2017年 Sachsen. All rights reserved.
//

import UIKit

class PaperFoldingTransition: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    private let duration: Double = 2.0
    
    private var transitionContext: UIViewControllerContextTransitioning?
    private var seperateY: CGFloat
    
    init(seperateBy y: CGFloat) {
        seperateY = y
        super.init()
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        guard let fromController = transitionContext.viewController(forKey: .from) else {
            return
        }
        guard let toController = transitionContext.viewController(forKey: .to) else {
            return
        }
        let containerView = transitionContext.containerView
        //        var frame = containerView.frame
        //        frame.origin.y = 64
        //        containerView.frame = frame
        //        containerView.frame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64)
        //        containerView.addSubview(fromController.view)
        containerView.addSubview(toController.view)
        
        //        let fromView = fromController.view.snapshotView(afterScreenUpdates: false)
        //        let toView = toController.view.snapshotView(afterScreenUpdates: false)
        
        //        let animationView = UIView()
        //        animationView.tag = 0x1234
        //        animationView.frame = fromController.view.bounds
        //        containerView.addSubview(animationView)
        //
        //        animationView.addSubview(fromView!)
        //        animationView.addSubview(toView!)
        
        toController.view.layoutSubviews()
        //        containerView.addSubview(toController.view)
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
        animation.fromValue = CGFloat.pi / 2
        animation.toValue = 0
        animation.duration = duration
        animation.delegate = self
        toController.view.layer.add(animation, forKey: nil)
        
        /*
         let (fromTopImage, fromBottomImage) = self.cut(fromController.view, seperateBy: self.seperateY)
         let (toTopImage, toBottomImage) = self.cut(toController.view, seperateBy: toController.view.frame.height / 2)
         
         // 黑色背景
         let animationView = UIView()
         animationView.tag = 0x1234
         animationView.frame = fromController.view.bounds
         //        animationView.backgroundColor = UIColor.red
         containerView.addSubview(animationView)
         
         // fromController的图片
         let fromTopImageView = UIImageView(image: fromTopImage)
         fromTopImageView.frame = CGRect(origin: CGPoint.zero, size: fromTopImage.size)
         animationView.addSubview(fromTopImageView)
         
         let fromTopAnimation = CABasicAnimation(keyPath: "position.y")
         fromTopAnimation.fromValue = fromTopImage.size.height / 2
         fromTopAnimation.toValue = -fromTopImage.size.height / 2
         fromTopAnimation.duration = duration
         fromTopImageView.layer.add(fromTopAnimation, forKey: nil)
         
         let fromBottomImageView = UIImageView(image: fromBottomImage)
         fromBottomImageView.frame = CGRect(origin: CGPoint(x: 0, y: seperateY), size: fromBottomImage.size)
         animationView.addSubview(fromBottomImageView)
         
         let fromBottomAnimation = CABasicAnimation(keyPath: "position.y")
         fromBottomAnimation.fromValue = fromTopImage.size.height + fromBottomImage.size.height / 2
         fromBottomAnimation.toValue = fromTopImage.size.height + fromBottomImage.size.height / 2 * 3
         fromBottomAnimation.duration = duration
         fromBottomAnimation.delegate = self
         fromBottomImageView.layer.add(fromBottomAnimation, forKey: nil)
         
         // toController的图片
         //        let toTopImageView = UIImageView(image: toTopImage)
         let toTopImageView = UIImageView()
         toTopImageView.backgroundColor = UIColor.yellow
         //        toTopImageView.frame = CGRect(origin: CGPoint.zero, size: toTopImage.size)
         toTopImageView.frame = CGRect(x: 0, y: 0, width: 375, height: toTopImage.size.height)
         toTopImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
         animationView.addSubview(toTopImageView)
         
         let toTopImageRotation = CABasicAnimation(keyPath: "transform.rotation.x")
         toTopImageRotation.fromValue = CGFloat.pi / 2
         toTopImageRotation.toValue = 0
         
         let toTopImagePosition = CABasicAnimation(keyPath: "position.y")
         toTopImagePosition.fromValue = seperateY
         toTopImagePosition.toValue = 0
         
         let toTopImageAnimation = CAAnimationGroup()
         toTopImageAnimation.duration = duration
         toTopImageAnimation.animations = [toTopImageRotation, toTopImagePosition]
         toTopImageView.layer.add(toTopImageAnimation, forKey: nil)
         
         //        let toBottomImageView = UIImageView(image: toBottomImage)
         let toBottomImageView = UIImageView()
         toBottomImageView.backgroundColor = UIColor.cyan
         //        toBottomImageView.frame = CGRect(origin: CGPoint(x: 0, y: toController.view.frame.height / 2), size: toBottomImage.size)
         toBottomImageView.frame = CGRect(x: 0, y: toController.view.frame.height / 2, width: 375, height: toBottomImage.size.height)
         toBottomImageView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
         animationView.addSubview(toBottomImageView)
         
         let toBottomImageRotation = CABasicAnimation(keyPath: "transform.rotation.x")
         toBottomImageRotation.fromValue = -CGFloat.pi / 2
         toBottomImageRotation.toValue = 0
         
         let toBottomImagePosition = CABasicAnimation(keyPath: "position.y")
         toBottomImagePosition.fromValue = seperateY
         toBottomImagePosition.toValue = toTopImage.size.height + toBottomImage.size.height
         
         let toBottomImageAnimation = CAAnimationGroup()
         toBottomImageAnimation.duration = duration
         toBottomImageAnimation.animations = [toBottomImageRotation, toBottomImagePosition]
         toBottomImageView.layer.add(toBottomImageAnimation, forKey: nil)
         
         //        let animation = CABasicAnimation(keyPath: "transform.rotation.x")
         //        animation.fromValue = CGFloat.pi / 2
         //        animation.toValue = 0
         //        animation.duration = 2.0
         //        animation.delegate = self
         //        toController.view.layer.add(animation, forKey: "key")
         
         */
        
        self.transitionContext = transitionContext
        
        //        UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        //        UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //        //不添加的话，屏幕什么都没有
        //        UIView *containerView = [transitionContext containerView];
        //        [containerView addSubview:fromVC.view];
        //        [containerView addSubview:toVC.view];
        //
        //        //注意注意一定要注意这里。我们就是在这里添加我们所需要的动画效果。将动画效果的代码放在这里就行了。重要的事情要说好几遍
        //
        //        //如果取消了就设置为NO，反之，设置为YES。如果添加了动画，这句代码在动画结束之后再调用
        //        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let transitionContext = self.transitionContext else {
            return
        }
        let animationView = transitionContext.containerView.viewWithTag(0x1234)
        animationView?.alpha = 0
        animationView?.removeFromSuperview()
        self.transitionContext?.completeTransition(!transitionContext.transitionWasCancelled)
    }
    
    func cut(_ view: UIView, seperateBy y: CGFloat) -> (UIImage, UIImage) {
        let size = view.frame.size
        // 截取上半部分
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: y), true, UIScreen.main.scale)
        let topFrame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        view.drawHierarchy(in: topFrame, afterScreenUpdates: true)
        let topImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // 截取下半部分
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height - y), true, UIScreen.main.scale)
        let bottomFrame = CGRect.init(x: 0, y: -y, width: size.width, height: size.height)
        view.drawHierarchy(in: bottomFrame, afterScreenUpdates: true)
        let bottomImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return (topImage!, bottomImage!)
    }
    
}
