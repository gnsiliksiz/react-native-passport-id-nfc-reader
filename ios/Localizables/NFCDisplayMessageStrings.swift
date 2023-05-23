//
//  NFCDisplayMessageStrings.swift
//  PassportIdNfcReader
//
//  Created by Güneş İLİKSİZ on 23.05.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//


import Foundation
enum NFCDisplayMessageStrings: String{
  case NearNFC
  case Authenticating
  case Reading
  case TagNoValid
  case OneTagFound
  case ConnectionError
  case MRZKeyNotValid
  case ProblemReading
  case TryAgainProblemReading
  case ReadSuccessfully
  case InvalidResponse
  case UnexpectedError
  case NFCNotSupported
  case NoConnectedTag
  case D087Malformed
  case InvalidResponseChecksum
  case MissingMandatoryFields
  case CannotDecodeASN1Length
  case InvalidASN1Value
  case UnableToProtectAPDU
  case UnableToUnprotectAPDU
  case UnsupportedDataGroup
  case DataGroupNotRead
  case UnknownTag
  case UnknownImageFormat
  case NotImplemented
  case TagNotValid
  case ConnectionEr
  case UserCanceled
  case InvalidMRZKey
  case MoreThanOneTagFound
  case InvalidHashAlgorithmSpecified
  case UnsupportedCipherAlgorithm
  case UnsupportedMappingType
  case PACEError
  case ChipAuthenticationFailed
  case InvalidDataPassed
  case NotYetSupported
  case SecurityStatusNotSatisfied
  case SessionInvalidated
  case ClassNotSupported
  case TagConnectionLost
  var localized: String {
    NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
  }
}

