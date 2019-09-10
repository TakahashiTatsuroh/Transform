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

class HubViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var hubImage: UIImageView!
    
    var image: File!
    
    @IBOutlet weak var hubTextTitle: UITextField!
    
    @IBOutlet weak var hubTextCategory: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(data: image.picture)
        hubImage.image = img
        
        hubImage.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toThingSide") {
            
            let hubImage: ThingSideViewController = (segue.destination as? ThingSideViewController)!
            
            hubImage.file = sender as? File
        }
        
        if (segue.identifier == "toYourSide") {
            
            let hubImage: YourSideViewController = (segue.destination as? YourSideViewController)!
            
            hubImage.file = sender as? File
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
        performSegue(withIdentifier: "toThingSide", sender: image)
    }
    
    @IBAction func youButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toYourSide", sender: image)
    }
    

    

    @IBAction func postSNS(_ sender: UIButton) {
        
        let data = [hubImage.image!, hubTextTitle.text!] as [Any]
        
        let controller = UIActivityViewController(activityItems: data, applicationActivities: nil)
        
        present(controller, animated: true, completion: nil)
    }
    
}
