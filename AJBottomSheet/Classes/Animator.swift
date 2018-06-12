//
//  Animator.swift
//  BottomSheet
//
//  Created by Alvin John Tandoc on 12/06/2018.
//  Copyright © 2018 MetroMart. All rights reserved.
//

import UIKit

class ShowAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var height: CGFloat!
    
    init(height: CGFloat) {
        self.height = height
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {return}
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {return}
        
        transitionContext.containerView.addSubview(fromViewController.view)
        
        let dimView: UIView = UIView(frame: UIScreen.main.bounds)
        dimView.backgroundColor = UIColor.black
        dimView.alpha = 0
        transitionContext.containerView.addSubview(dimView)
        
        transitionContext.containerView.addSubview(toViewController.view)
        
        toViewController.view.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            dimView.alpha = 0.5
            toViewController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: { _ in
            dimView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


class HideAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var height: CGFloat!
    
    init(height: CGFloat) {
        self.height = height
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        
        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        let dimView: UIView = UIView(frame: UIScreen.main.bounds)
        dimView.backgroundColor = UIColor.black
        dimView.alpha = 0.5
        
        transitionContext.containerView.insertSubview(dimView, belowSubview: fromViewController.view)
        
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.frame = CGRect(x: 0, y: self.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            dimView.alpha = 0
        }, completion: { _ in
            
            if !UIApplication.shared.keyWindow!.subviews.contains(toViewController.view) {
                UIApplication.shared.keyWindow!.addSubview(toViewController.view)
            }
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
