//
//  PopMovieTableViewCell.swift
//  TestAPIAPP
//
//  Created by Simizu Yorinori Cintia Y. on 4/22/18.
//  Copyright © 2018 Simizu Yorinori Cintia Y. All rights reserved.
//

import UIKit

class PopMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
