//
//  RegisterViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 16/07/24.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func RegisterButtonTapped(_ sender: UIButton) {
        if let email = usernameTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    let alert = UIAlertController(title: "Error occured", message: e.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "okay", style: .cancel, handler: {_ in
                        self.usernameTextField.text = ""
                        self.passwordTextField.text = ""
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }else{
                    self.performSegue(withIdentifier: "TodoScreenViewController", sender: self)
                }
            }
        }
        
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
