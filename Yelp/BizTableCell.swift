//
//  BizTableCell.swift
//  Yelp
//
//  Created by Baris Taze on 5/17/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BizTableCell: UITableViewCell {

    @IBOutlet weak var bizPhotoView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bizNameLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
