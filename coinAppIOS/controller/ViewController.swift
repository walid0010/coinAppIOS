//
//  ViewController.swift
//  coinAppIOS
//
//  Created by chekir walid on 28/7/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self //protocol communication view controller get data into the phone
        currencyPicker.dataSource = self// nbr of column and row
        currencyPicker.delegate = self//update picker with some titles and detec when it is interacted with
        coinManager.performRequest(for: "AUD")
    }
    
}

extension ViewController: CoinManagerDelegate {
    func didUpdateCoin(price: String, currency: String) {
        print("===>\(price)")
        print("===>\(currency)")
        DispatchQueue.main.async {
            self.bitcoinLabel.text = currency
            self.currencyLabel.text = price
        }
    }
    
    func didFailedWithError(error: Error) {
        print(error)
    }
    
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {//number of column
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {//number of rows
        return coinManager.currencyArray.count
    }
    //display all curency on the currencypicker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // with delegate we display content
        return coinManager.currencyArray[row]
    }
    //get current currency selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        coinManager.performRequest(for: selectedCurrency)
    }
}
