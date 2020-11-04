//
//  ViewController.swift
//  StockApp
//
//  Created by 林青筠 on 11/4/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {
    let apiKey = "a12c93767924de0520b5707372fbe4b"
    let apiUrl = "https://financialmodelingprep.com/api/v3/profile/"
    
    @IBOutlet weak var txtStockName: UITextField!
    
    @IBOutlet weak var lblStockCeo: UILabel!
    
    @IBOutlet weak var lblStockPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func getStockValue(_ sender: Any) {
            guard let stockName = txtStockName.text else { return }
            let url = "\(apiURL)\(stockName)?apikey=\(apiKey)"
        
            getStockValue(stockURL: url, stockName: stockName)
        }
        
        func getStockValue(stockURL: String!, stockName: String!) {
            SwiftSpinner.show("Getting Stock value for \(stockName)")
            
            Alamofire.request(stockURL).responseJSON { (response) in
                SwiftSpinner.hide()
                if response.result.isSuccess{
                    guard let jsonString = response.result.value else { return }
                    guard let stockJSON: [JSON] = JSON(jsonString).array else { return }
                    
                    if stockJSON.count < 1 {return}
                    guard let price = stockJSON[0]["price"].double else { return }
                    guard let ceoName = stockJSON[0]["ceo"].rawString() else { return }
     
                    self.lblCEOName.text = "\(ceoName)"
                    self.lblStockPrice.text = "\(price)"
                }
            }
        }
}
