//
//  HomeViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/28.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Firebase
import FirebaseFirestore
import GoogleSignIn

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var files:[File] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var mainImage: UIImage?
    
    
//    探すボタン

    
//    パーソナリティボタン
    @IBOutlet weak var personal: UIButton!
    
//    追加ボタン
    @IBOutlet weak var addData: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let db = Firestore.firestore()
        db.collection("file").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            var files:[File] = []
            for document in documents {
                
                let picture = document.get("picture") as! Data
                
                let name = document.get("name") as! String
                
                let category = document.get("category") as! String
                
                let date = (document.get("date") as! Timestamp).dateValue()
                
                let documentId = document.documentID
                
                let file = File(picture: picture, name: name, category: category, date: date, documentId: documentId)
                
                files.append(file)
            }
            
            self.files = files
        }
        
//        追加ボタンの設定
        addData.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        addData.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        addData.setTitle(String.fontAwesomeIcon(name: .folderPlus), for: .normal)
//        パーソナリティーボタンの設定
        personal.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: .solid)
        personal.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        personal.setTitle(String.fontAwesomeIcon(name: .userCircle), for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        let db = Firestore.firestore()
            db.collection("file").document()

    }
    
    @IBAction func personal(_ sender: UIButton) {
//        ログアウトボタン
        let alert = UIAlertController(title: "logout?", message: "", preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            print("はいが押されました")
            
            GIDSignIn.sharedInstance()?.signOut()
            
        let GoogleSignInViewController = self.storyboard?.instantiateViewController(withIdentifier: "GoogleSignInViewController") as! GoogleSignInViewController
            self.present(GoogleSignInViewController, animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: "No", style: .destructive) { (UIAlertAction) in
            print("いいえが押されました")
        }
        alert.addAction(yesAction)
        
        alert.addAction(noAction)
    }
    

    @IBAction func addData(_ sender: UIButton) {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }

}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return files.count

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        let file = files[indexPath.row]

        let imageView = cell.contentView.viewWithTag(1) as! UIImageView

        let cellImage = UIImage(data: files[indexPath.row].picture)

        imageView.image = cellImage
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let file = files[indexPath.row]
        performSegue(withIdentifier: "toHub", sender: file)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toHub") {
            
            let hubfile: HubViewController = (segue.destination as? HubViewController)!
            
            hubfile.file = sender as? File
        }
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let horizontalSpace:CGFloat = 2
        
        let cellSize:CGFloat = self.view.bounds.width/3 - horizontalSpace
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
        
    }
    
}
