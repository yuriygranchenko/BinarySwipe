//
//  GenericCollections+Ext.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return (index >= 0 && index < count) ? self[index] : nil
    }
}

extension Array where Element: Equatable {
    
    mutating func remove(element: Element) {
        if let index = indexOf(element) {
            removeAtIndex(index)
        }
    }
}

extension CollectionType {
    
    func all(@noescape enumerator: Generator.Element -> Void) {
        for element in self {
            enumerator(element)
        }
    }
    
    subscript (@noescape includeElement: Generator.Element -> Bool) -> Generator.Element? {
        for element in self where includeElement(element) == true {
            return element
        }
        return nil
    }
}

extension Dictionary {
    
    func get<T>(key: Key) -> T? {
        return self[key] as? T
    }
}
