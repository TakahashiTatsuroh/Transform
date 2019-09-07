//
//  ChatUser.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/09/04.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import MessageKit

class ChatUser: SenderType {
    
    var senderId: String
    
    var displayName: String
    
    let photoUrl: String
    
    
    init(senderId: String, displayName: String, photoUrl: String) {
        self.senderId = senderId
        self.displayName = displayName
        self.photoUrl = photoUrl
    }
}
