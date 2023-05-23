//
//  Errors.swift
//  PassportIdNfcReader
//
//  Created by Güneş İLİKSİZ on 23.05.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//


import Foundation
@available(iOS 13, macOS 10.15, *)
public enum NFCPassportReaderError: Error {
    case ResponseError(String, UInt8, UInt8)
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
    case ConnectionError
    case UserCanceled
    case InvalidMRZKey
    case MoreThanOneTagFound
    case InvalidHashAlgorithmSpecified
    case UnsupportedCipherAlgorithm
    case UnsupportedMappingType
    case PACEError(String,String)
    case ChipAuthenticationFailed
    case InvalidDataPassed(String)
    case NotYetSupported(String)

    var value: String {
        switch self {
            case .ResponseError(let errMsg, _, _): return errMsg
        case .InvalidResponse: return NFCDisplayMessageStrings.InvalidResponse.localized
        case .UnexpectedError: return NFCDisplayMessageStrings.UnexpectedError.localized
        case .NFCNotSupported: return NFCDisplayMessageStrings.NFCNotSupported.localized
        case .NoConnectedTag: return NFCDisplayMessageStrings.NoConnectedTag.localized
        case .D087Malformed: return NFCDisplayMessageStrings.D087Malformed.localized
        case .InvalidResponseChecksum: return NFCDisplayMessageStrings.InvalidResponseChecksum.localized
        case .MissingMandatoryFields: return NFCDisplayMessageStrings.MissingMandatoryFields.localized
        case .CannotDecodeASN1Length: return NFCDisplayMessageStrings.CannotDecodeASN1Length.localized
        case .InvalidASN1Value: return NFCDisplayMessageStrings.InvalidASN1Value.localized
        case .UnableToProtectAPDU: return NFCDisplayMessageStrings.UnableToProtectAPDU.localized
        case .UnableToUnprotectAPDU: return NFCDisplayMessageStrings.UnableToUnprotectAPDU.localized
        case .UnsupportedDataGroup: return NFCDisplayMessageStrings.UnsupportedDataGroup.localized
        case .DataGroupNotRead: return NFCDisplayMessageStrings.DataGroupNotRead.localized
        case .UnknownTag: return NFCDisplayMessageStrings.UnknownTag.localized
        case .UnknownImageFormat: return NFCDisplayMessageStrings.UnknownImageFormat.localized
        case .NotImplemented: return NFCDisplayMessageStrings.NotImplemented.localized
        case .TagNotValid: return NFCDisplayMessageStrings.TagNotValid.localized
        case .ConnectionError: return NFCDisplayMessageStrings.ConnectionEr.localized
        case .UserCanceled: return NFCDisplayMessageStrings.UserCanceled.localized
        case .InvalidMRZKey: return NFCDisplayMessageStrings.InvalidMRZKey.localized
        case .MoreThanOneTagFound: return NFCDisplayMessageStrings.MoreThanOneTagFound.localized
        case .InvalidHashAlgorithmSpecified: return NFCDisplayMessageStrings.InvalidHashAlgorithmSpecified.localized
        case .UnsupportedCipherAlgorithm: return NFCDisplayMessageStrings.UnsupportedCipherAlgorithm.localized
        case .UnsupportedMappingType: return NFCDisplayMessageStrings.UnsupportedMappingType.localized
        case .PACEError(let step, let reason): return NFCDisplayMessageStrings.PACEError.localized + "(\(step)) - \(reason)"
        case .ChipAuthenticationFailed: return NFCDisplayMessageStrings.ChipAuthenticationFailed.localized
        case .InvalidDataPassed(let reason) : return NFCDisplayMessageStrings.InvalidDataPassed.localized + " - \(reason)"
        case .NotYetSupported(let reason) : return NFCDisplayMessageStrings.NotYetSupported.localized + " - \(reason)"
        }
    }
}

@available(iOS 13, macOS 10.15, *)
extension NFCPassportReaderError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(value, comment: "My error")
    }
}


// MARK: OpenSSLError
@available(iOS 13, macOS 10.15, *)
public enum OpenSSLError: Error {
    case UnableToGetX509CertificateFromPKCS7(String)
    case UnableToVerifyX509CertificateForSOD(String)
    case VerifyAndReturnSODEncapsulatedData(String)
    case UnableToReadECPublicKey(String)
    case UnableToExtractSignedDataFromPKCS7(String)
    case VerifySignedAttributes(String)
    case UnableToParseASN1(String)
    case UnableToDecryptRSASignature(String)
}

@available(iOS 13, macOS 10.15, *)
extension OpenSSLError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .UnableToGetX509CertificateFromPKCS7(let reason):
                return NSLocalizedString("Unable to read the SOD PKCS7 Certificate. \(reason)", comment: "UnableToGetPKCS7CertificateForSOD")
            case .UnableToVerifyX509CertificateForSOD(let reason):
                return NSLocalizedString("Unable to verify the SOD X509 certificate. \(reason)", comment: "UnableToVerifyX509CertificateForSOD")
            case .VerifyAndReturnSODEncapsulatedData(let reason):
                return NSLocalizedString("Unable to verify the SOD Datagroup hashes. \(reason)", comment: "UnableToGetSignedDataFromPKCS7")
            case .UnableToReadECPublicKey(let reason):
                return NSLocalizedString("Unable to read ECDSA Public key  \(reason)!", comment: "UnableToReadECPublicKey")
            case .UnableToExtractSignedDataFromPKCS7(let reason):
                return NSLocalizedString("Unable to extract Signer data from PKCS7  \(reason)!", comment: "UnableToExtractSignedDataFromPKCS7")
            case .VerifySignedAttributes(let reason):
                return NSLocalizedString("Unable to Verify the SOD SignedAttributes  \(reason)!", comment: "UnableToExtractSignedDataFromPKCS7")
            case .UnableToParseASN1(let reason):
                return NSLocalizedString("Unable to parse ASN1  \(reason)!", comment: "UnableToParseASN1")
            case .UnableToDecryptRSASignature(let reason):
                return NSLocalizedString("DatUnable to decrypt RSA Signature \(reason)!", comment: "UnableToDecryptRSSignature")
        }
    }
}


// MARK: PassiveAuthenticationError
public enum PassiveAuthenticationError: Error {
    case UnableToParseSODHashes(String)
    case InvalidDataGroupHash(String)
    case SODMissing(String)
}


extension PassiveAuthenticationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .UnableToParseSODHashes(let reason):
                return NSLocalizedString("Unable to parse the SOD Datagroup hashes. \(reason)", comment: "UnableToParseSODHashes")
            case .InvalidDataGroupHash(let reason):
                return NSLocalizedString("DataGroup hash not present or didn't match  \(reason)!", comment: "InvalidDataGroupHash")
            case .SODMissing(let reason):
                return NSLocalizedString("DataGroup SOD not present or not read  \(reason)!", comment: "SODMissing")
                
        }
    }
}

