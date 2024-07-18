//
//  TodoItemTableViewCell.swift
//  Scheduleia
//
//  Created by Raramuri on 17/07/24.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var colorLine: UIView!
    
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var Deadline: UILabel!
    @IBOutlet weak var Details: UILabel!
    @IBOutlet weak var Description: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.images.layer.cornerRadius = images.frame.size.width / 2
        images.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
//    func commonInit(_name: String){
//        self
//    }
    
}
