//
//  TapGestureRecognizerManagerTests.swift
//  KeyboardHandler-iOS Tests
//
//  Created by Andrei Nastasiu on 06/02/2018.
//  Copyright © 2018 Dolfn. All rights reserved.
//

import XCTest
@testable import KeyboardHandler

class TapGestureRecognizerManagerTests: XCTestCase {
    
    func test_GivenViewAtInitialization_IsSavedAsProperty() {
        let view = UIView()
        let sut = TapGestureRecognizerManager(viewToSetGestureRecognizerFor: view)
        XCTAssertEqual(sut.viewToSetGestureRecognizerFor, view)
    }
    
    func test_GivenViewAtInitialization_IsReatinedAsWeakReference() {
        var view: UIView? = UIView()
        let sut = TapGestureRecognizerManager(viewToSetGestureRecognizerFor: view!)
        view = nil
        wait(for: 0.1)
        XCTAssertNil(sut.viewToSetGestureRecognizerFor)
    }
}