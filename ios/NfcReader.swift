//
//  NfcReader.swift
//  PassportIdNfcReader
//
//  Created by Güneş İLİKSİZ on 23.05.2023.
//  Copyright © 2023 Facebook. All rights reserved.
//

import Foundation


@objc(NfcReader)
class NfcReader: NSObject {
  
  private func convertImageToBase64String (img: UIImage?) -> String {
    return img != nil ? ( img!.jpegData(compressionQuality: 1)?.base64EncodedString() ?? "") : ""
  }
  
  private func translatePassportAuthenticationStatus(status: PassportAuthenticationStatus?) -> String {
    if status != nil {
      switch (status!) {
      case .notDone:
        return "Supported - Not done"
      case .success:
        return "Success"
      case .failed:
        return "Failed"
      }
    } else {
      return ""
    }
  }
  
  private let passportReader = PassportReader()
  
  @objc(scanPassport:withResolver:withRejecter:)
  func scanPassport(options: NSDictionary, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    
    guard let passportNumber = options.value(forKey: "passportNumber") as? String else {
      resolve(["error": "Please provide a passportNumber"])
      return
    }
    
    let iso8601Formatter = ISO8601DateFormatter()
    
    guard let isoBirthDate = iso8601Formatter.date(from: options.value(forKey: "birthDate") as! String) else {
      resolve(["error": "Unable to parse birthdate, please provide an iso8601 string."])
      return
    }
    
    guard let isoExpiryDate = iso8601Formatter.date(from: options.value(forKey: "expiryDate") as! String) else {
      resolve(["error": "Unable to parse expiryDate, please provide an iso8601 string."])
      return
    }
    let settings = SettingsStore()
    let dateFormatter = DateFormatter()
    
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.dateFormat = "YYMMdd"
    
    let dateOfBirth = dateFormatter.string(from: isoBirthDate)
    let dateOfExpiry = dateFormatter.string(from: isoExpiryDate)
    
    let passportUtils = PassportUtils()
    let mrzKey = passportUtils.getMRZKey(passportNumber: passportNumber, dateOfBirth: dateOfBirth, dateOfExpiry: dateOfExpiry)
    // Set the masterListURL on the Passport Reader to allow auto passport verification
    let masterListURL = Bundle.main.url(forResource: "masterList", withExtension: ".pem")!
    passportReader.setMasterListURL( masterListURL )
    
    // Set whether to use the new Passive Authentication verification method (default true) or the old OpenSSL CMS verifiction
    passportReader.passiveAuthenticationUsesOpenSSL = options.value(forKey: "useNewVerificationMethod") as! Bool
    
    // If we want to read only specific data groups we can using:
    
    Log.logLevel = .debug
    Log.storeLogs = true
    Log.clearStoredLogs()
    
    Log.error( "Using version \(String(describing: UIApplication.version))" )

    Task {
    do {
      let result = try await passportReader.readPassport(mrzKey: mrzKey)
      
      var countrySigningCertificate: [String: Any] = [:]
      if let certificate = result.countrySigningCertificate {
        countrySigningCertificate = [
          "issuerName": certificate.getIssuerName(),
          "publicKeyAlgorithm": certificate.getPublicKeyAlgorithm(),
          "signatureAlgorithm": certificate.getSignatureAlgorithm(),
          "subjectName": certificate.getSubjectName(),
          "fingerprint": certificate.getFingerprint(),
          "validUntil": certificate.getNotAfterDate(),
          "validFrom": certificate.getNotBeforeDate(),
          "serialNumber": certificate.getSerialNumber()
        ]
      }
      
      var documentSigningCertificate: [String: Any] = [:]
      if let certificate = result.documentSigningCertificate {
        documentSigningCertificate = [
          "issuerName": certificate.getIssuerName(),
          "publicKeyAlgorithm": certificate.getPublicKeyAlgorithm(),
          "signatureAlgorithm": certificate.getSignatureAlgorithm(),
          "subjectName": certificate.getSubjectName(),
          "fingerprint": certificate.getFingerprint(),
          "validUntil": certificate.getNotAfterDate(),
          "validFrom": certificate.getNotBeforeDate(),
          "serialNumber": certificate.getSerialNumber()
        ]
      }
      
      let dict: [String: Any] = [
        "passportCorrectlySigned": result.passportCorrectlySigned,
        "activeAuthenticationPassed": result.activeAuthenticationPassed,
        "documentSigningCertificateVerified": result.documentSigningCertificateVerified,
        "passportDataNotTampered": result.passportDataNotTampered,
        "documentType": result.documentType,
        "LDSVersion": result.LDSVersion,
        "firstName": result.firstName,
        "lastName": result.lastName,
        "dateOfBirth": result.dateOfBirth,
        "documentExpiryDate": result.documentExpiryDate,
        "nationality": result.nationality,
        "issuingAuthority": result.issuingAuthority,
        "documentNumber": result.documentNumber,
        "personalNumber": result.personalNumber ?? "",
        "passportMRZ": result.passportMRZ,
        "placeOfBirth": result.placeOfBirth ?? "",
        "gender": result.gender,
        "passportImage": self.convertImageToBase64String(img: result.passportImage),
        "signatureImage": self.convertImageToBase64String(img: result.signatureImage),
        "chipAuthenticationStatus": self.translatePassportAuthenticationStatus(status: result.chipAuthenticationStatus),
        "paceStatus": self.translatePassportAuthenticationStatus(status: result.PACEStatus),
        "countrySigningCertificate": countrySigningCertificate,
        "documentSigningCertificate": documentSigningCertificate
      ]
      resolve(dict)
      // dict değerini uygun şekilde kullanın veya döndürün
    } catch {
      // Hata durumunda ilgili işlemleri gerçekleştirin veya hata mesajını döndürün
      print("Error: \(error.localizedDescription)")
    }}

    }
  }




