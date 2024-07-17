//
//  TodoScreenViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 17/07/24.
//

import UIKit

class TodoScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewController.register(UINib(nibName: "TodoItemTableViewCell", bundle: nil), forCellReuseIdentifier: "TodoItemTableViewCell")
                TableViewController.dataSource = self
                TableViewController.delegate = self
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
                    cell.leftImage.image = UIImage(named: "checkmark")
                    cell.headingLabel.text = "Meeting with a client"
                    cell.descriptionLabel.text = "Discuss about the tasks when will be..."
                    cell.deadlineLabel.text = "12:00 - 13:00"
                } else if indexPath.row == 1 {
                    cell.colorLine.backgroundColor = .orange
                    cell.leftImage.image = UIImage(named: "bell")
                    cell.headingLabel.text = "Call Sam."
                    cell.descriptionLabel.text = "Ask about something..."
                    cell.deadlineLabel.text = "Until 6:00 pm"
                } else {
                    cell.colorLine.backgroundColor = .blue
                    cell.leftImage.image = UIImage(named: "list")
                    cell.headingLabel.text = "Glossary List"
                    cell.descriptionLabel.text = "Discuss about the tasks when will be..."
                    cell.deadlineLabel.text = "Today"
                }
                
                return cell
    }
    

    @IBOutlet weak var TableViewController: UITableView!
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
