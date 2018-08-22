//
//  SchoolName.swift
//  20180821-KalyanChakravarthyAnnambhotla-NYCSchools
//
//  Created by kalyan chakravarthy on 8/21/18.
//  Copyright © 2018 coders. All rights reserved.
//

import Foundation

struct NYCSchoolData
{
    var schoolName : String?
    var phoneNumber : String?
    var faxNumber : String?
    var email : String?
    var website : String?
    var address : String?
    var city : String?
    var zip : String?
    
    init(name : String, phoneNumber:String, faxNumber:String, email:String, website:String, address:String, city:String, zip:String)
    {
        self.schoolName = name
        self.phoneNumber = phoneNumber
        self.faxNumber = faxNumber
        self.email = email
        self.website = website
        self.address = address
        self.city = city
        self.zip = zip
    }
}
