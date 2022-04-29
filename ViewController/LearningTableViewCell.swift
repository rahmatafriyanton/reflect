//
//  LearningTableViewCell.swift
//  NanoTest
//
//  Created by Rahmat Afriyanton on 28/04/22.
//

import UIKit

class LearningTableViewCell: UITableViewCell {
	@IBOutlet weak var title: UILabel!
	@IBOutlet weak var currentSession: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		// Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
