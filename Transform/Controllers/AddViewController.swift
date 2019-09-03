//
//  AddViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/29.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import FontAwesome_swift
import Firebase
import FirebaseFirestore
import SCLAlertView

class AddViewController: UIViewController {
    
    @IBOutlet weak var addView: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textTitle: UITextField!
    
    @IBOutlet weak var textCategory: UITextField!
    
    @IBOutlet weak var date: UIDatePicker!
    
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
    
    @IBAction func addView(_ sender: UIButton) {
        
        let alertView = SCLAlertView()
        alertView.addButton("Camera") {
            print("Camera button tapped")
        }
        alertView.addButton("Album") {
            print("Album button tapped")
        }
        alertView.showSuccess("source", subTitle: "選んでください")
        
//        alertView = UIColor.init(displayP3Red: 120, green: 123, blue: 201, alpha: 1)

    }
    

    @IBAction func didSaveButton(_ sender: UIButton) {
        if textTitle.text!.isEmpty{
            return
        }
        
        let db = Firestore.firestore()
        
        db.collection("file").addDocument(data: [
            "picture": (imageView.image?.jpegData(compressionQuality: 0.1))!,
            "name": textTitle.text!,
            "category": textCategory.text!,
            "date": date.date,
            "createdAt": FieldValue.serverTimestamp()
        ]) { err in
            
            if let err = err {
                print("saveに失敗しました")
                print(err)
            } else {
                print("saveしました：\(self.textTitle.text!)")
                print("saveしました：\(self.textCategory.text!)")
            }
        }
        
//       ボタンを押した後に前画面に戻る
        navigationController?.popViewController(animated: true)
    }
    
}


