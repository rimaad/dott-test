//
//  Response.swift
//  Dott-test
//
//  Created by Damir Ramic on 09/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import Foundation

struct Response: Codable {
    let response : Venues
}

 struct Venues : Codable {
    let venues : [Venue]
}
enum CodingKeys: String, CodingKey {

    case response = "venues"
   
}

