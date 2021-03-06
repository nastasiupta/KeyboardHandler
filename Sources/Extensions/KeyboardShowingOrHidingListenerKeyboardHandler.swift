//
//  KeyboardShowingOrHidingListenerKeyboardHandler.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import Foundation
import UIKit

public extension KeyboardShowingOrHidingListener where Self: KeyboardHandler {
    
    public func startListeningForKeyboardEvents(in receiver: ObserverReceiver) {
        if tokens == nil {
            tokens = [AnyObject]()
        }
        
        let willShowToken = receiver.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.handleKeyboardNotification(notification, withKeyboardStatus: KeyboardStatus.willShow)
        })
        tokens?.append(willShowToken)
        
        let didShowToken = receiver.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.handleKeyboardNotification(notification, withKeyboardStatus: KeyboardStatus.didShow)
        })
        tokens?.append(didShowToken)
        
        let willHideToken = receiver.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.handleKeyboardNotification(notification, withKeyboardStatus: KeyboardStatus.willHide)
        })
        tokens?.append(willHideToken)

        let didHideToken = receiver.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.handleKeyboardNotification(notification, withKeyboardStatus: KeyboardStatus.didHide)
        })
        tokens?.append(didHideToken)
        
    }
    
    public func stopListeningForKeyboardEvents(in receiver: ObserverReceiver) {
        if let tokens = tokens {
            for token in tokens {
                receiver.removeObserver(token)
            }
        }
        tokens?.removeAll()
    }
    
    
    private func handleKeyboardNotification(_ notification: Notification, withKeyboardStatus keyboardStatus: KeyboardStatus) {
        if let userInfo = notification.userInfo {
            switch keyboardStatus {
            case .willShow, .didShow:
                if let keyboardRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                    handleKeyboard(withHeight: keyboardRect.height, keyboardStatus: keyboardStatus)
                }
            case .willHide, .didHide:
                if let keyboardRect = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect {
                    handleKeyboard(withHeight: keyboardRect.height, keyboardStatus: keyboardStatus)
                }
            }
        }
    }
}
