//
//  SatSchoolData.swift
//  20180821-KalyanChakravarthyAnnambhotla-NYCSchools
//
//  Created by kalyan chakravarthy on 8/21/18.
//  Copyright © 2018 coders. All rights reserved.
//

import Foundation

struct SatSchoolData
{
    var satSchoolName : String?
    var satReadingScore : String?
    var satWritingScore : String?
    var satMathScore : String?
    var satTotalTestTakers : String?
    
    init(name: String, reading: String, writing: String, math:String, testTakers: String)
    {
        self.satSchoolName = name
        self.satReadingScore = reading
        self.satWritingScore = writing
        self.satMathScore = math
        self.satTotalTestTakers = testTakers
    }
}
