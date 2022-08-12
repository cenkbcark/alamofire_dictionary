//
//  KelimelerTableViewCell.swift
//  udemy_alamofire_dictionary
//
//  Created by Cenk Bahadır Çark on 11.08.2022.
//

import UIKit

class KelimelerTableViewCell: UITableViewCell {

    @IBOutlet weak var turkceLabel: UILabel!
    @IBOutlet weak var ingilizceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
