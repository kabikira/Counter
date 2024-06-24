//
//  CounterTests.swift
//  CounterTests
//
//  Created by koala panda on 2024/06/24.
//

import XCTest
import Quick
import Nimble
@testable import Counter


class CounterViewControllerSpec: QuickSpec {
    override func spec() {
        var vc: CounterViewController!
        var window: UIWindow!

        beforeEach {
            vc = CounterViewController.make()
            window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = vc
            window.makeKeyAndVisible()
        }

        // 初期表示のテスト
        describe("初期表示") {
            it("カウントが「0」であること") {
                expect(vc.countLabel.text).to(equal("0"))
            }
        }

        // 「+」ボタンをタップしたときのテスト
        describe("「+」ボタンをタップ") {
            context("現在値が「0」") {
                it("カウンタが「1」に増えること") {
                    vc.incrementButton.sendActions(for: .touchUpInside)
                    expect(vc.countLabel.text).to(equal("1"))
                }
            }
        }
    }
}

class CounterViewControllerTests: XCTestCase {

    func testIncrementButton() {
        // 1テスト対象のViewControllerを表示させる
        let vc = CounterViewController.make()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.makeKeyAndVisible()

        // 2初期のカウントは「0」であること
        XCTAssertEqual(vc.countLabel.text, "0")

        // 3「+」ボタンをタップするとカウントが「1」に変化すること
        vc.incrementButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(vc.countLabel.text, "1")
    }
}

final class CounterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
