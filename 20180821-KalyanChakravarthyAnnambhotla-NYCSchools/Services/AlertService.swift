//
//  AlertService.swift
//  20180821-KalyanChakravarthyAnnambhotla-NYCSchools
//
//  Created by kalyan chakravarthy on 8/21/18.
//  Copyright © 2018 coders. All rights reserved.
//

import Foundation
import UIKit

class AlertService
{
    private init() {}
    
    /*---------setting alert if no data avilable for the school selected--------*/
    static func noDataAvailable(in vc: HomeViewController, name: String)
    {
        let alert = UIAlertController(title: "\(name)", message: "Sorry!, No data Available at this time", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(okay)
        vc.present(alert, animated: true)
    }
}

