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

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
//        カメラ
            alertView.addButton("Camera") {
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let cameraPicker = UIImagePickerController()
                    cameraPicker.sourceType = .camera
                    cameraPicker.delegate = self
                    self.present(cameraPicker, animated: true, completion: nil)
                } else {
                    print("カメラが使用できません")
                }
            }
//        アルバム
            alertView.addButton("Album") {
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker, animated: true, completion: nil)
                } else {
                    print("フォトライブラリが使用できません")
                }
            }
        
            alertView.showEdit("Image", subTitle: "選択して下さい", closeButtonTitle: "Cancel")

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
            imageView.contentMode = .scaleAspectFit
        }
        
        picker.dismiss(animated: true, completion: nil)
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
            "createdAt": FieldValue.serverTimestamp(),
            "createdUser": Auth.auth().currentUser?.uid
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
