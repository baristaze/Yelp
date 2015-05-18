//
//  ComboCell.swift
//  Yelp
//
//  Created by Baris Taze on 5/17/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol ComboCellDelegate {
    
    optional func comboCell(comboCell:ComboCell, didExpansionChanged value:Bool)
}

class ComboCell: UITableViewCell {

    var isExpanded = true
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    weak var delegate:ComboCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onButton(sender: AnyObject) {
        isExpanded = !isExpanded
        self.delegate?.comboCell?(self, didExpansionChanged:isExpanded)
    }
}
