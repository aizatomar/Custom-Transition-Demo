//
//  ColorModel.swift
//  CustomTransition
//
//  Created by Aizat Omar on 24/5/17.
//
//

import UIKit

struct ColorModel {
    let name: String
    let color: UIColor
    
    static func all() -> [ColorModel] {
        return [
            ColorModel(name: "Salmon",
                       color: UIColor(red: 255/255,
                                      green: 102/255,
                                      blue: 102/255,
                                      alpha: 1.0)),
            ColorModel(name: "Cantaloupe",
                       color: UIColor(red: 255/255,
                                      green: 204/255,
                                      blue: 102/255,
                                      alpha: 1.0)),
            ColorModel(name: "Banana",
                       color: UIColor(red: 255/255,
                                      green: 255/255,
                                      blue: 102/255,
                                      alpha: 1.0)),
            ColorModel(name: "Honeydew",
                       color: UIColor(red: 204/255,
                                      green: 255/255,
                                      blue: 102/255,
                                      alpha: 1.0)),
            ColorModel(name: "Sky",
                       color: UIColor(red: 102/255,
                                      green: 204/255,
                                      blue: 255/255,
                                      alpha: 1.0)),
        ]
    }
}
