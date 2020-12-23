//
//  FastPriceNetworking.swift
//  FastPrice
//
//  Created by Sarthak Khillan on 15/12/20.
//

import UIKit

protocol FastPriceProtocolDelegate {
    func didFetchPrice(_ manager: FastPriceNetworking, fastPrice: FastPriceModel)
    func errorDidOccur(error: Error?)
}

struct FastPriceNetworking {
    var delegate: FastPriceProtocolDelegate?
    let url = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "apikey=688D3693-E3B2-4AD8-8D68-52A96C49A6EC"
    let currencyList = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func fetchPrice(ofUIPickerInputValue currencyNeeded: Int){
        let fetchString = "\(url + currencyList[currencyNeeded])?\(apiKey)"
        getPriceValue(with: fetchString)
    }
    
    func getPriceValue(with url: String){
        if let urlString = URL(string: url){
            let newSession = URLSession(configuration: .default)
            let task = newSession.dataTask(with: urlString) { (data, response, error) in
                if error != nil{
                    self.delegate?.errorDidOccur(error: error)
                }
                if let safeData = data{
                    if let fastPrice = parseJSON(dataToDecode: safeData){
                        self.delegate?.didFetchPrice(self, fastPrice: fastPrice)
                    }
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJSON(dataToDecode: Data) -> FastPriceModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(DecodedPriceData.self, from: dataToDecode)
            let fastPriceModelManager = FastPriceModel(rawRate: decodedData.rate)
            return fastPriceModelManager
        }catch{
            self.delegate?.errorDidOccur(error: error)
            return nil
        }
        
    }
}
