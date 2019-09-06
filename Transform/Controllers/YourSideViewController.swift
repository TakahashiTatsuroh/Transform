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

class YourSideViewController: MessagesViewController {
    
    var messageList: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        messageInputBar.delegate = self
    }
    
}

extension YourSideViewController: MessagesDataSource {
    
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

extension YourSideViewController: InputBarAccessoryViewDelegate {
    
    public func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
            // 自分の情報を取得
            let me = self.currentSender() as! ChatUser
            
            // 自分の情報、送信されたテキストからMessageオブジェクト作成
            let newMessage = Message(user: me, text: text, messageId: UUID().uuidString, sentDate: Date())
            
            // 全メッセージを保持する配列に新しいメッセージを追加
            messageList.append(newMessage)
            
            // 新しいメッセージを画面に追加
            messagesCollectionView.insertSections([messageList.count - 1])
            
            // 入力バーの入力値リセット
            inputBar.inputTextView.text = ""
        }
    }
}

extension YourSideViewController: MessagesDisplayDelegate {
}

extension YourSideViewController: MessagesLayoutDelegate {
}
