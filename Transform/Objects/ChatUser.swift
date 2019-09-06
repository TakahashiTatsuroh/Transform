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
    
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
}
