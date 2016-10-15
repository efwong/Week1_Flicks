//
//  MovieItemTableViewCell.swift
//  Week1_Flicks
//
//  Created by Edwin Wong on 10/14/16.
//  Copyright © 2016 edwin. All rights reserved.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell {
    
    var movie:Movie?
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
