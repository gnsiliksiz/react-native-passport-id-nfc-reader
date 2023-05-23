//
//  NFCViewDisplayMessage.swift
//  PassportIdNfcReader
//
//  Created by Güneş İLİKSİZ on 23.05.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

//
//  NFCViewDisplayMessage.swift
//  nfcios
//
//  Created by Güneş İLİKSİZ on 19.05.2023.
//


import Foundation
@available(iOS 13, macOS 10.15, *)
public enum NFCViewDisplayMessage {
    case requestPresentPassport
    case authenticatingWithPassport(Int)
    case readingDataGroupProgress(DataGroupId, Int)
    case error(NFCPassportReaderError)
    case successfulRead
}

@available(iOS 13, macOS 10.15, *)
extension NFCViewDisplayMessage {
    public var description: String {
        switch self {
            case .requestPresentPassport:
                return NFCDisplayMessageStrings.NearNFC.localized
            case .authenticatingWithPassport(let progress):
                let progressString = handleProgress(percentualProgress: progress)
                return NFCDisplayMessageStrings.Authenticating.localized + "...\n\n\(progressString)"
            case .readingDataGroupProgress(let dataGroup, let progress):
                let progressString = handleProgress(percentualProgress: progress)
          return NFCDisplayMessageStrings.Reading.localized + "\(dataGroup).....\n\n\(progressString)"
            case .error(let tagError):
                switch tagError {
                    case NFCPassportReaderError.TagNotValid:
                  return NFCDisplayMessageStrings.TagNoValid.localized
                    case NFCPassportReaderError.MoreThanOneTagFound:
                  return NFCDisplayMessageStrings.OneTagFound.localized
                    case NFCPassportReaderError.ConnectionError:
                  return NFCDisplayMessageStrings.ConnectionError.localized
                    case NFCPassportReaderError.InvalidMRZKey:
                  return NFCDisplayMessageStrings.MRZKeyNotValid.localized
                    case NFCPassportReaderError.ResponseError(let description, let sw1, let sw2):
                  return NFCDisplayMessageStrings.ProblemReading.localized + "\(description) - (0x\(sw1), 0x\(sw2)"
                    default:
                  return NFCDisplayMessageStrings.TryAgainProblemReading.localized
                }
            case .successfulRead:
          return NFCDisplayMessageStrings.ReadSuccessfully.localized
        }
    }
    
    func handleProgress(percentualProgress: Int) -> String {
        let p = (percentualProgress/20)
        let full = String(repeating: "🟢 ", count: p)
        let empty = String(repeating: "⚪️ ", count: 5-p)
        return "\(full)\(empty)"
    }
}

