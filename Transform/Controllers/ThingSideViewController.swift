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
        
        scrollsToBottomOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
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
                let chatUserT =
                    ChatUser(senderId: uid, displayName: name, photoUrl: photoUrl)
                
                let message =
                    Message(user: chatUserT,
                            text: text,
                            messageId: document.documentID,
                            sentDate: sentDate.dateValue())
                
                messages.append(message)
                
            }
            
            self.messageList = messages
            self.messagesCollectionView.scrollToBottom()
        }
        
    }
    
}

extension ThingSideViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        // user情報を取得
        let user = Auth.auth().currentUser!
        let id = user.uid
        let name = user.displayName
        
        return Sender(id: user.uid, displayName: user.displayName!)
    }
    
    func otherSender() -> Sender {
        
        let userYou = Auth.auth().currentUser!
        let idYou = userYou.uid
        let nameYou = userYou.displayName
        
        return Sender(id: idYou, displayName: nameYou!)
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
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ?
            UIColor(red: 121/255, green: 123/255, blue: 201/255, alpha: 1) :
            UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        //        全メッセージのうちの一つを取得
        let message = messageList[indexPath.section]
        //        取得したメッセージの送信者を取得
        let user = message.user
        
        let url = URL(string: user.photoUrl)
        
        do {
            //            urlを元に画像データを取得
            let data = try Data(contentsOf: url!)
            //            取得したデータを元に、ImageViewを取得
            let image = UIImage(data: data)
            //            imageviewと名前の元にアバターアイコン作成
            let avatar = Avatar(image: image)
            //            アバターアイコンを画面に設置
            avatarView.set(avatar: avatar)
            return
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

extension ThingSideViewController: MessagesLayoutDelegate {
    
}

extension ThingSideViewController: MessageCellDelegate {
}
