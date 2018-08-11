//
//  ViewController.swift
//  myr-crypto
//
//  Created by PPAS RATU FOUR on 11/08/2018.
//  Copyright © 2018 Hafez Busra. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController ,UIPickerViewDelegate ,UIPickerViewDataSource{

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cryptoPicker: UIPickerView!
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/"
    let cryptoArray = ["BTC", "ETH"]
    var finalURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cryptoPicker.delegate = self
        cryptoPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return cryptoArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return cryptoArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        finalURL = baseURL + cryptoArray[row] + "MYR"
        print(finalURL)

        ///getAPIData(url: finalURL)
        
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getAPIData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the requested data")
                    let dataJSON : JSON = JSON(response.result.value!)
                    
                    self.updateCryptoData(json: dataJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
        
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateCryptoData(json : JSON) {
        
        if let cryptoResult = json["ask"].double {
            
            
            
            priceLabel.text = cryptoSelected + String(cryptoResult)
            
            
        }else{
            
            priceLabel.text = String("Price Unvaliable")
        }
        
        
    }
    
    
    


}


    
    



