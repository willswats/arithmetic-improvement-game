//
//  SelectViewController.swift
//  ArithmeticImprovementGame
//
//  Created by Watson, William on 01/04/2022.
//

import UIKit

class SelectViewController: UIViewController {

        let easy = "easy"
        let normal = "normal"
        let hard = "hard"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "SegueEasy":
            if let destination = segue.destination as? GameViewController {
                destination.difficulty = easy
            }
        case "SegueNormal":
            if let destination = segue.destination as? GameViewController {
                destination.difficulty = normal
            }
        case "SegueHard":
            if let destination = segue.destination as? GameViewController {
                destination.difficulty = hard
            }
        default:
            return
        }
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
