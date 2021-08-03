//
//  CoinManager.swift
//  coinAppIOS
//
//  Created by chekir walid on 28/7/2021.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(price: String, currency: String)
    func didFailedWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = ""
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?//protocol communication view controller
    
    func performRequest(for currency: String) {//with when method call and urlString use inside method
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
        if let url = URL(string: urlString) {//1
            let session = URLSession(configuration: .default)//2
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailedWithError(error: error!)//protocol communication view controller
                    return
                }
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(coinData: safeData){
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        delegate?.didUpdateCoin(price: priceString, currency: currency)//protocol communication view controller
                    }
                }
            }//3
            task.resume()//4
        }
    }
    
    func parseJSON(coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CoinData.self, from: coinData)//CoinData struc herit from decodable
            let price = decoderData.rate
            
            return price
        } catch {
            delegate?.didFailedWithError(error: error)//protocol communication view controller
            return nil
        }
    }

    func getCoinPrice(for currency: String)  {
        print(currency)
    }
}
