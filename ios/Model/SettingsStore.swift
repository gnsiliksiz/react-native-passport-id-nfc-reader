//
//  SettingsStore.swift
//  nfcios
//
//  Created by Güneş İLİKSİZ on 19.05.2023.
//

import Foundation
import SwiftUI
import Combine


final class SettingsStore: ObservableObject {

    private enum Keys {
        static let captureLog = "captureLog"
        static let logLevel = "logLevel"
        static let useNewVerification = "useNewVerification"
    
        static let passportNumber = "passportNumber"
        static let dateOfBirth = "dateOfBirth"
        static let dateOfExpiry = "dateOfExpiry"
        
        static let allVals = [captureLog, logLevel, useNewVerification, passportNumber, dateOfBirth, dateOfExpiry]
    }
    
    private let cancellable: Cancellable
    private let defaults: UserDefaults
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        

        defaults.register(defaults: [
            Keys.captureLog: true,
            Keys.logLevel: 1,
            Keys.useNewVerification: true,
          
            Keys.passportNumber: "",
            Keys.dateOfBirth: Date().timeIntervalSince1970,
            Keys.dateOfExpiry: Date().timeIntervalSince1970,
        ])
        
        cancellable = NotificationCenter.default
            .publisher(for: UserDefaults.didChangeNotification)
            .map { _ in () }
            .subscribe(objectWillChange)
    }
    
    func reset() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
    
    var shouldCaptureLogs: Bool {
        set { defaults.set(newValue, forKey: Keys.captureLog) }
        get { defaults.bool(forKey: Keys.captureLog) }
    }
    
    var logLevel: LogLevel {
        get {
            return LogLevel(rawValue:defaults.integer(forKey: Keys.logLevel)) ?? .info
        }
        set {
            defaults.set(newValue.rawValue, forKey: Keys.logLevel)
        }
    }
    
    var useNewVerificationMethod: Bool {
        set { defaults.set(newValue, forKey: Keys.useNewVerification) }
        get { defaults.bool(forKey: Keys.useNewVerification) }
    }
    

    
    var passportNumber: String {
        set { defaults.set(newValue, forKey: Keys.passportNumber) }
        get { defaults.string(forKey: Keys.passportNumber) ?? "" }
    }
    
    var dateOfBirth: Date {
        set {
            defaults.set(newValue.timeIntervalSince1970, forKey: Keys.dateOfBirth)
        }
        get {
            let d = Date(timeIntervalSince1970: defaults.double(forKey: Keys.dateOfBirth))
            return d
        }
    }
    
    var dateOfExpiry: Date {
        set {
            defaults.set(newValue.timeIntervalSince1970, forKey: Keys.dateOfExpiry) }
        get {
            let d = Date(timeIntervalSince1970: defaults.double(forKey: Keys.dateOfExpiry))
            return d
        }
    }
    
    @Published var passport : NFCPassportModel?
}
