//
//  CustomConfigTableViewCell.swift
//  Relogio
//
//  Created by Luicil Fernandes on 05/03/16.
//  Copyright © 2016 Luicil Fernandes. All rights reserved.
//

import UIKit

class CustomConfigTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelColorCell: UILabel!
    @IBOutlet weak var editColorBtn: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
