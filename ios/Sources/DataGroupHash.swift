//
//  DataGroupHash.swift
//  PassportIdNfcReader
//
//  Created by Güneş İLİKSİZ on 23.05.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

import Foundation
//
//  DataGroupHash.swift
//  NFCPassportReader
//
//  Created by Andy Qua on 09/02/2021.
//  Copyright © 2021 Andy Qua. All rights reserved.
//

@available(iOS 13, macOS 10.15, *)
public struct DataGroupHash {
    public var id: String
    public var sodHash: String
    public var computedHash : String
    public var match : Bool
}

