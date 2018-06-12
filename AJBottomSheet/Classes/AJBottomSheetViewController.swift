//
//  SecondViewController.swift
//  BottomSheet
//
//  Created by Alvin John Tandoc on 12/06/2018.
//  Copyright © 2018 MetroMart. All rights reserved.
//

import UIKit

public class AJBottomSheetViewController: UIViewController, UIViewControllerTransitioningDelegate {
   
    var height: CGFloat = 0
    var viewController: UIViewController = UIViewController()
    private let dimView: UIView = UIView(frame: UIScreen.main.bounds)
    private let containerView = UIView()
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.dimView.removeFromSuperview()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        let subView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        subView.addSubview(viewController.view)
        self.view.addSubview(subView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
       
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: height)
            ])
        
        addChildViewController(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(viewController.view)
        
        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        
        viewController.didMove(toParentViewController: self)
        
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimView.layer.zPosition = -1
        dimView.isUserInteractionEnabled = true
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissController))
        dimView.addGestureRecognizer(tapGesture)
        
        self.view.addSubview(dimView)
        self.view.bringSubview(toFront: containerView)
    }
    
    @objc fileprivate func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    static public func show(viewController: UIViewController, height: CGFloat, source: UIViewController) {
        let vc: AJBottomSheetViewController = AJBottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.height = height
        vc.viewController = viewController
        vc.transitioningDelegate = vc
        source.present(vc, animated: true, completion: nil)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HideAnimator(height: self.height)
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ShowAnimator(height: self.height)
    }

}
