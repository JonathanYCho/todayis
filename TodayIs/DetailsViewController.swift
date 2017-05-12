//
//  DetailsViewController.swift
//  TodayIs
//
//  Created by Jonathan Cho on 5/12/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.borderWidth = 7.5 
        self.view.layer.borderColor = UIColor.yellow.cgColor
        
        print (self.view)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
