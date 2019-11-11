//
//  StringExtension.swift
//  Dott-test
//
//  Created by Damir Ramic on 11/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import Foundation


extension  Float {
    
    
    func calculateRadius(withZoomLevel level:Float) -> NSNumber {
        
        switch level {
        case 5...:
            return 40000
        case 12:
            return 15000
        case ..<9:
            return 10000
        default:
            return 20000
        }
    }
}

