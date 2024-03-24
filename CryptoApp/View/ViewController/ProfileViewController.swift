//
//  ProfileViewController.swift
//  CryptoApp
//
//  Created by Ferhat Ayar on 15.03.2024.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
    }
    
    
    
    @IBAction func signOutButtonClicked(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
        }catch{
            print("Çıkış Yapılamadı \(error.localizedDescription) hatası alındı")
        }
        
    }
    

}
