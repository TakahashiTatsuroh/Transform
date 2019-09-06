//
//  ThingSideViewController.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/09/02.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import Firebase
import InputBarAccessoryView

class ThingSideViewController: MessagesViewController {
    
    var messageList: [Message] = []
    
    var file: File!

    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
    }

}

extension ThingSideViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        let id = "1234"
        let name = "Tatsu"
        return ChatUser(senderId: id, displayName: name)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }


}

extension ThingSideViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
//        if messageForItem.text!.isEmpty {
//            return
//        }
        
        // user情報を取得
        let user = Auth.auth().currentUser!
        
        let db = Firestore.firestore()
        
        db.collection("file").document(file.documentId).collection("messages").addDocument(data: [
            "uid": user.uid,
            "name": user.displayName as Any,
            "photoUrl": user.photoURL?.absoluteString as Any,
            "text": text,
            "sentDate": Date()
            ])
        
        // 入力バーの入力値リセット
        inputBar.inputTextView.text = ""
    }

}

extension ThingSideViewController: MessagesDisplayDelegate {
}

extension ThingSideViewController: MessagesLayoutDelegate {
}
