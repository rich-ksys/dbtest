//
//  LocationModel.swift
//  dbtest
//
//  Created by Richard Smith on 08/02/2016.
//  Copyright © 2016 Kinch Systems. All rights reserved.
//

import Foundation

class LocationModel : NSObject {
    // properties
    var Address1: String?
    var Address2: String?
    var Address3: String?
    var Postcode : String?
    
    // empty constructor
    override init()
    {
        
    }
    
    // construct
    init(a1 : String, a2 : String, a3 : String, pcode : String)
    {
        self.Address1 = a1
        self.Address2 = a2
        self.Address3 = a3
        self.Postcode = pcode
    }
    
    // print object's current state
    
    override var description: String {
        return "Addr1: \(Address1), Addr2: \(Address2), Addr3: \(Address3), Postcode: \(Postcode)"
    }
    
    
}