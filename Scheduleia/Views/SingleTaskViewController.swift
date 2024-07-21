//
//  SingleTaskViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 21/07/24.
//

import UIKit

class SingleTaskViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var createdLabel: UILabel!
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var priorityLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    var titleString: String?
    var descriptionString: String?
    var createdString: String?
    var priority: Int?
    var deadlineString: String?

    
    @IBAction func editButtonTapped(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString
        descriptionLabel.text = descriptionString
        createdLabel.text = createdString
        deadlineLabel.text = deadlineString
        switch priority {
        case 0:
            priorityLabel.text = "High"
        case 1:
            priorityLabel.text = "Medium"
        case 2:
            priorityLabel.text = "Low"
        default:
            priorityLabel.text = "Unspecified"
        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
