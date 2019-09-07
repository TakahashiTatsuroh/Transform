//
//  YourSideViewController.swift
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

class YourSideViewController: MessagesViewController {
    
    var messageList: [Message] = [] {
        didSet {
            messagesCollectionView.reloadData()
        }
    }
    
    var file: File!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        
        messageInputBar.delegate = self
        
        // Firestoreへ接続
        let db = Firestore.firestore()
        
        // messagesコレクションを監視する
        
        db.collection("file").document(file.documentId).collection("messages").addSnapshotListener { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            var messages: [Message] = []
            
            for document in documents {
                
                let uid = document.get("uid") as! String
                let name = document.get("name") as! String
                let photoUrl = document.get("photoUrl") as! String
                let text = document.get("text") as! String
                let sentDate = document.get("sentDate") as! Timestamp
                
                // 該当するメッセージの送信者の作成
                let chatUser =
                    ChatUser(senderId: uid, displayName: name, photoUrl: photoUrl)
                
                let message =
                    Message(user: chatUser,
                            text: text,
                            messageId: document.documentID,
                            sentDate: sentDate.dateValue())
                
                messages.append(message)
                
            }
            
            self.messageList = messages
        }
        
    }
    
}

extension YourSideViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        // user情報を取得
        let user = Auth.auth().currentUser!
        let id = user.uid
        let name = user.displayName
        return Sender(senderId: id, displayName: name!)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messageList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messageList.count
    }
    
    
}

extension YourSideViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
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

extension YourSideViewController: MessagesDisplayDelegate {
}

extension YourSideViewController: MessagesLayoutDelegate {
}

extension YourSideViewController: MessageCellDelegate {
}
