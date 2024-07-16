//
//  ViewController.swift
//  Scheduleia
//
//  Created by Abhishek on 16/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    let titleText = "📋SCHEDULEIA"

    @IBOutlet weak var appName: UILabel!
    
    @IBAction func LoginTapped(_ sender: Any) {
    }
    
    @IBAction func RegisterTapped(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var index = 0.0
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false, block: {(timer) in
                self.appName.text?.append(letter)
            })
            index += 1
        }




        // Do any additional setup after loading the view.
    }


}

