//
//  ClassTableViewCell.swift
//  Steer
//
//  Created by Mac Sierra on 12/28/17.
//  Copyright © 2017 Will Wang. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    @IBOutlet weak var URL: UILabel!
    @IBOutlet weak var ClassName: UILabel!
    @IBOutlet weak var ClassSchool: UILabel!
    @IBOutlet weak var AddClass: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func AddClass(_ sender: UIButton) {
        let classname = self.ClassName.text
        let schoolname = self.ClassSchool.text
        let url = self.URL.text
        print(classname!, schoolname!, url!)
    }
}
