//
//  ViewController.swift
//  FastPrice
//
//  Created by Sarthak Khillan on 15/12/20.
//

import UIKit
import CoreLocation
import ExposureNotification
class ViewController: UIViewController {
    var fastPriceNetworkingManager = FastPriceNetworking()
    
   
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var currencyValueLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fastPriceNetworkingManager.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }


}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fastPriceNetworkingManager.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fastPriceNetworkingManager.currencyList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyValueLabel.text = fastPriceNetworkingManager.currencyList[row]
        fastPriceNetworkingManager.fetchPrice(ofUIPickerInputValue: row)
    }
    
}

extension ViewController: FastPriceProtocolDelegate{
    func didFetchPrice(_ manager: FastPriceNetworking, fastPrice: FastPriceModel) {
        DispatchQueue.main.async {
            self.priceValueLabel.text = fastPrice.rate
        }
    }
    
    func errorDidOccur(error: Error?) {
        if let errorOccurred = error{
            print(errorOccurred)
        }
    }
    
    
}
