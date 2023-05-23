//
//  NotImplementedDG.swift
//  PassportIdNfcReader
//
//  Created by Güneş İLİKSİZ on 23.05.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//


import Foundation

@available(iOS 13, macOS 10.15, *)
public class NotImplementedDG : DataGroup {
    required init( _ data : [UInt8] ) throws {
        try super.init(data)
        datagroupType = .Unknown
    }
}


