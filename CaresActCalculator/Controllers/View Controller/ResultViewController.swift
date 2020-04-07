//
//  ResultViewController.swift
//  CaresActCalculator
//
//  Created by Chris Gottfredson on 4/7/20.
//  Copyright © 2020 Gottfredson. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    //MARK: - Outlets and Properties
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var salutationLabel: UILabel!
    
    var result: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    
    //MARK: - Helper Methods
    
    func updateViews() {
        guard let result = result else { return }
        resultLabel.text = Formatter.formatToMoney(result)
        salutationLabel.text = result > 0 ? "Congratulations!" : "Unfortunately..."
    }

}
