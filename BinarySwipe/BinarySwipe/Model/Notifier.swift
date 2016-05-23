//
//  Notifier.swift
//  BinarySwipe
//
//  Created by Macostik on 5/23/16.
//  Copyright © 2016 EasternPeak. All rights reserved.
//

import Foundation

func ==(lhs: NotifyReceiverWrapper, rhs: NotifyReceiverWrapper) -> Bool {
    return lhs.receiver === rhs.receiver
}

struct NotifyReceiverWrapper: Equatable {
    weak var receiver: AnyObject?
}

class Notifier: NSObject {
    
    internal var receivers = [NotifyReceiverWrapper]()
    
    func addReceiver(receiver: AnyObject?) {
        guard let receiver = receiver else { return }
        receivers.append(NotifyReceiverWrapper(receiver: receiver))
    }
    
    func insertReceiver(receiver: AnyObject?) {
        guard let receiver = receiver else { return }
        receivers.insert(NotifyReceiverWrapper(receiver: receiver), atIndex: 0)
    }
    
    func removeReceiver(receiver: AnyObject?) {
        guard let receiver = receiver else { return }
        if let index = receivers.indexOf({ $0.receiver === receiver }) {
            receivers.removeAtIndex(index)
        }
    }
    
    func notify(@noescape enumerator: (receiver: AnyObject) -> Void) {
        var emptyWrappers = [NotifyReceiverWrapper]()
        for wrapper in receivers {
            if let receiver = wrapper.receiver {
                enumerator(receiver: receiver)
            } else {
                emptyWrappers.append(wrapper)
            }
        }
        for wrapper in emptyWrappers {
            receivers.remove(wrapper)
        }
    }
}