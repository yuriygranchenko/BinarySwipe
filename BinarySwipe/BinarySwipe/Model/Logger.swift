//
//  BaseViewController.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import UIKit

extension UIApplicationState {
    func displayName() -> String {
        switch self {
        case .Active: return "active"
        case .Inactive: return "inactive"
        case .Background: return "in background"
        }
    }
}

struct Logger {
    
    static let logglyDestination = SlimLogglyDestination()
    
    static func configure() {
        Slim.addLogDestination(logglyDestination)
    }
    
    static var remoteLogging: Bool = NSUserDefaults.standardUserDefaults().remoteLogging ?? false
    
    enum LogColor: String {
        case Default = "fg255,255,255;"
        case Yellow = "fg219,219,110;"
        case Green = "fg107,190,31;"
        case Red = "fg201,91,91;"
        case Blue = "fg0,204,204;"
    }
    
    private static let Escape = "\u{001b}["
    
    static func debugLog(@autoclosure string: () -> String, color: LogColor = .Default, filename: String = #file, line: Int = #line) {
        #if DEBUG
            Slim.debug("\(Escape)\(color.rawValue)\n\(string())\n\n\(Escape);", filename: filename, line: line)
        #endif
    }
    
    static func log<T>(@autoclosure message: () -> T, color: LogColor = .Default, filename: String = #file, line: Int = #line) {
        #if DEBUG
            Slim.debug("\(Escape)\(color.rawValue)\n\(message())\n\n\(Escape);", filename: filename, line: line)
        #else
            if remoteLogging {
                Slim.info(message, filename: filename, line: line)
            }
        #endif
    }
}

private var _remoteLogging: Bool?
var _difference : NSTimeInterval = (NSUserDefaults.sharedUserDefaults?["server_time_difference"] as? NSTimeInterval) ?? 0

extension NSUserDefaults {
    
    var remoteLogging: Bool? {
        get {
            if _remoteLogging == nil {
                _remoteLogging = self["remote_logging"] as? Bool
            }
            return _remoteLogging
        }
        set {
            Logger.remoteLogging = newValue ?? false
            _remoteLogging = newValue
            self["remote_logging"] = newValue
        }
    }
    
    static var sharedUserDefaults: NSUserDefaults? {
        return NSUserDefaults(suiteName: "group.com.ravenpod.wraplive")
    }
    
    subscript(key: String) -> AnyObject? {
        get {
            return objectForKey(key)
        }
        set(newValue) {
            setObject(newValue, forKey: key)
            synchronize()
        }
    }
    
    var serverTimeDifference : NSTimeInterval {
        set {
            if (_difference != newValue) {
                _difference = newValue
            }
            self["server_time_difference"] = newValue
        }
        get {
            return _difference
        }
    }
}
