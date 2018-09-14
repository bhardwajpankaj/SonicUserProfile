//
//  ViewController.swift
//  SonicUserProfile
//
//  Created by user on 04/09/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import UIKit

enum cellType:String {
    case ProfileImage
    case Experience
    case Languages
    case noOfSections
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel:HomeViewModel?
    let imageCellHeight = 240
    let defaultCellHeight:CGFloat = 44.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = HomeViewModel()
        getViewmodelData()
        initializeTableViewElements()
        
    }
    
    func getViewmodelData()
    {
        viewModel?.getDataFromServer(completionHandler: { (dataReceived) in
            if(dataReceived == true)
            {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    private func initializeTableViewElements(){
        // Registering cell to the table view
        self.tableView?.rowHeight = UITableViewAutomaticDimension;
        self.tableView?.estimatedRowHeight = defaultCellHeight // set to your "average" cell height is
        tableView?.register(cell: ExperienceTableViewCell.self)
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeader")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case cellType.Experience.hashValue:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
            headerView.imageViw.image = #imageLiteral(resourceName: "green")
            headerView.titleLbl.text = cellType.Experience.rawValue  // set this however is appropriate for your app's model
            
            return headerView
        case cellType.ProfileImage.hashValue:
            let headerImage: UIImage = UIImage(named: "home")!
            let headerView = UIImageView(image: headerImage)
            return headerView
        default:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
            headerView.imageViw.image = #imageLiteral(resourceName: "blue")
            headerView.titleLbl.text = cellType.Languages.rawValue  // set this however is appropriate for your app's model
            return headerView
        }
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == cellType.ProfileImage.hashValue {
            return CGFloat(imageCellHeight)
        }else
        {
            return defaultCellHeight + 10 // 10 is for top seperator
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case cellType.Experience.hashValue:
            let cell:ExperienceTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
            if let profileData = viewModel?.availableProfile()?.jobs
            {
                let data:UserData = profileData[indexPath.row]
                cell.setupData(jobTitle: data.job ?? "", roleTitle: data.role ?? "", datesTitle: data.dates ?? "")
            }
            return cell
         case cellType.Languages.hashValue:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "English"
            return cell
        default:
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellType.noOfSections.hashValue
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case cellType.Experience.hashValue:
            return viewModel?.availableProfile()?.jobs?.count ?? 0
        case cellType.Languages.hashValue:
            return 1
        default:
            return 0
        }
    }
}
