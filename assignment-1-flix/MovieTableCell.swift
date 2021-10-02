//
//  TableViewCell.swift
//  assignment-1-flix
//
//  Created by Aramis on 9/26/21.
//

import UIKit

class MovieCell: UITableViewCell {

   
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var lowerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
