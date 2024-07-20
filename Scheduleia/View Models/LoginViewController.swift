//
//  LoginViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 16/07/24.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = userNameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult,error in
                if let e = error {
                    print(e)
                    let alert = UIAlertController(title: "Error occured", message: e.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "okay", style: .cancel, handler: {_ in
                        self?.userNameTextField.text = ""
                        self?.passwordTextField.text = ""
                    })
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                }else{
                    self?.performSegue(withIdentifier: "loginSegue", sender: self)
                }
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.size.width/4
        loginButton.clipsToBounds = false
        
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
