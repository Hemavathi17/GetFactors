//
//  FactorsCollectionCell.swift
//  GetFactors
//
//  Created by ev_mac6 on 23/12/17.
//  Copyright © 2017 ev_mac6. All rights reserved.
//

import UIKit

class FactorsCollectionCell: UICollectionViewCell
{
    @IBOutlet weak var valueLbl: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code 
        valueLbl.layer.cornerRadius     = 2.0
        valueLbl.layer.masksToBounds    = true
        valueLbl.layer.borderColor      = UIColor.blue.cgColor
        valueLbl.layer.borderWidth      = 1.5
    }

}
