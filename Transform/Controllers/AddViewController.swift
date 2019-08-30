//
//  AddViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/29.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift

class AddViewController: UIViewController {
    
    @IBOutlet weak var addView: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textTitle: UITextField!
    
    @IBOutlet weak var textCategory: UITextField!
    
    @IBOutlet weak var didSaveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addViewボタンの設定
        addView.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .regular)
        addView.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        addView.setTitle(String.fontAwesomeIcon(name: .plusSquare), for: .normal)
//        Saveボタンの設定
        didSaveButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        didSaveButton.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        didSaveButton.setTitle(String.fontAwesomeIcon(name: .download), for: .normal)
    }

    @IBAction func didSaveButton(_ sender: UIButton) {
    }
    
}

