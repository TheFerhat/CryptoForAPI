//
//  DetailsViewController.swift
//  CryptoApp
//
//  Created by Ferhat Ayar on 15.03.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailsSymbolText: UILabel!
    @IBOutlet weak var detailsPriceLabel: UILabel!
    @IBOutlet weak var detailsPriceChanceLabel: UILabel!
    @IBOutlet weak var detailsHightLabel: UILabel!
    @IBOutlet weak var detailsLowLabel: UILabel!
    @IBOutlet weak var favoriButton: UIButton!
    
    var cryptoData : CryptoModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        
        detailsGetData()
        
    }
    
    func detailsGetData(){
        detailsSymbolText.text = cryptoData?.symbol
        if let price = cryptoData?.current_price{
            detailsPriceLabel.text = String(price)
        }
        if let priceChance = cryptoData?.price_change_percentage_24h{
            detailsPriceChanceLabel.text = String(priceChance)
        }
        if let hightPrice = cryptoData?.high_24h{
            detailsHightLabel.text = String(hightPrice)
        }
        if let lowPrice = cryptoData?.low_24h{
            detailsLowLabel.text = String(lowPrice)
        }
    }
    
    @IBAction func favoriButtonClicked(_ sender: Any) {
        if favoriButton.tag == 0 {
            favoriButton.setImage(UIImage(systemName: "star.fill"), for: UIControl.State.normal)
            favoriButton.tag = 1
            
            let currentUser = Auth.auth().currentUser
            let currentUserId = currentUser?.uid
            
            
            
            let firebaseDatabase = Firestore.firestore()
            
            var firestoreReferance : DocumentReference? = nil
            
            let firePost = ["id":cryptoData?.id ?? "" , "image":cryptoData?.image ?? "" , "symbol":cryptoData?.symbol ?? "" , "currenUserId":currentUserId ?? "" , "price":cryptoData?.current_price ?? "", "priceChance": cryptoData?.price_change_percentage_24h ?? ""] as [String:Any]
            
            firestoreReferance = firebaseDatabase.collection("Crypto").addDocument(data: firePost, completion: { error in
                if error != nil {
                    self.showAlert(titleMessage: "Error", outputMessage: error?.localizedDescription ?? "")
                }
            })
            
        }else{
            favoriButton.setImage(UIImage(systemName: "star"), for: UIControl.State.normal)
            favoriButton.tag = 0
            
            Firestore.firestore().collection("Crypto").whereField("id", isEqualTo: cryptoData?.id ?? "").getDocuments { snapshot, error in
                if error != nil {
                    self.showAlert(titleMessage: "Error", outputMessage: error?.localizedDescription ?? "")
                }else if let document = snapshot?.documents.first {
                    
                    let documentId = document.documentID
                    Firestore.firestore().collection("Crypto").document(documentId).delete { error in
                        if error != nil {
                            self.showAlert(titleMessage: "Error", outputMessage: error?.localizedDescription ?? "")
                        }else {
                            print("Document Başarıyla Kaldırıldı..")
                        }
                    }
                    
                }
            }
            
        }
        
        
    }
    
    func showAlert(titleMessage : String , outputMessage : String) {
        let alert = UIAlertController(title: titleMessage, message: outputMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
