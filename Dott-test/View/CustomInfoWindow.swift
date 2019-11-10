//
//  MarkerInfoVIew.swift
//  Dott-test
//
//  Created by Damir Ramic on 10/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import Foundation
import UIKit

class CustomInfoWindow : UIView {
    var view : UIView!
    @IBOutlet weak var titleRestaurant: UILabel!
    @IBOutlet weak var moreInfo: UILabel!
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
    }
    
    func loadView() -> CustomInfoWindow {
        let customInfoWindow = Bundle.main.loadNibNamed("MarkerInfoWindow", owner: self, options: nil)?[0] as! CustomInfoWindow
        customInfoWindow.layer.cornerRadius = 8
        customInfoWindow.layer.masksToBounds = true
        return customInfoWindow
    }
}


