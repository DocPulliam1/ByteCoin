//
//  ViewController.swift
//  ByteCoin
//
//  Created by Doc Pulliam on 11/09/2019.
//  Copyright © 2019 Doc Pulliam. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate{

  
    

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    var selectedCurrrency = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrrency)
    }
    
    func didUpdateRate(_ currentRate: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = currentRate
            self.currencyLabel.text = self.selectedCurrrency
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    

}

