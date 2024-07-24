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
    
    var activityIndicator: UIActivityIndicatorView!
    @IBAction func loginButtonTapped(_ sender: Any) {
        activityIndicator.startAnimating()
        if let email = userNameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    print(error)
                    let alert = UIAlertController(title: "Error occured", message: error.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "okay", style: .cancel, handler: { _ in
                        self?.userNameTextField.text = ""
                        self?.passwordTextField.text = ""
                    })
                    alert.addAction(action)
                    self?.activityIndicator.stopAnimating()
                    self?.present(alert, animated: true)
                }
                else{
                    self?.activityIndicator.stopAnimating()
                    self?.performSegue(withIdentifier: "loginSegue", sender: self)
                }
            }
        }
    }
    
    
    
    @IBAction func forgotPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email address", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let resetAction = UIAlertAction(title: "Reset", style: .default) { [weak self] (_) in
            guard let email = alert.textFields?.first?.text, !email.isEmpty else {
                let errorAlert = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(errorAlert, animated: true, completion: nil)
                return
            }
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    let errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(errorAlert, animated: true, completion: nil)
                } else {
                    let successAlert = UIAlertController(title: "Success", message: "Password reset email sent!", preferredStyle: .alert)
                    successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(successAlert, animated: true, completion: nil)
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = loginButton.frame.size.width/4
        loginButton.clipsToBounds = false
        
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
