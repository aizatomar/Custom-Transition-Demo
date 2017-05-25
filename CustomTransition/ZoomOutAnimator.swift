//
//  ZoomOutAnimator.swift
//  CustomTransition
//
//  Created by Aizat Omar on 24/5/17.
//
//

import UIKit

// Step 2 - Create Animator class that conforms to UIViewControllerAnimatedTransitioning
class ZoomOutAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    // Duration (compulsory)
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    // Animate (compulsory)
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)!
        
        let colorView = self.presenting ? toView : fromView
        
        let initialFrame = presenting ? originFrame : colorView.frame
        let finalFrame = presenting ? colorView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width
            : finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor,
                                               y: yScaleFactor)
        if presenting {
            colorView.transform = scaleTransform
            colorView.center = CGPoint(x: initialFrame.midX,
                                       y: initialFrame.midY)
            colorView.clipsToBounds = true
        }
        
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: colorView)
        
        UIView.animate(withDuration: duration,
                       delay: 0.0,
                       usingSpringWithDamping: self.presenting ? 0.4 : 0,
                       initialSpringVelocity: 0.0,
                       animations: {
                        colorView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
                        colorView.center = CGPoint(x: finalFrame.midX,
                                                   y: finalFrame.midY)
                        if !self.presenting {
                            colorView.alpha = 0.0
                        }
        }) { _ in
            transitionContext.completeTransition(true)
        }
        
        let round = CABasicAnimation(keyPath: "cornerRadius")
        round.fromValue = !presenting ? 0.0 : 20.0/xScaleFactor
        round.toValue = presenting ? 0.0 : 20.0/xScaleFactor
        round.duration = duration / 2
        colorView.layer.add(round, forKey: nil)
        colorView.layer.cornerRadius = presenting ? 0.0 : 20.0/xScaleFactor
    }
}
