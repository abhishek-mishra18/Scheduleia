//
//  ListTableViewCell.swift
//  Scheduleia
//
//  Created by Abhishek on 18/07/24.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var checkbox: UIButton!
    
    @IBOutlet weak var listCellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        checkbox.setImage(UIImage(systemName: "square"), for: .normal)
        checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
    }

    @IBAction func checkboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
