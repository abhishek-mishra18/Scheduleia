//
//  TodoItemTableViewCell.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var colorLine: UIView!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var Deadline: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkbox.setImage(UIImage(systemName: "square"), for: .normal)
        checkbox.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        setupCell()
    }
    
    @IBAction func checkboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    private func setupCell() {
            self.contentView.layer.cornerRadius = 10
            self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 0.5
            self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
}
