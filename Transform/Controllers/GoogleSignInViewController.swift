//
//  GoogleSignInViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/09/05.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import RevealingSplashView

class GoogleSignInViewController: UIViewController, GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("Error: \(error.localizedDescription)")
            return
        }
        
        let authentication = user.authentication
        // Googleのトークンを渡し、Firebaseクレデンシャルを取得する。
        let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,accessToken: (authentication?.accessToken)!)
        
        // Firebaseにログインする。
        Auth.auth().signIn(with: credential) { (authDataResult, error) in
            if let err = error {
                print(err)
            } else {
                print("ログイン成功")
                self.performSegue(withIdentifier: "toHome", sender: nil)
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "PandaMark2")!,iconInitialSize: CGSize(width: 300, height: 300), backgroundColor: UIColor(red: 120, green: 123, blue: 201, alpha: 0.5))
        
        revealingSplashView.animationType = .rotateOut
        
        self.view.addSubview(revealingSplashView)
        
        revealingSplashView.startAnimation(){
            print("Completed")
        }
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }

}
