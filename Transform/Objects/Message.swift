//
//  message.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/30.
//  Copyright © 2019 高橋達朗. All rights reserved.
//


import MessageKit

class Message {
    
    let user: ChatUser
    
    let text: String
    // メッセージのID（Firestoreで使用するキーを入れる）
    let messageId: String
    
    let sentDate:Date
    
    init(user: ChatUser, text: String, messageId: String, sentDate: Date) {
        self.user = user
        self.text = text
        self.messageId = messageId
        self.sentDate = sentDate
    }
}

extension Message: MessageType {
    var kind: MessageKind {
        return.text(text)
    }
    
    
    var sender: SenderType {
        return Sender(id: user.senderId, displayName: user.displayName)
    }
    
}
