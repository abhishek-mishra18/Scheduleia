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
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func RegisterButtonTapped(_ sender: UIButton) {
        activityIndicator.startAnimating()
        if let email = usernameTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error)
                    let alert = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "okay", style: .cancel, handler: {_ in
                        self.usernameTextField.text = ""
                        self.passwordTextField.text = ""
                    })
                    alert.addAction(action)
                    self.activityIndicator.stopAnimating()
                    self.present(alert, animated: true)
                }else{
                    self.activityIndicator.stopAnimating()
                    self.performSegue(withIdentifier: "TodoScreenViewController", sender: self)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = registerButton.frame.size.width/4
        registerButton.clipsToBounds = false
        setupActivityIndicator()
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
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
