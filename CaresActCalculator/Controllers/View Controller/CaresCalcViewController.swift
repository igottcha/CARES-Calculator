//
//  CaresCalcViewController.swift
//  CaresActCalculator
//
//  Created by Chris Gottfredson on 4/7/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class CaresCalcViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var filingStatusLabel: UILabel!
    @IBOutlet weak var filingStatusSlider: UISlider!
    @IBOutlet weak var agiLabel: UILabel!
    @IBOutlet weak var agiSlider: UISlider!
    @IBOutlet weak var dependentSlider: UISlider!
    @IBOutlet weak var dependentCountLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    
    //MARK: - Properties
    
    var filingStatus: filingStatus = .headOfhousehold
    var agi: Int = 75000
    var dependentCount: Int = 3
    var freeMoney: Int = 0
    
    enum filingStatus {
        case single
        case headOfhousehold
        case married
        
        var statusDescription: String {
            switch self {
            case .single:
                return "Single"
            case .headOfhousehold:
                return "Head of Household"
            case .married:
                return "Married"
            }
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateButton.layer.cornerRadius = calculateButton.frame.height / 4
    }
    
    //MARK: - Actions
    
    
    @IBAction func filingStatusSliderChanged(_ sender: UISlider) {
        
        let value = filingStatusSlider.value
        
        if value > 0.5 && value < 1.5 {
            self.filingStatus = .headOfhousehold
        } else if value > 1.5 {
            self.filingStatus = .married
        } else {
            self.filingStatus = .single
        }
        filingStatusLabel.text = self.filingStatus.statusDescription
    }
    
    @IBAction func agiSliderChanged(_ sender: UISlider) {
        agiLabel.text = Formatter.formatToMoney(Int(agiSlider.value))
        agi = Int(agiSlider.value)
    }
    
    @IBAction func dependentCountSliderChanged(_ sender: UISlider) {
        dependentCountLabel.text = "\(Int(dependentSlider.value))"
        dependentCount = Int(dependentSlider.value)
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        calculateCash()
    }
    
    //MARK: - Methods
    
    func calculateCash() {
        
        let childCash = dependentCount * 500
        var baseCash: Int = 0
        var availableMuns: Int {
            get {
                return childCash + baseCash
            }
        }
        
        let calculatedFreeMoney: Int = {
            switch self.filingStatus {
            case .married:
                baseCash = 2400
                return agi < 150000 ? availableMuns : (availableMuns - (5 * ((agi - 150000) / 100)))
            case .headOfhousehold:
                baseCash = 1200
                return agi < 112000 ? availableMuns : (availableMuns - (5 * ((agi - 112000) / 100)))
            case .single:
                baseCash = 1200
                return agi < 75000 ? availableMuns : (availableMuns - (5 * ((agi - 75000) / 100)))
            }
        }()
        
        self.freeMoney = calculatedFreeMoney > 0 ? calculatedFreeMoney : 0
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            guard let destinationVC = segue.destination as? ResultViewController else { return }
            destinationVC.result = freeMoney
        }
    }
}
