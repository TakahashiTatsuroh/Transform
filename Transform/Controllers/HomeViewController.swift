//
//  HomeViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
//    探すボタン
    @IBOutlet weak var search: UIButton!
//    追加ボタン
    @IBOutlet weak var addData: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        探すボタンの設定
        search.titleLabel?.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        search.titleLabel?.textColor = UIColor.init(red: 121/255, green: 120/255, blue: 201/255, alpha: 100/100)
        search.setTitle(String.fontAwesomeIcon(name: .search), for: .normal)
//        追加ボタンの設定
        addData.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        addData.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        addData.setTitle(String.fontAwesomeIcon(name: .folderPlus), for: .normal)
        
    }
    
    @IBAction func addData(_ sender: UIButton) {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    

}
