//
//  ScoreViewController.swift
//  ArithmeticImprovementGame
//
//  Created by Watson, William on 01/04/2022.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var lblScoreCorrect: UILabel!
    
    var correct = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        lblScoreCorrect.text = String(correct)
        // Do any additional setup 3after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
