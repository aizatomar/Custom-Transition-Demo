//
//  ColorViewController.swift
//  CustomTransition
//
//  Created by Aizat Omar on 24/5/17.
//
//

import UIKit

class ColorViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var selectedColorIndex: Int = 0
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var selectedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color: ColorModel = ColorModel.all()[self.selectedColorIndex]
        self.view.backgroundColor = color.color
        self.selectedLabel.text = "You have chosen \(color.name)!"
    }
    
    @IBAction private func pressClose() {
        self.dismiss(animated: true,
                     completion: nil)
    }
}
