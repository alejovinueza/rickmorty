//
//  CharactersListViewUITests.swift
//  Zara MVP UI Tests
//
//  Created by Alejandro Vinueza on 16/4/24.
//

import XCTest

final class CharactersListViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    func testListViewLoading() {
        app.launch()

        let listView = app.collectionViews["CharactersList"]
        let exists = listView.exists
        XCTAssertTrue(exists, "The list view should exist.")
    }

    func testLoadingIndicatorVisibility() {
        app.launch()

        let loadingIndicator = app.activityIndicators["In progress"]
        let exists = loadingIndicator.exists
        XCTAssert(exists, "Loading indicator should be visible while fetching characters.")
    }

    func testCharacterListDisplaysData() {
        app.launch()

        let firstCharacterName = app.staticTexts["Character 1"]
        XCTAssertTrue(firstCharacterName.waitForExistence(timeout: 5))
    }

    func testNavigationToCharacterDetail() {
        app.launch()

        let firstCell = app.collectionViews.cells.element(boundBy: 0)
        if firstCell.waitForExistence(timeout: 5) {
            firstCell.tap()
            XCTAssertTrue(app.scrollViews["CharacterDetailView"].waitForExistence(timeout: 5), "Detail view should be displayed after tapping a list item.")
        } else {
            XCTFail()
        }
    }

    func testErrorAlertDisplay() {
        app.launchEnvironment["TEST_SCENARIO"] = "LOAD_ERROR"
        app.launch()

        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.exists, "An error alert should be displayed on load failure.")
    }
}
