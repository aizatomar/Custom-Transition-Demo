//
//  MainViewController.swift
//  CustomTransition
//
//  Created by Aizat Omar on 24/5/17.
//
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var richardView: ColorThumbnail!
    @IBOutlet weak var ofView: ColorThumbnail!
    @IBOutlet weak var yorkView: ColorThumbnail!
    @IBOutlet weak var gainView: ColorThumbnail!
    @IBOutlet weak var battleView: ColorThumbnail!
    @IBOutlet weak var catKnight: UIImageView!
    @IBOutlet weak var rightSide: NSLayoutConstraint!
    
    let colors: [ColorModel] = ColorModel.all()
    let animator = ZoomOutAnimator()
    var selectedColorThumbnail: ColorThumbnail?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 1 - Conform to UIViewControllerTransitioningDelegate
        self.transitioningDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.rightSide.constant = 20.0
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animateCatKnight()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.catKnight.layer.removeAllAnimations()
    }
    
    // Keyframes animation
    private func animateCatKnight() {
        let initialRightSide: CGFloat = 20.0
        let duration: TimeInterval = 6.0
        UIView.animateKeyframes(withDuration: duration,
                                delay: 0.0,
                                options: [.beginFromCurrentState, .repeat, .autoreverse, .calculationModePaced],
                                animations: {
                                    let maxRound: Int = 30
                                    for round in 1...maxRound {
                                        let identity: CGFloat = pow(-1, CGFloat(round))
                                        let angle: CGFloat = identity * 10.0
                                        UIView.addKeyframe(withRelativeStartTime: 0.0,
                                                           relativeDuration: Double(round)/Double(maxRound),
                                                           animations: {
                                                            self.catKnight.transform = CGAffineTransform(rotationAngle: CGFloat(angle.degreesToRadians))
                                                            self.rightSide.constant = (initialRightSide * CGFloat(round)) + initialRightSide
                                                            self.view.layoutIfNeeded()
                                        })
                                    }
        },
                                completion: nil)
    }
    
    @IBAction private func pressColor(sender: ColorThumbnail) {
        self.selectedColorThumbnail = sender
        let color = storyboard!.instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        color.selectedColorIndex = sender.tag
        color.transitioningDelegate = self
        self.present(color,
                     animated: true,
                     completion: nil)
        
    }
}

// Step 1 - Conform to UIViewControllerTransitioningDelegate
extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.originFrame = self.selectedColorThumbnail!.superview!.convert(self.selectedColorThumbnail!.frame, to: nil)
        animator.presenting = true
        
        // Step 3 - Return the animator class
        return animator
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        
        // Step 3 - Return the animator class
        return animator
    }
}

// Some convenience extension
extension FloatingPoint {
    var degreesToRadians: Self {
        return self * .pi / 180
    }
    var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}
