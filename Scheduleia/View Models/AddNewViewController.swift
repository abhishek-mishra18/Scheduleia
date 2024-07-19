//
//  AddNewViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 19/07/24.
//

import UIKit

class AddNewViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var setPriorityButton: UIButton!
    
    @IBOutlet weak var ListTableView: UITableView!
    
    @IBOutlet weak var setPriorityImage: UIImageView!
    
    @IBOutlet weak var addRow: UIButton!
    
    
    @IBAction func rowButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Input Required", message: "Please enter a value", preferredStyle: .alert)
        
                alertController.addTextField { textField in
                    textField.placeholder = "Enter something..."
                    textField.keyboardType = .default
                }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                    if let textField = alertController.textFields?.first {
                        let inputText = textField.text
                        print("Input text: \(inputText ?? "")")
                    }
                }
                alertController.addAction(okAction)

                present(alertController, animated: true, completion: nil)
            }
    override func viewDidLoad() {
        super.viewDidLoad()
        ListTableView.dataSource = self
        ListTableView.delegate = self
        
        addRow.layer.cornerRadius = addRow.frame.size.width/4
        addRow.clipsToBounds = true
        
        let highPriorityAction = UIAction(title: "High Priority", image: UIImage(systemName: "exclamationmark.circle.fill")) { action in
                    print("High Priority selected")
                }
        let mediumPriorityAction = UIAction(title: "Medium Priority", image: UIImage(systemName: "exclamationmark.circle")) { action in
                    self.setPriorityImage.image = #imageLiteral(resourceName: "bell")
                }

        let lowPriorityAction = UIAction(title: "Low Priority", image: UIImage(systemName: "circle")) { action in
                    self.setPriorityImage.image = #imageLiteral(resourceName: "list")
                }
        let menu = UIMenu(title: "", children: [highPriorityAction, mediumPriorityAction, lowPriorityAction])
        
        setPriorityButton.menu = menu
        setPriorityButton.showsMenuAsPrimaryAction = true
        
        setPriorityImage.image = #imageLiteral(resourceName: "exclamation-mark")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.listCellLabel.text = "Row \(indexPath.row)"
                return cell
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
