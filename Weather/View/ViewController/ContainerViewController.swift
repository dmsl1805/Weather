//
//  ContainerViewController.swift
//
//  Created by Dmitriy Shulzhenko on 1/15/17.
//  Copyright © 2017 Dmitriy Shulzhenko. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    public var currentViewController: UIViewController!
    
    private var transitionCompleted: Bool = true
    private var frameForChild: CGRect {
        return CGRect(origin: CGPoint.zero, size: view.frame.size)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(currentViewController)
        currentViewController.view.frame = frameForChild
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParentViewController: self)
    }
    
    public func show(_ vc: UIViewController,
                     duration: TimeInterval = 0,
                     options: UIViewAnimationOptions = .transitionCrossDissolve,
                     animations: (() -> Void)? = nil,
                     completion: (() -> Void)? = nil) {
        
        guard transitionCompleted else { return }

        guard vc != currentViewController else { return }

        transitionCompleted = false
        
        currentViewController.willMove(toParentViewController: nil)
        addChildViewController(vc)
        vc.view.frame = frameForChild

        transition(from: currentViewController,
                   to: vc,
                   duration: duration,
                   options: options,
                   animations: animations) { [unowned self] finished in
                    self.currentViewController.removeFromParentViewController()
                    vc.didMove(toParentViewController: self)
                    self.currentViewController = vc
                    self.transitionCompleted = true
        }
    }
    
}

