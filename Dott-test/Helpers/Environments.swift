//
//  Environments.swift
//  Dott-test
//
//  Created by Damir Ramic on 08/11/2019.
//  Copyright © 2019 Damir Ramich. All rights reserved.
//

import Foundation


struct Environments {

    private struct Domains {
        static let Url = "https://api.foursquare.com/v2/venues/search?"
        static let googleApiKey = "AIzaSyAPBAwxjZ5OrSEVkAvULPw-SNcLHu2V7es"
    }

    private  struct Client {
        static let ClientSecret = "&client_secret=UZJP0TZOGTSEXLPHBGSN3ECUM5RKHKEAN5NPXVK1YN2ATTSJ"
        static let ClientId = "client_id=3HKTMJ230UF1Y0YHWTYXI1S4TJJWRPJ1BNGVDVG4FGLLWLCC"
    }

    static var VenuesUrl: String {
        return Domains.Url + Client.ClientId + Client.ClientSecret
    }
    
    static var apiKey: String {
        return Domains.googleApiKey
    }
}
