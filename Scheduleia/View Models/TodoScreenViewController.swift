//
//  TodoScreenViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 17/07/24.
//

import UIKit

class TodoScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var TableViewController: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewController.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")
                TableViewController.dataSource = self
                TableViewController.delegate = self
        
        let button = UIButton()
                button.setTitle("Add Task", for: .normal)
                button.backgroundColor = .systemBlue
                
                button.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(button)
                        
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
                
                if let tabBarHeight = tabBarController?.tabBar.frame.size.height {
                            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(50 + tabBarHeight)).isActive = true
                        }
                
                button.layer.cornerRadius = button.frame.size.width/2
                button.clipsToBounds = true
                
//                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                    

                
                
//                button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
                    

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
                    cell.Details.text = "Discuss about the tasks when will be..."
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
                    cell.Details.text = "Discuss about the tasks when will be..."
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
                return 20 // Space between cells
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

