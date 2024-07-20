//
//  AddNewViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 19/07/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class AddNewViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var setPriorityButton: UIButton!
    
    @IBOutlet weak var setPriorityImage: UIImageView!
    
    @IBOutlet weak var setPriorityLabel: UILabel!
    
    @IBOutlet weak var newTitle: UITextField!
    
    @IBOutlet weak var addRow: UIButton!
    
    @IBOutlet weak var newDescription: UITextField!
    
    @IBOutlet weak var datePick: UIDatePicker!
    
    var taskPriority = 0
    
    @IBAction func SavebuttonTapped(_ sender: Any) {
        if let todoTitle = newTitle?.text , !todoTitle.isEmpty
            ,let todoDescription = newDescription?.text
            ,let todoDeadline = datePick?.date
            ,let todoSender = Auth.auth().currentUser?.email {
            let todoDate = Date().timeIntervalSince1970
            let dateFormatter = DateFormatter()
            let date = todoDeadline
            dateFormatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            
            db.collection("todoData").addDocument(data: ["title" : todoTitle,
                                                         "description" : todoDescription,
                                                         "deadline" : dateString,
                                                         "priority" : taskPriority,
                                                         "email" : todoSender,
                                                         "time" : todoDate],
                                                  completion: nil)
            print("in")
        }else{
            print("err")
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //addRow.layer.cornerRadius = addRow.frame.size.width/4
        //addRow.clipsToBounds = true
        
        let highPriorityAction = UIAction(title: "High Priority", image: UIImage(systemName: "exclamationmark.circle.fill")) { action in
            self.setPriorityImage.image = #imageLiteral(resourceName: "circle")
            self.taskPriority = 0
            self.setPriorityLabel.text = "High Priority"
                }
        let mediumPriorityAction = UIAction(title: "Medium Priority", image: UIImage(systemName: "exclamationmark.circle")) { action in
                    self.setPriorityImage.image = #imageLiteral(resourceName: "circle (1)")
                    self.taskPriority = 1
                    self.setPriorityLabel.text = "Medium Priority"
                }

        let lowPriorityAction = UIAction(title: "Low Priority", image: UIImage(systemName: "circle")) { action in
                    self.setPriorityImage.image = #imageLiteral(resourceName: "full-moon")
                    self.taskPriority = 2
                    self.setPriorityLabel.text = "Low Priority"

                }
        let menu = UIMenu(title: "", children: [highPriorityAction, mediumPriorityAction, lowPriorityAction])
        
        setPriorityButton.menu = menu
        setPriorityButton.showsMenuAsPrimaryAction = true
        
        setPriorityImage.image = #imageLiteral(resourceName: "exclamation-mark")
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
