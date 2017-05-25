//
//  ColorThumbnail.swift
//  CustomTransition
//
//  Created by Aizat Omar on 24/5/17.
//
//

import UIKit

@IBDesignable class ColorThumbnail: UIButton {
    override open func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 20.0
    }
    
    override open func prepareForInterfaceBuilder() {
        self.layer.cornerRadius = 20.0
    }
}
