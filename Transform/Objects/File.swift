//
//  File.swift
//  Transform
//
//  Created by 高橋達朗 on 2019/08/30.
//  Copyright © 2019 高橋達朗. All rights reserved.
//

import Foundation

//構造体
struct File {
    
    let picture: Data
//    対象のHPの名前 兼　タイトル
    let name: String
//    カテゴリー
    let category: String

    let date: Date
//    対象のID（Firestoreで使用するキーを入れる)
    let documentId: String
}
