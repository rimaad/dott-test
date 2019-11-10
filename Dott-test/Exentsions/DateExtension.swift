//
//  DateExtension.swift
//  Dott-test
//
//  Created by Damir Ramic on 10/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import Foundation


extension Date {
  func toDate(withFormat format: String = "yyyyMMdd") -> String {
    let df = DateFormatter()
    df.dateFormat = format
    let now =  df.string(from:self)
    return now
  }
}
