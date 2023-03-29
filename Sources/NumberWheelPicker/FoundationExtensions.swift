//
//  FoundationExtensions.swift
//  NumberWheelPicker
//
//  Created by Kubilay Erdogan on 2023-03-08.
//

import Foundation

extension Int {
    var asPowerOfTen: Float {
        Float(pow(10.0, Float(self)))
    }

    var length: Int {
        "\(self)".count
    }
}

extension Float {
    var asInteger: Int {
        Int(self)
    }
}
