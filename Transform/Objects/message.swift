//
//  message.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/30.
//  Copyright © 2019 高橋達朗. All rights reserved.
//


import Foundation

struct Message {
    
    // メッセージのID（Firestoreで使用するキーを入れる）
    let documentId: String
    
    // 送信されたメッセージ
    let text: String
}
