//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Doc Pulliam on 11/09/2019.
//  Copyright © 2019 Doc Pulliam. All rights reserved.
//

import Foundation


protocol CoinManagerDelegate {
    func didUpdateRate(_ currentRate: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "2025D7DF-CAB0-4D48-BD54-5A366087F02B"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate : CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
            performRequest(with: urlString)
      
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                 let currentRate = parseJson(safeData)
                 let currentRateString = String(format: "%.2f", currentRate!)
                 self.delegate?.didUpdateRate(currentRateString)
                    }
                }
            task.resume()
            }
      
        }
    
    
    
    func parseJson(_ data:Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    }

    

