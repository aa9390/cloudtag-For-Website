//
//  DetailViewController.swift
//  cloudTest
//
//  Created by soyeonKim on 2018. 8. 9..
//  Copyright © 2018년 ksy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    var labelText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = labelText
    }

}
