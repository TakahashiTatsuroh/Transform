//
//  HomeViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift
import RevealingSplashView
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var files:[File] = []
    
//    探すボタン
    @IBOutlet weak var search: UIButton!
//    追加ボタン
    @IBOutlet weak var addData: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        revealingSplashViewのパンダ
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "PandaMark2")!,iconInitialSize: CGSize(width: 300, height: 300), backgroundColor: UIColor(red: 120, green: 123, blue: 201, alpha: 0.5))
        
        revealingSplashView.animationType = .rotateOut
        
        self.view.addSubview(revealingSplashView)
        
        revealingSplashView.startAnimation(){
            print("Completed")
        }
        
//        探すボタンの設定
        search.titleLabel?.font = UIFont.fontAwesome(ofSize: 25, style: .solid)
        search.titleLabel?.textColor = UIColor.init(red: 121/255, green: 120/255, blue: 201/255, alpha: 100/100)
        search.setTitle(String.fontAwesomeIcon(name: .search), for: .normal)
//        追加ボタンの設定
        addData.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        addData.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        addData.setTitle(String.fontAwesomeIcon(name: .folderPlus), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let db = Firestore.firestore()
            db.collection("file").document()

    }

    @IBAction func addData(_ sender: UIButton) {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
//
//}


//extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return files.count
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//
//        let file = files[indexPath.row]
//
//        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
//
//        let cellImage = UIImage(data: files[indexPath.row].image)
//
//        imageView.image = cellImage
//
//    }
//
}

