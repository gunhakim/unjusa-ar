//
//  ViewController.swift
//  artest
//
//  Created by 김건하 on 08/09/2019.
//  Copyright © 2019 김건하. All rights reserved.
//

import Foundation
import UIKit

class Homeview : UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    내가 추가함
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "tower_1":
            let destination = segue.destination as! ar_view
            destination.labeltext = "tower_1"
        case "tower_4":
            let destination = segue.destination as! ar_view
            destination.labeltext = "tower_4"
        case "tower_6":
            let destination = segue.destination as! ar_view
            destination.labeltext = "tower_6"
        case "dtower_2":
            let destination = segue.destination as! ar_view
            destination.labeltext = "dtower_2"
        case "buddha_1":
            let destination = segue.destination as! ar_view
            destination.labeltext = "buddha_1"
        case "buddha_2":
            let destination = segue.destination as! ar_view
            destination.labeltext = "buddha_2"
        case "buddha_3":
            let destination = segue.destination as! ar_view
            destination.labeltext = "buddha_3"
        case "buddha_4":
            let destination = segue.destination as! ar_view
            destination.labeltext = "buddha_4"
        default:
            print("error")
        }
        
        
    }

    
}

