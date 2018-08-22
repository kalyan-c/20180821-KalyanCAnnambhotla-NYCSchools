//
//  DownloadServices.swift
//  20180821-KalyanChakravarthyAnnambhotla-NYCSchools
//
//  Created by kalyan chakravarthy on 8/21/18.
//  Copyright © 2018 coders. All rights reserved.
//

import Foundation


class DownloadServices
{
    let schoolNameURL = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    let satScoresURL = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
    var mainSchoolArray : [String] = []
    var satSchoolArray : [String] = []
    var notAvailable = "Not Available"
    
    /*---------Single Instance can be used all over the module----------*/
    private init() {}
    static let shared = DownloadServices()
    
    /*-----------downloading school's data and taking care of nil values or absence of keys in json objects-------------*/
    func downloadSchoolData(completion : @escaping([NYCSchoolData]) -> Void)
    {
        var schoolNames = [NYCSchoolData]()
        let url = URL(string: schoolNameURL)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil
            {
                if let dataValues = data
                {
                    do
                    {
                        let jsonData = try JSONSerialization.jsonObject(with: dataValues, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                        for list in jsonData
                        {
                            let detailedData = list as! NSDictionary
                            let schoolName = detailedData["school_name"] as? String ?? self.notAvailable
                            let phoneNumber = detailedData["phone_number"] as? String ?? self.notAvailable
                            let faxNumber = detailedData["fax_number"] as? String ?? self.notAvailable
                            let schoolEmail = detailedData["school_email"] as? String ?? self.notAvailable
                            let website = detailedData["website"] as? String ?? self.notAvailable
                            let zip = detailedData["zip"] as? String ?? self.notAvailable
                            let address = detailedData["primary_address_line_1"] as? String ?? self.notAvailable
                            let city = detailedData["city"] as? String ?? self.notAvailable
                            schoolNames.append(NYCSchoolData(name: schoolName.uppercased(), phoneNumber: phoneNumber, faxNumber: faxNumber, email: schoolEmail, website: website, address: address, city: city, zip: zip))
                        }
                        completion(schoolNames)
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
            else
            {
                print("unable to download data")
            }
        }
        task.resume()
    }
    
    /*--------------downloading sat values and taking care of nil values or absence of keys in json objects---------------*/
    func downloadSatData(completion : @escaping([SatSchoolData]) -> Void)
    {
        var satSchoolDetails : [SatSchoolData] = [SatSchoolData]()
        let url = URL(string: satScoresURL)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil
            {
                if let dataValues = data
                {
                    do
                    {
                        let jsonData = try JSONSerialization.jsonObject(with: dataValues, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
                        for list in jsonData
                        {
                            let detailedData = list as! NSDictionary
                            let name = detailedData["school_name"] as? String ?? self.notAvailable
                            let readingScore = detailedData["sat_critical_reading_avg_score"] as? String ?? self.notAvailable
                            let writingScore = detailedData["sat_writing_avg_score"] as? String ?? self.notAvailable
                            let mathScore = detailedData["sat_math_avg_score"] as? String ?? self.notAvailable
                            let totalTestTakers = detailedData["num_of_sat_test_takers"] as? String ?? self.notAvailable
                            satSchoolDetails.append(SatSchoolData(name: name.uppercased(), reading: readingScore, writing: writingScore, math: mathScore, testTakers: totalTestTakers))
                        }
                        completion(satSchoolDetails)
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
            else
            {
                print("unable to download data")
            }
        }
        task.resume()
    }
    
}
