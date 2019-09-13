//
//  HubViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/09/02.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import SCLAlertView
import Firebase
import FontAwesome_swift

class HubViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var hubImage: UIImageView!
    
    var file: File!
    
    @IBOutlet weak var hubTextTitle: UITextField!
    
    @IBOutlet weak var hubTextCategory: UITextField!
    
    @IBOutlet weak var changeImage: UIButton!
    
    @IBOutlet weak var hubDate: UIDatePicker!
    
    @IBOutlet weak var thingButton: UIButton!
    
    @IBOutlet weak var youButton: UIButton!
    
    @IBOutlet weak var upData: UIButton!
    
    @IBOutlet weak var hunTextView: UITextView!
    
    @IBOutlet weak var postSNS: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(data: file.picture)
        hubImage.image = img
        
        hubImage.contentMode = UIView.ContentMode.scaleAspectFit
        
        hubTextTitle.text = file.name
        
        hubTextCategory.text = file.category
        
        hubDate.date = file.date
        
        
        self.changeImage.layer.cornerRadius = 12
        self.changeImage.backgroundColor = .init(red: 120, green: 123, blue: 201, alpha: 1)
        self.changeImage.layer.shadowOpacity = 0.5
        self.changeImage.layer.shadowRadius = 1
        self.changeImage.layer.shadowColor = UIColor.gray.cgColor
        self.changeImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.postSNS.layer.cornerRadius = 12
        self.postSNS.backgroundColor = .init(red: 120, green: 123, blue: 201, alpha: 1)
        self.postSNS.layer.shadowOpacity = 0.5
        self.postSNS.layer.shadowRadius = 1
        self.postSNS.layer.shadowColor = UIColor.gray.cgColor
        self.postSNS.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        self.upData.layer.cornerRadius = 12
        self.upData.backgroundColor = .init(red: 120, green: 123, blue: 201, alpha: 1)
        self.upData.layer.shadowOpacity = 0.5
        self.upData.layer.shadowRadius = 1
        self.upData.layer.shadowColor = UIColor.gray.cgColor
        self.upData.layer.shadowOffset = CGSize(width: 1, height: 1)
        
        thingButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 60, style: .solid)
        thingButton.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        thingButton.setTitle(String.fontAwesomeIcon(name: .comments), for: .normal)
        
        youButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 60, style: .regular)
        youButton.titleLabel?.textColor = UIColor.init(red: 121/225, green: 120/225, blue: 201/255, alpha: 100/100)
        youButton.setTitle(String.fontAwesomeIcon(name: .comments), for: .normal)
        
        hunTextView.layer.shadowRadius = 5.0
        hunTextView.layer.borderColor = UIColor.black.cgColor
        hunTextView.layer.borderWidth = 1
        hunTextView.layer.shadowColor = UIColor.black.cgColor
        hunTextView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        hunTextView.layer.shadowOpacity = 1.0
        hunTextView.textColor = UIColor.black
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toThingSide") {
            
            let hubfile: ThingSideViewController = (segue.destination as? ThingSideViewController)!
            
            hubfile.file = sender as? File
        }
        
        if (segue.identifier == "toYourSide") {
            
            let hubfile: YourSideViewController = (segue.destination as? YourSideViewController)!
            
            hubfile.file = sender as? File
        }

    }
    
    @IBAction func changeImage(_ sender: UIButton) {
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
        
        
        alertView.showEdit("source", subTitle: "選んでください")
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            hubImage.image = pickedImage
            hubImage.contentMode = .scaleAspectFit
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func thingButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toThingSide", sender: file)
    }
    
    @IBAction func youButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toYourSide", sender: file)
    }
    
    fileprivate func extractedFunc() {
        let alert = UIAlertController(title: "UpData", message: "", preferredStyle: .alert)
        print("updataしました：\(self.hubTextTitle.text!)")
        
        let yesAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            print("はいが押されました")
        }
        alert.addAction(yesAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func upData(_ sender: UIButton) {
        if hubTextTitle.text!.isEmpty{
            return
        }
        
        let alert = UIAlertController(title: "UpData?", message: "", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            print("はいが押されました")
        
        
            let db = Firestore.firestore()
        
            db.collection("file").document(self.file.documentId).setData([
                "picture": (self.hubImage.image?.jpegData(compressionQuality: 0.1))!,
                "name": self.hubTextTitle.text!,
                "category": self.hubTextCategory.text!,
                "date": self.hubDate.date,
                "createdAt": FieldValue.serverTimestamp()
            
            ]) { err in
            
                if let err = err {
                    print("updataに失敗しました")
                    print(err)
                } else {
                    self.extractedFunc()
                }
            }
        
        }
        
        let noAction = UIAlertAction(title: "No", style: .destructive) { (UIAlertAction) in
            print("いいえが押されました")
        }
        
        alert.addAction(yesAction)
        
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    

    @IBAction func postSNS(_ sender: UIButton) {
        
        let data = [hubImage.image!, hubTextTitle.text!, hunTextView.text!] as [Any]
        
        let controller = UIActivityViewController(activityItems: data, applicationActivities: nil)
        
        present(controller, animated: true, completion: nil)
    }
    
}
