//
//  ViewController.swift
//  CryptoApp
//
//  Created by Ferhat Ayar on 15.03.2024.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        
        let currentUser = Auth.auth().currentUser
        
        if currentUser != nil {
            guard let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController else {return}
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
        
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != ""{
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { authData, error in
                if error != nil {
                    self.showAlert(titleMessage: "Error", messageOutput: error?.localizedDescription ?? "")
                }else{
                    guard let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController else {return}
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
            
        }else{
            self.showAlert(titleMessage: "Error", messageOutput: "Email/Password?")
        }
        
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authData, error in
                if error != nil {
                    self.showAlert(titleMessage: "Error", messageOutput: error?.localizedDescription ?? "")
                }else {
                    guard let homeVC = self.storyboard?.instantiateViewController(identifier: "HomeVC") as? HomeViewController else {return}
                    self.navigationController?.pushViewController(homeVC, animated: true)
                }
            }
        }else{
            self.showAlert(titleMessage: "Error", messageOutput: "Email/Password?")
        }
        
    }
    
    func showAlert(titleMessage:String , messageOutput : String){
        let alert = UIAlertController(title: titleMessage, message: messageOutput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

}

