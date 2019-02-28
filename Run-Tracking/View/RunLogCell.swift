//
//  RunLogCell.swift
//  Run-Tracking
//
//  Created by sHiKoOo on 2/28/19.
//  Copyright © 2019 sHiKoOo. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(run: Run) {
        self.runDurationLbl.text = run.duration.formatTimeDurationToString()
        self.totalDistanceLbl.text = "\(run.distance) m"
        self.dateLbl.text = run.date.getDateString()    // to get another date format and be as string
    }
    

}
