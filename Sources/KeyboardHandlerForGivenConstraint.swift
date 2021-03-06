//
//  KeyboardHandlerForGivenConstraint.swift
//  Copyright © 2018 Dolfn. All rights reserved.
//

import UIKit

public class KeyboardHandlerForGivenConstraint: KeyboardHandler, KeyboardShowingOrHidingListener, TapGestureRecognizerManagerDelegate, FirstResponderResigner {
    
    var tapGestureRecognizerManager: TapGestureRecognizerManager?
    public var constraintDefaultConstant: CGFloat = 0
    public var constraintOffset: CGFloat = 0
    public var tokens: [AnyObject]?
    public weak var viewThatCanContainTextInputs: UIView?
    public weak var viewToDismissKeyboardOnTap: UIView? {
        didSet {
            createTapGestureRecognizerManager(for: viewToDismissKeyboardOnTap)
        }
    }
    public weak var delegate: KeyboardHandlerDelegate?
    
    private var multiplier: CGFloat
    private weak var constraint: NSLayoutConstraint?
    private weak var activeTextInputView: UIView?
    
    public init(constraintToAnimate: NSLayoutConstraint, constraintOffset: CGFloat, viewThatCanContainTextInputs: UIView?, viewToDismissKeyboardOnTap: UIView?, multiplier: CGFloat = 1.0) throws {
        
        if multiplier > 1.0 || multiplier <= 0 {
            throw KeyboardHandlerError.MultiplierNotValid
        }
        
        constraintDefaultConstant = constraintToAnimate.constant
        self.multiplier = multiplier
        self.constraint = constraintToAnimate
        self.viewThatCanContainTextInputs = viewThatCanContainTextInputs
        self.viewToDismissKeyboardOnTap = viewToDismissKeyboardOnTap
        self.constraintOffset = constraintOffset
    }
    
    public func handleKeyboard(withHeight keyboardHeight: CGFloat, keyboardStatus: KeyboardStatus) {
        switch keyboardStatus {
        case .willShow:
            delegate?.willShowKeyboard(height: keyboardHeight)
            constraint?.constant = multiplier * keyboardHeight + constraintOffset
            createTapGestureRecognizerManager(for: viewToDismissKeyboardOnTap)
        case .didShow:
            delegate?.didShowKeyboard(height: keyboardHeight)
        case .willHide:
            delegate?.willHideKeyboard(height: keyboardHeight)
            constraint?.constant = constraintDefaultConstant
            tapGestureRecognizerManager = nil
        case .didHide:
            delegate?.didHideKeyboard(height: keyboardHeight)
        }
    }
    
    private func createTapGestureRecognizerManager(for view: UIView?) {
        if let view = view {
            if tapGestureRecognizerManager == nil {
                tapGestureRecognizerManager = TapGestureRecognizerManager(viewToSetGestureRecognizerFor: view)
                tapGestureRecognizerManager?.delegate = self
            }
        } else {
            tapGestureRecognizerManager = nil
        }
    }
    
}
