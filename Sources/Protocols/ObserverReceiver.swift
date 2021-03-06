//
//  ObserverReceiver.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

public protocol ObserverReceiver {
    func addObserver(forName name: NSNotification.Name?, object obj: Any?, queue: OperationQueue?, using block: @escaping (Notification) -> Swift.Void) -> NSObjectProtocol
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: ObserverReceiver { }
