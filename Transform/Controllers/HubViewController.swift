//
//  HubViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/09/02.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit

class HubViewController: UIViewController {

    @IBOutlet weak var hubImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func postSNS(_ sender: UIButton) {
        
        let data = [hubImage.image!]
        
        let controller = UIActivityViewController(activityItems: data, applicationActivities: nil)
        
        present(controller, animated: true, completion: nil)
    }
    
}
