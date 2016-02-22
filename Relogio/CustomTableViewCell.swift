//
//  CustomTableViewCell.swift
//  Relogio
//
//  Created by Luicil Fernandes on 21/02/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var CustomLabel: UILabel!
    @IBOutlet weak var excBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
