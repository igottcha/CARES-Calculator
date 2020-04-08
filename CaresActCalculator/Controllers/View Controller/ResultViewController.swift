//
//  ResultViewController.swift
//  CaresActCalculator
//
//  Created by Chris Gottfredson on 4/7/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    //MARK: - Views
    
    let salutationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }()
    
    let middleLabel: UILabel = {
        let label = UILabel()
        label.text = "You are eligible for"
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 48)
        return label
    }()
    
    let resultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: - Properties
    
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var result: Int?
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        addAllViews()
        setUpStackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "otherBackgroundColor")
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    
    //MARK: - Setup UI
    
    func addAllViews() {
        view.addSubview(salutationLabel)
        view.addSubview(middleLabel)
        view.addSubview(resultLabel)
        view.addSubview(resultsStackView)
    }
    
    func setUpStackView() {
        resultsStackView.addArrangedSubview(salutationLabel)
        resultsStackView.addArrangedSubview(middleLabel)
        resultsStackView.addArrangedSubview(resultLabel)
        
        resultsStackView.anchor(leading: safeArea.leadingAnchor, top: safeArea.topAnchor, trailing: safeArea.trailingAnchor, bottom: safeArea.bottomAnchor, paddingLeft: 0, paddingTop: 0, paddingRight: 0, paddingBottom: 0)
    }
    
    //MARK: - Helper Methods
    
    func updateViews() {
        guard let result = result else { return }
        resultLabel.text = Formatter.formatToMoney(result)
        salutationLabel.text = result > 0 ? "Congratulations!" : "Unfortunately..."
    }
    
}
