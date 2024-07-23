//
//  TabBarViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 22/07/24.
//

import UIKit
import Firebase
import FirebaseAuth

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let gear = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: nil)
        let filter = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain,target: nil, action:nil)
        gear.tintColor = .black
        filter.tintColor = .black
        navigationItem.rightBarButtonItems = [gear,filter]
        let logoutAction = UIAction(title: "Logout") { action in
            let confirm = UIAlertController(title: "Are you sure, You want to log out?", message: nil, preferredStyle: .alert)
            confirm.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                _ in
                do {
                    try Auth.auth().signOut()
                    let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "viewId") as! ViewController
                    let navigationController = UINavigationController(rootViewController: loginVC)
                    navigationController.modalPresentationStyle = .fullScreen
                    self.present(navigationController, animated: true, completion: nil)}
                catch _ as NSError {
                    let alert = UIAlertController(title: "Error", message:  nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .cancel))
                    self.present(alert, animated: true)
                }
            }))
            confirm.addAction(UIAlertAction(title: "No", style: .default    , handler: nil))
            self.present(confirm,animated: true)
        }
        let themes = UIAction(title: "Themes  (Coming Soon...)") { _ in
        }
        let filterOption = UIAction(title: "Filter  (Coming Soon...)") { _ in
        }
        let menu = UIMenu(title: "" ,children: [logoutAction,themes])
        gear.menu = menu
        let filtermenu = UIMenu(title: "", children: [filterOption])
        filter.menu = filtermenu
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
