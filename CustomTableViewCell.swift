//
//  CustomTableViewCell.swift
//  FansArea
//
//  Created by 闵罗琛 on 2017/4/4.
//  Copyright © 2017年 闵罗琛. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var partLable: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
