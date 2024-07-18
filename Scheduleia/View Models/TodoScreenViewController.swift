//
//  TodoScreenViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 17/07/24.
//

import UIKit

class TodoScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var TableViewController: UITableView!
    
    @IBOutlet weak var addNewButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewController.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")
                TableViewController.dataSource = self
                TableViewController.delegate = self
        addNewButton.layer.cornerRadius = addNewButton.frame.size.width/4
        addNewButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemTableViewCell", for: indexPath) as! TodoItemTableViewCell
                
                // Configure the cell with example data
                if indexPath.row == 0 {
                    cell.colorLine.backgroundColor = .red
                    cell.images.image = UIImage(named: "check-mark")
                    cell.Description.text = "Meeting with a client"
                    cell.Details.text = "Discuss about the tasks..."
                    cell.Deadline.text = "12:00 - 13:00"
                } else if indexPath.row == 1 {
                    cell.colorLine.backgroundColor = .orange
                    cell.images.image = UIImage(named: "bell")
                    cell.Description.text = "Call Sam."
                    cell.Details.text = "Ask about something..."
                    cell.Deadline.text = "Until 6:00 pm"
                } else {
                    cell.colorLine.backgroundColor = .blue
                    cell.images.image = UIImage(named: "list")
                    cell.Description.text = "Glossary List"
                    cell.Details.text = "Discuss about the tasks..."
                    cell.Deadline.text = "Today"
                }
                
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 150
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

