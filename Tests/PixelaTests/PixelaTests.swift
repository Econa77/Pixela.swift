//
//  PixelaTests.swift
//  PixelaTests
//
//  Created by Shunsuke Furubayashi on 2020/03/16.
//  Copyright © 2020 ShunsukeFurubayashi. All rights reserved.
//

import XCTest
@testable import Pixela

final class PixelaTests: XCTestCase {

    // MARK: - Properties
    private let pixela = Pixela(configuration: nil)

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        pixela.apiConfiguration = APIConfiguration(baseURL: URL(string: "https://custom.pixe.la")!)
        pixela.configuration = Configuration(username: "tests-username", token: "tests-secret-token")
    }

    override func tearDown() {
        super.tearDown()
        pixela.apiConfiguration = .default
        pixela.configuration = nil
    }

    // MARK: - Tests
    func testGraphSVGURL() {
        let date = Date()
        let baseURLString = pixela.apiConfiguration.baseURL.absoluteString
        let url1 = pixela.getGraphSVGURL(id: "tests-graph", date: nil, mode: nil, appearance: nil)
        XCTAssertEqual(url1.absoluteString, "\(baseURLString)/v1/users/tests-username/graphs/tests-graph")
        let url2 = pixela.getGraphSVGURL(id: "tests-graph", date: date, mode: nil, appearance: nil)
        XCTAssertEqual(url2.absoluteString, "\(baseURLString)/v1/users/tests-username/graphs/tests-graph?date=\(date.formatString())")
        let url3 = pixela.getGraphSVGURL(id: "tests-graph", date: date, mode: .short, appearance: nil)
        XCTAssertEqual(url3.absoluteString, "\(baseURLString)/v1/users/tests-username/graphs/tests-graph?date=\(date.formatString())&mode=\(Graph.SVGMode.short.rawValue)")
        let url4 = pixela.getGraphSVGURL(id: "tests-graph", date: date, mode: nil, appearance: .dark)
        XCTAssertEqual(url4.absoluteString, "\(baseURLString)/v1/users/tests-username/graphs/tests-graph?date=\(date.formatString())&appearance=\(Graph.Appearance.dark.rawValue)")
        let url5 = pixela.getGraphSVGURL(id: "tests-graph", date: nil, mode: .badge, appearance: nil)
        XCTAssertEqual(url5.absoluteString, "\(baseURLString)/v1/users/tests-username/graphs/tests-graph?mode=\(Graph.SVGMode.badge.rawValue)")
    }

    func testGraphHTMLURL() {
        let baseURLString = pixela.apiConfiguration.baseURL.absoluteString
        let url1 = pixela.getGraphHTMLURL(id: "tests-graph", mode: nil)
        XCTAssertEqual(url1.absoluteString, "\(baseURLString)/v1/users/tests-username/graphs/tests-graph.html")
        let url2 = pixela.getGraphHTMLURL(id: "tests-graph", mode: .simple)
        XCTAssertEqual(url2.absoluteString, "\(baseURLString)/v1/users/tests-username/graphs/tests-graph.html?mode=\(Graph.HTMLMode.simple.rawValue)")
    }

}
