//
//  CaresCalcViewController.swift
//  CaresActCalculator
//
//  Created by Chris Gottfredson on 4/7/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class CaresCalcViewController: UIViewController, UINavigationBarDelegate {
    
    //MARK: - Views
    
    let filingStatusQuestionLabel: UILabel = {
       let label = UILabel()
        label.text = "What is the filing status on your most recently filed Tax Return?"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let filingStatusLabel: UILabel = {
        let label = UILabel()
        label.text = FilingStatus.headOfhousehold.rawValue
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let singleLabel: UILabel = {
        let label = UILabel()
        label.text = FilingStatus.single.rawValue
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    let filingStatusSlider: UISlider = {
        let slider = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 2
        slider.setValue(1, animated: true)
        slider.maximumTrackTintColor = .systemBlue
        slider.minimumTrackTintColor = .systemBlue
        return slider
    }()
    
    let marriedLabel: UILabel = {
        let label = UILabel()
        label.text = FilingStatus.married.rawValue
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    
    let filingStatusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    let agiQuestionLabel: UILabel = {
       let label = UILabel()
        label.text = "What was your Adjusted Gross Income?"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let agiLabel: UILabel = {
        let label = UILabel()
        label.text = "$100,000.00"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let zeroAGILabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    let agiSlider: UISlider = {
        let slider = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 200000
        slider.setValue(100000, animated: true)
        slider.maximumTrackTintColor = .systemBlue
        slider.minimumTrackTintColor = .systemBlue
        return slider
    }()
    
    let maxAGILabel: UILabel = {
        let label = UILabel()
        label.text = "$200,000.00"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let agiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    let dependentsQuestionLabel: UILabel = {
       let label = UILabel()
        label.text = "How many children dependents under 17?"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    let dependentCountLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let noDependentLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()
    
    let dependentSlider: UISlider = {
        let slider = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 20
        slider.setValue(10, animated: true)
        slider.maximumTrackTintColor = .systemBlue
        slider.minimumTrackTintColor = .systemBlue
        return slider
    }()
    
    let manyDependentLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let dependentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        return stackView
    }()
    
    let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.layer.cornerRadius = button.frame.height / 4
        return button
    }()
    
    let calculatorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - Properties
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var sliders: [UISlider] {
        return [filingStatusSlider, agiSlider, dependentSlider]
    }
    
    var filingStatus: FilingStatus = .headOfhousehold
    var agi: Int = 75000
    var dependentCount: Int = 3
    var freeMoney: Int = 0
    
    enum FilingStatus {
        case single
        case headOfhousehold
        case married
        
        var rawValue: String {
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
    
    var stackViewHeight: CGFloat {
            return (safeArea.layoutFrame.height * 0.06)
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        addAllViews()
        setUpStackViews()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "CARES Calculator"
        view.backgroundColor = UIColor(named: "backgroundColor")
        activateSliders()
        activateButton()
    }
    
    //MARK: - Setup Actions
    
    func activateSliders() {
        sliders.forEach { $0.addTarget(self, action: #selector(valuesChanged(sender:)), for: .valueChanged)}
    }
    
    func activateButton() {
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped(sender:)), for: .touchUpInside)
    }
    
    //MARK: - Actions

    @objc func valuesChanged(sender: UISlider) {
        switch sender {
        case filingStatusSlider:
            filingStatusSliderChanged(sender)
        case agiSlider:
            agiSliderChanged(sender)
        case dependentSlider:
            dependentCountSliderChanged(sender)
        default:
            print("IDK how we got here")
        }
    }
    
    func filingStatusSliderChanged(_ sender: UISlider) {
        
        let value = filingStatusSlider.value
        
        if value > 0.5 && value < 1.5 {
            self.filingStatus = .headOfhousehold
        } else if value > 1.5 {
            self.filingStatus = .married
        } else {
            self.filingStatus = .single
        }
        filingStatusLabel.text = self.filingStatus.rawValue
    }
    
    func agiSliderChanged(_ sender: UISlider) {
        let roundedStepValue = round(sender.value / 100) * 100
        sender.value = roundedStepValue
        agiLabel.text = Formatter.formatToMoney(Int(agiSlider.value))
        agi = Int(agiSlider.value)
    }
    
    func dependentCountSliderChanged(_ sender: UISlider) {
        dependentCountLabel.text = "\(Int(dependentSlider.value))"
        dependentCount = Int(dependentSlider.value)
    }
    
    @objc func calculateButtonTapped(sender: UIButton) {
        calculateCash()
        let vc = ResultViewController()
        vc.result = freeMoney
        present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Setup UI
    
    func addAllViews() {
        view.addSubview(filingStatusQuestionLabel)
        view.addSubview(filingStatusLabel)
        view.addSubview(singleLabel)
        view.addSubview(marriedLabel)
        view.addSubview(filingStatusSlider)
        view.addSubview(filingStatusStackView)
        view.addSubview(agiQuestionLabel)
        view.addSubview(agiLabel)
        view.addSubview(zeroAGILabel)
        view.addSubview(maxAGILabel)
        view.addSubview(agiSlider)
        view.addSubview(agiStackView)
        view.addSubview(dependentsQuestionLabel)
        view.addSubview(dependentCountLabel)
        view.addSubview(noDependentLabel)
        view.addSubview(dependentSlider)
        view.addSubview(manyDependentLabel)
        view.addSubview(dependentStackView)
        view.addSubview(calculateButton)
        view.addSubview(calculatorStackView)
    }
    
    func setUpCalculatorStackView() {
        calculatorStackView.addArrangedSubview(filingStatusQuestionLabel)
        calculatorStackView.addArrangedSubview(filingStatusLabel)
        calculatorStackView.addArrangedSubview(filingStatusStackView)
        calculatorStackView.addArrangedSubview(agiQuestionLabel)
        calculatorStackView.addArrangedSubview(agiLabel)
        calculatorStackView.addArrangedSubview(agiStackView)
        calculatorStackView.addArrangedSubview(dependentsQuestionLabel)
        calculatorStackView.addArrangedSubview(dependentCountLabel)
        calculatorStackView.addArrangedSubview(dependentStackView)
        calculatorStackView.addArrangedSubview(calculateButton)
        
        calculatorStackView.anchor(leading: safeArea.leadingAnchor, top: safeArea.topAnchor, trailing: safeArea.trailingAnchor, bottom: safeArea.bottomAnchor, paddingLeft: 0, paddingTop: 0, paddingRight: 0, paddingBottom: 0, width: safeArea.layoutFrame.width, height: safeArea.layoutFrame.height)
    }
    
    func setUpFilingStatusStackView() {
        filingStatusStackView.addArrangedSubview(singleLabel)
        filingStatusStackView.addArrangedSubview(filingStatusSlider)
        filingStatusStackView.addArrangedSubview(marriedLabel)
        
        filingStatusStackView.anchor(leading: calculatorStackView.leadingAnchor, top: filingStatusLabel.bottomAnchor, trailing: calculatorStackView.trailingAnchor , bottom: agiQuestionLabel.topAnchor, paddingLeft: 0, paddingTop: 2, paddingRight: 0, paddingBottom: 0, height: stackViewHeight)
    }
    
    func setUpAGIStackView() {
        agiStackView.addArrangedSubview(zeroAGILabel)
        agiStackView.addArrangedSubview(agiSlider)
        agiStackView.addArrangedSubview(maxAGILabel)
        
        agiStackView.anchor(leading: calculatorStackView.leadingAnchor, top: agiLabel.bottomAnchor, trailing: calculatorStackView.trailingAnchor, bottom: dependentsQuestionLabel.topAnchor, paddingLeft: 0, paddingTop: 2, paddingRight: 0, paddingBottom: 0, height: stackViewHeight)
    }
    
    func setUpDependentStackView() {
        dependentStackView.addArrangedSubview(noDependentLabel)
        dependentStackView.addArrangedSubview(dependentSlider)
        dependentStackView.addArrangedSubview(manyDependentLabel)
        
        dependentStackView.anchor(leading: calculatorStackView.leadingAnchor, top: dependentCountLabel.bottomAnchor, trailing: calculatorStackView.trailingAnchor, bottom: calculateButton.topAnchor, paddingLeft: 0, paddingTop: 2, paddingRight: 0, paddingBottom: 0, height: stackViewHeight)
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
    
    //MARK: - Helper Functions
    
    func setUpStackViews() {
        setUpCalculatorStackView()
        setUpFilingStatusStackView()
        setUpAGIStackView()
        setUpDependentStackView()
    }
    
    // MARK: - Navigation
    
    
}
