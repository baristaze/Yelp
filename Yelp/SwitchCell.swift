//
//  FilterCell.swift
//  Yelp
//
//  Created by Baris Taze on 5/17/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell:SwitchCell, didChangeValue value:Bool)
}

class SwitchCell: UITableViewCell {
    
    weak var delegate:SwitchCellDelegate?
    
    @IBOutlet weak var theLabel: UILabel!
    @IBOutlet weak var theSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onSwitchValueChanged(sender: AnyObject) {
        self.delegate?.switchCell?(self, didChangeValue:theSwitch.on)
    }
}
