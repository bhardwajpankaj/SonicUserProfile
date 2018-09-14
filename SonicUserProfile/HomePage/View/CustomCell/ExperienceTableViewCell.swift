//
//  ExperienceTableViewCell.swift
//  SonicUserProfile
//
//  Created by user on 04/09/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell,ReuseIdentifier ,NibLoadableView {

    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(jobTitle:String,roleTitle:String,datesTitle:String)
    {
        self.jobLabel.text = jobTitle
        self.roleLabel.text = roleTitle
        self.datesLabel.text = datesTitle
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
