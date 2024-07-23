//
//  TodoScreenViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 17/07/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class TodoScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let db = Firestore.firestore()
    
    var model = [TodoModel]()
    
    @IBOutlet weak var TableViewController: UITableView!
    
    @IBOutlet weak var addNewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewController.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")
        TableViewController.dataSource = self
        TableViewController.delegate = self
        addNewButton.layer.cornerRadius = addNewButton.frame.size.width/4
        addNewButton.clipsToBounds = true
        loadTodoData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemTableViewCell", for: indexPath) as! TodoItemTableViewCell
        
        switch model[indexPath.row].priority {
        case 0:
            cell.colorLine.backgroundColor = .red
        case 1:
            cell.colorLine.backgroundColor = .orange
        case 2:
            cell.colorLine.backgroundColor = .blue
        default:
            cell.colorLine.backgroundColor = .black
        }
        cell.priority = model[indexPath.row].priority
        cell.Description.text = model[indexPath.row].title
        cell.descriptionFilled = model[indexPath.row].description
        let index = model[indexPath.row].deadline.index(model[indexPath.row].deadline.startIndex, offsetBy: 10)
        let dateToShow = String(model[indexPath.row].deadline[..<index])
        if(model[indexPath.row].isDone == true){
            cell.checkbox.isSelected = true
        }
        else{
            cell.checkbox.isSelected = false
        }
        cell.docId = model[indexPath.row].docId
        cell.Deadline.text = dateToShow
        cell.title = model[indexPath.row].title
        cell.isDone = model[indexPath.row].isDone
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "testVC") as? SingleTaskViewController
        let task = model[indexPath.row]
        vc?.titleString = task.title
        vc?.descriptionString = task.description
        vc?.createdString = String(task.time)
        vc?.deadlineString = task.deadline
        vc?.priority = task.priority
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let confirm = UIAlertController(title: "Are you sure you want to delete?", message: nil, preferredStyle: .alert)
            confirm.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: {
                _ in
                self.deleteTodos(whereField: "title", isEqualTo: self.model[indexPath.row].title)
                self.model.remove(at: indexPath.row)
                self.TableViewController.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }))
            confirm.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            self.present(confirm, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    
    func deleteTodos(whereField field: String, isEqualTo value: Any) {
        let todoQuery = db.collection("todoData").whereField(field, isEqualTo: value)
        todoQuery.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete { error in
                        if let error = error {
                            print("Error removing document: \(error.localizedDescription)")
                        } else {
                            print("Successfully deleted todo with ID: \(document.documentID)")
                        }
                    }
                }
            }
        }
    }
    func loadTodoData() {
        db.collection("todoData").order(by: "time")
            .addSnapshotListener({(QuerySnapshot,error) in
                self.model = []
                if((error) != nil){
                    print(error!)
                }else{
                    if let documents = QuerySnapshot?.documents{
                        for document in documents {
                            let data = document.data()
                            if let title = data["title"] as? String,
                               let description = data["description"] as? String,
                               let deadline = data["deadline"] as?  String,
                               let priority = data["priority"] as? Int,
                               let email = data["email"] as? String {
                                let time = data["time"] as? String
                                let isDone = data["isDone"] as? Bool
                                let docId = data["docId"] as? String
                                
                                if(Auth.auth().currentUser?.email == email){
                                    let todo = TodoModel(
                                        title:title,
                                        description: description,
                                        time: time ?? "",
                                        priority: priority,
                                        email: email,
                                        deadline: deadline,
                                        isDone: isDone ?? false,
                                        docId: docId ?? "" )
                                    
                                    self.model.append(todo)
                                        }
                                self.model.sort { (item1, item2) -> Bool in
                                                                if item1.isDone == item2.isDone{
                                                                    let dateFormatter = DateFormatter()
                                                                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                                                    let date1 = dateFormatter.date(from: item1.deadline) ?? Date()
                                                                    let date2 = dateFormatter.date(from: item2.deadline) ?? Date()
                                                                    return date1 < date2
                                                                }
                                                                return !item1.isDone && item2.isDone
                                                            }
                                DispatchQueue.main.async {
                                    self.TableViewController.reloadData()
                                }
                            }
                        }
                    }
                }
            })
    }
}

    
extension TodoScreenViewController: deleteTodoItemFromTable{
    
    func taskCompleted(_ cell: TodoItemTableViewCell) {
        guard let docId = cell.docId , let isDone = cell.isDone else { return }
        
        db.collection("todoData").document(docId).updateData([
            "isDone": !isDone ]
        ) { error in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true)
            } else {
                DispatchQueue.main.async {
                    self.loadTodoData()
                    self.TableViewController.reloadData()
                }
            }
        }
    }
    
        func editCell(_ cell: TodoItemTableViewCell) {
            //var stringPriority: String
            
//            switch cell.priority{
//            case 0:
//                stringPriority = "High"
//            case 1:
//                stringPriority = "Medium"
//            case 2:
//                stringPriority = "Low"
//            default:
//                stringPriority = "Unspecified"
//            }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "addNewVC") as? AddNewViewController
            
            vc?.titleString = cell.title
            vc?.descriptionString = cell.descriptionFilled
            vc?.priorityEdit = cell.priority
            vc?.deadLineEdit = cell.Deadline.text
            
            self.navigationController?.pushViewController(vc!, animated: true)
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
