//
//  HomeViewController.swift
//  20180821-KalyanChakravarthyAnnambhotla-NYCSchools
//
//  Created by kalyan chakravarthy on 8/21/18.
//  Copyright © 2018 coders. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate
{
    var schoolData = [NYCSchoolData]()
    var satData = [SatSchoolData]()
    var satIndex = Int()
    var activityIndicatorView = UIActivityIndicatorView()
    
    //----------------Outlet for the tableview----------------//
    @IBOutlet var tableView: UITableView!
    @IBOutlet var schoolSearchBar: UISearchBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //-------------setting delegates & other attributes for tableview, search bar---------------//
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 85
        tableView.separatorStyle = .none
        schoolSearchBar.delegate = self
        updateUI()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        /*--------- calling the download method from Download services to get School Names to load in tableview, ui updates on main queue -------*/
        /*------- Activity indocator is shown until the data downloaded and presented in the tableview----------------*/
        DownloadServices.shared.downloadSchoolData { (data) in
            self.schoolData = data
            DispatchQueue.main.async
            {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    /*------Dismissing keyboard on search--------*/
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.schoolSearchBar.endEditing(true)
    }
    
    func updateUI()
    {
        /* ---------- setting image for navigation item --------*/
        /*----------activity indicator declared------------*/
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityIndicatorView.center = CGPoint(x: self.tableView.frame.size.width / 2.0, y: self.tableView.frame.size.height / 2.0)
        
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.startAnimating()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*-------------data passed from two service calls to other view-----------------*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "details"
        {
            let vc = segue.destination as! DetailsViewController
            let index = tableView.indexPathForSelectedRow?.row
            vc.schoolDetails = schoolData[index!]
            vc.satDetails = satData[satIndex]
        }
    }
}
extension HomeViewController : UITableViewDataSource, UITableViewDelegate
{
    /*-------------Tableview delegate methods-----------*/
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return schoolData.count
    }
    /*-------------to display data in tableview---------*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let data = schoolData[indexPath.row]
        cell.schoolCountLabel.text = "\(indexPath.row + 1).  "
        cell.schoolNameLabel.text = data.schoolName!
        return cell
    }
    
    /*-----------to setup alternative colors for cells in tableview---------------*/
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if (indexPath.row % 2) == 0
        {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
        else
        {
            cell.backgroundColor = UIColor.white
        }
    }
    
    /*-----------Service call to download the sat scores for respective schools is implemented only when particular school is selected---------------*/
    /*--------------- index of the selected school and it's respective index are stored to populate the data------*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var alertFalg = 0
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        let selectedValue = cell.schoolNameLabel.text
        DownloadServices.shared.downloadSatData { (data) in
            self.satData = data
            for i in 0 ..< self.satData.count
            {
                if (self.satData[i].satSchoolName! == selectedValue!)
                {
                    DispatchQueue.main.async
                    {
                        self.satIndex = i
                        self.performSegue(withIdentifier: "details", sender: self)
                    }
                    break
                }
                else
                {
                    alertFalg += 1
                }
            }
            /*----------Alert will shown if there is no data available from the service call------------*/
            if alertFalg == self.satData.count
            {
                AlertService.noDataAvailable(in: self, name: selectedValue!)
            }
        }
    }
}
