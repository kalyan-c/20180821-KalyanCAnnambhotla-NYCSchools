//
//  DetailsViewController.swift
//  20180821-KalyanChakravarthyAnnambhotla-NYCSchools
//
//  Created by kalyan chakravarthy on 8/21/18.
//  Copyright © 2018 coders. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController
{
    
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var faxNumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var zipLabel: UILabel!
    @IBOutlet var websiteAddressLabel: UILabel!
    @IBOutlet var emailAddressLabel: UILabel!
    @IBOutlet var testTakersLabel: UILabel!
    @IBOutlet var mathLabel: UILabel!
    @IBOutlet var readingLabel: UILabel!
    @IBOutlet var writingLabel: UILabel!
    
    var schoolDetails : NYCSchoolData?
    var satDetails : SatSchoolData?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateData()
    }
    
    /* ---- View will be updated based on the details received -----*/
    func updateData()
    {
        schoolNameLabel.text = schoolDetails?.schoolName
        phoneNumberLabel.text = schoolDetails?.phoneNumber
        faxNumberLabel.text = schoolDetails?.faxNumber
        addressLabel.text = (schoolDetails?.address)! + ", " + (schoolDetails?.city)!
        zipLabel.text = schoolDetails?.zip
        websiteAddressLabel.text = schoolDetails?.website
        emailAddressLabel.text = schoolDetails?.email
        
        testTakersLabel.text = satDetails?.satTotalTestTakers
        readingLabel.text = satDetails?.satReadingScore
        writingLabel.text = satDetails?.satWritingScore
        mathLabel.text = satDetails?.satMathScore
    }

}
