//
//  HomeViewController.swift
//  CryptoApp
//
//  Created by Ferhat Ayar on 15.03.2024.
//

import UIKit

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var cryptoVM = CryptoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    func getData(){
        cryptoVM.viewModelGetData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoVM.cryptoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoCell", for: indexPath) as! CryptoTableViewCell
        
        cell.cryptoSymbol.text = cryptoVM.cryptoArray[indexPath.row].symbol
        cell.cryptoPrice.text = String(cryptoVM.cryptoArray[indexPath.row].current_price)
        cell.cryptoPriceChance.text = String(cryptoVM.cryptoArray[indexPath.row].price_change_percentage_24h)
        if cryptoVM.cryptoArray[indexPath.row].price_change_percentage_24h < 0 {
            cell.cryptoPriceChance.backgroundColor = UIColor.red
        }else{
            cell.cryptoPriceChance.backgroundColor = UIColor.green
        }
        
        let imageString = cryptoVM.cryptoArray[indexPath.row].image
        
        if let imageUrl = URL(string: imageString), let imageData = try? Data(contentsOf: imageUrl){
            cell.cryptoImageView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectCrypto = cryptoVM.cryptoArray[indexPath.row]
        
        guard let detailsVC = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DetailsViewController else {return}
        detailsVC.cryptoData  = selectCrypto
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        guard let profileVC = self.storyboard?.instantiateViewController(identifier: "ProfileVC") as? ProfileViewController else {return}
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @IBAction func goFavoriButtonClicked(_ sender: Any) {
    }
    

}
