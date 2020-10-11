//
//  ProficiencyExecercise_WiproUITests.swift
//  ProficiencyExecercise-WiproUITests
//
//  Created by Ketaki Mahaveer Kurade on 10/10/20.
//

import XCTest
@testable import ProficiencyExecercise_Wipro

class ProficiencyExecercise_WiproUITests: XCTestCase {
    var applicationMock: XCUIApplication?
    var controllerMock: UIViewController?

    override func setUpWithError() throws {
        continueAfterFailure = false
        applicationMock = XCUIApplication()
        controllerMock = UIViewController()
        applicationMock!.launch()
    }

    override func tearDownWithError() throws {
        applicationMock = nil
        controllerMock = nil
    }
}
