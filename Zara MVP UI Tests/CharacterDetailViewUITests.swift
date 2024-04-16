//
//  CharacterDetailViewUITests.swift
//  Zara MVP UI Tests
//
//  Created by Alejandro Vinueza on 16/4/24.
//

import XCTest

final class CharacterDetailViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func testDisplayOfCharacters() {
        app.launch()

        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        if firstCell.waitForExistence(timeout: 5) {
            firstCell.tap()
            let text = app.staticTexts["Rick Sanchez"]
            XCTAssertTrue(text.waitForExistence(timeout: 5), "First character should be visible on the list")
        } else {
            XCTFail()
        }
    }

    func testErrorHandlingInCharacterDetails() {
        app.launchEnvironment["TEST_SCENARIO"] = "LOAD_ERROR"
        app.launch()

        let errorLabel = app.alerts["Error"]
        XCTAssertTrue(errorLabel.exists, "An error message should be displayed when fetching fails")
    }
}
