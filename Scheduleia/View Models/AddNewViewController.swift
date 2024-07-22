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
    
    var titleString: String?
    var descriptionString: String?
    var priorityEdit: Int?
    var deadLineEdit: String?
    
    @IBAction func SavebuttonTapped(_ sender: Any) {
        if let _ = titleString {
            updateData(whereField: "title", isEqualTo: titleString!)
            if let navigationController = self.navigationController {
                let viewControllers = navigationController.viewControllers
                let numberOfViewControllers = viewControllers.count
                
                if numberOfViewControllers >= 3 {
                    let targetViewController = viewControllers[numberOfViewControllers - 3]
                    let viewControllerName = String(describing: type(of: targetViewController))
                    print(viewControllerName)
                    if viewControllerName != "TodoScreenViewController" && viewControllerName != "TabBarViewController"{
                        navigationController.popViewController(animated: true)
                    } else {
                        navigationController.popToViewController(targetViewController, animated: true)
                    }
                } else {
                    navigationController.popViewController(animated: true)
                }
            }
        }
        else {
            if let todoTitle = newTitle?.text , !todoTitle.isEmpty
                ,let todoDescription = newDescription?.text
                ,let todoDeadline = datePick?.date
                ,let todoSender = Auth.auth().currentUser?.email {
                let todoDate = Date()
                let dateFormatter = DateFormatter()
                let date = todoDeadline
                dateFormatter.dateFormat = "dd MMMM yy HH:mm a"
                let dateString = dateFormatter.string(from: date)
                let createdDate = dateFormatter.string(from: todoDate)
                let newDoc = db.collection("todoData").document()
                newDoc.setData([                             "title" : todoTitle,
                                                             "description" : todoDescription,
                                                             "deadline" : dateString,
                                                             "priority" : taskPriority,
                                                             "email" : todoSender,
                                                             "isDone": false,
                                                             "docId": newDoc.documentID,
                                                             "time" : createdDate],
                                                      completion: nil)
                print("in")
            }else{
                print("err")
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let titleString {
            newTitle.text = titleString
        }
        if let descriptionString {
            newDescription.text = descriptionString
        }
        
        if let priorityEdit {
            switch priorityEdit{
            case 0:
                self.setPriorityImage.image = #imageLiteral(resourceName: "circle")
                self.taskPriority = 0
                self.setPriorityLabel.text = "High Priority"
            case 1:
                self.setPriorityImage.image = #imageLiteral(resourceName: "circle (1)")
                self.taskPriority = 1
                self.setPriorityLabel.text = "Medium Priority"
            case 2:
                self.setPriorityImage.image = #imageLiteral(resourceName: "full-moon")
                self.taskPriority = 2
                self.setPriorityLabel.text = "Low Priority"
            default:
                print("gdhd")
            }
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yy HH:mm a"
        
        if let deadLineEdit, let dateInDate = dateFormatter.date(from: deadLineEdit) {
            datePick.setDate(dateInDate, animated: true)
        }
        
        
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
        if priorityEdit == nil {
            setPriorityImage.image = #imageLiteral(resourceName: "exclamation-mark")
        }
    }
    
    func updateData(whereField field: String, isEqualTo value: Any  ) {
        guard  let ttext = newTitle.text, !ttext.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Heading must not be empty", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alert.addAction(action)
            self.present(alert, animated: true)
            return
        }
        
        let documentRef = db.collection("todoData").whereField(field, isEqualTo: value)
        let msgDate = Date().timeIntervalSince(self.datePick.date)
        let date = datePick.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd MMMM yy HH:mm a"
        let dateString = dateFormatter.string(from: date)
        
        documentRef.getDocuments{(querySnapshot, error) in
            if let _ = error {
                print("Error getting documents")
            }else{
                for document in querySnapshot!.documents {
                    let updatedData: [String: Any] = [
                        "title": self.newTitle.text!,
                        "description": self.newDescription.text!,
                        "deadline": dateString,
                        "priority": self.taskPriority,
                        "email": Auth.auth().currentUser?.email ?? "",
                        "time": msgDate]
                    document.reference.updateData(updatedData) { error in
                        if let error = error {
                            print("Error updating document: \(error.localizedDescription)")
                        } else {
                            print("Successfully updated todo with ID: \(document.documentID)")
                        }
                    }
                }
            }
        }
    }
}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


