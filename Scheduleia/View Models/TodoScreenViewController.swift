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
                                let time = data["time"] as? Int
                                
                                if(Auth.auth().currentUser?.email == email){
                                    let todo = TodoModel(
                                        title:title,
                                        description: description,
                                        time: time ?? 0,
                                        priority: priority,
                                        email: email,
                                        deadline: deadline
                                    )
                                    
                                    self.model.append(todo)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewController.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")
        TableViewController.dataSource = self
        TableViewController.delegate = self
        addNewButton.layer.cornerRadius = addNewButton.frame.size.width/4
        addNewButton.clipsToBounds = true
        TableViewController.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        loadTodoData()
        // Do any additional setup after loading the view.
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
        cell.Description.text = model[indexPath.row].title
        cell.Details.text = model[indexPath.row].description
        cell.Deadline.text = model[indexPath.row].deadline
//
        return cell
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
        }

    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

