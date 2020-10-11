//
//  ProficiencyExecercise_WiproTests.swift
//  ProficiencyExecercise-WiproTests
//
//  Created by Ketaki Mahaveer Kurade on 10/10/20.
//

import XCTest
@testable import ProficiencyExecercise_Wipro

class ProficiencyExecercise_WiproTests: XCTestCase {
    var controllerMock: UIViewController?
    
    override func setUpWithError() throws {
        controllerMock = UIViewController()
    }
    
    override func tearDownWithError() throws {
        controllerMock = nil
    }
    
    /**
     Tests the decoding of JSON in array format
     */
    func testArrayDecoding() throws {
        let jsonText =
            """
        {
        "title":"About Canada",
        "rows":[
            {
            "title":"Beavers",
            "description":"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
            "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
            },
            {
            "title":"Flag",
            "description":null,
            "imageHref":"http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
            }
        ]
        }
        """
        let jsonData = Data(jsonText.utf8)
        XCTAssertNoThrow(try JSONDecoder().decode(AllAboutCanada.self, from: jsonData))
    }
    
    /**
     Tests the decoding of JSON in Dictionary format
     */
    func testDictionaryDecoding() {
        let jsonText =
            """
        {
        "title":"Kittens...",
        "description":"Éare illegal. Cats are fine.",
        "imageHref":"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg"
        }
        """
        let jsonData = Data(jsonText.utf8)
        XCTAssertNoThrow(try JSONDecoder().decode(AboutCanada.self, from: jsonData))
    }
    
    /**
     Tests the service call with valid URL
     */
    func testWithValidURL() {
        // Initializing viewControllerPresenter with Valid URL
        let viewControllerPresenter = AboutCanadaViewControllerPresenter()
        // Attaching viewControllerPresenter with Mock UIViewController
        viewControllerPresenter.attachController(controller: controllerMock!)
        WebServiceCallsManager.shared.getData(fromWebService: URLConstants.aboutCanada.rawValue) { (status, aboutCanada, title) in
            XCTAssertTrue(status, "Bad request")
            XCTAssertNotNil(aboutCanada, "Data not found")
            XCTAssertNotNil(title, "Title not found")
            let mockData = self.readDataFromMockJson()
            XCTAssertEqual(mockData?.title, title)
            viewControllerPresenter.detachController()
        }
    }
    
    /**
     Tests the service call with invalid URL
     */
    func testWithInvalidURL() {
        // Initializing viewControllerPresenter with Valid URL
        let viewControllerPresenter = AboutCanadaViewControllerPresenter()
        // Attaching viewControllerPresenter with Mock UIViewController
        viewControllerPresenter.attachController(controller: controllerMock!)
        WebServiceCallsManager.shared.getData(fromWebService: URLConstants.badURL.rawValue) {  (status, aboutCanada, title) in
            XCTAssertFalse(status)
            viewControllerPresenter.detachController()
        }
    }
    
    /**
     Tests the service call with empty URL
     */
    func testWithEmptyURL() {
        // Initializing viewControllerPresenter with Valid URL
        let viewControllerPresenter = AboutCanadaViewControllerPresenter()
        // Attaching viewControllerPresenter with Mock UIViewController
        viewControllerPresenter.attachController(controller: controllerMock!)
        WebServiceCallsManager.shared.getData(fromWebService: "") {  (status, aboutCanada, title) in
            XCTAssertFalse(status)
            viewControllerPresenter.detachController()
        }
    }
    
    /**
     Reads data from mock json
     */
    func readDataFromMockJson() -> AllAboutCanada? {
        let urlBar = Bundle.main.url(forResource: "MockAllAboutCanadaJSONData", withExtension: "geojson")!
        
        do {
            let jsonData = try Data(contentsOf: urlBar)
            let allAboutCanada = try? JSONDecoder().decode(AllAboutCanada.self, from: jsonData)
            return allAboutCanada
        } catch {
            XCTFail("Missing Mock Json file: MockAllAboutCanadaJSONData.geojson")
        }
        return nil
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
