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

class CounterSpec: QuickSpec {
    override func spec() {

        describe("#init") {
            context("引数なしで初期化") {
                it("countが｢0｣であること") {
                    expect(Counter().count).to(equal(0))
                }
            }
            context("引数｢5｣で初期化") {
                it("countが｢5｣であること") {
                    expect(Counter(count: 5).count).to(equal(5))
                }
            }
        }

        describe("#increment / #decrement") {
            context("現在値が｢5｣") {
                var counter: Counter!

                beforeEach {
                    counter = Counter(count: 5)
                }
                it("incrementすると6になること") {
                    counter.increment()
                    expect(counter.count).to(equal(6))
                }
                it("decremetすると4になること") {
                    counter.decrement()
                    expect(counter.count).to(equal(4))
                }
            }
        }

        describe("#isLowerLimit") {
            context("現在値が｢0｣") {
                it("trueを返すこと") {
                    expect(Counter().isLowerLimit).to(beTrue())
                }
            }
            context("現在値が｢1｣") {
                it("falseを返すこと") {
                    expect(Counter(count: 1).isLowerLimit).to(beFalse())
                }
            }
        }

        describe("#isUpperLimit") {
            context("現在値が「9」") {
                it("falseを返すこと") {
                    expect(Counter(count: 9).isUpperLimit).to(beFalse())
                }
            }
            context("現在値が「10」") {
                it("trueを返すこと") {
                    expect(Counter(count: 10).isUpperLimit).to(beTrue())
                }
            }
        }

        describe("永続化") {
            context("現在値が｢2｣") {
                var counter: Counter!
                var counterStorageMock: CounterStorageMock!

                beforeEach {
                    // モックオブジェクトを生成し、CounterクラスにDIする
                    counterStorageMock = CounterStorageMock()
                    counter = Counter(count: 2, counterStorage: counterStorageMock)
                }
                context("#incrementを呼び出す") {
                    it("CounterStorage.save()が引数「3」で呼び出されること") {
                        counter.increment()

                        // モックオブジェクトに記録されたメソッド呼び出し時の引数を検証
                        expect(counterStorageMock.latestSaveCount).to(equal(3))
                    }
                }

                context("#decrementを呼び出す") {
                    it("CounterStorage.save()が引数「1」で呼び出されること") {
                        counter.decrement()
                        expect(counterStorageMock.latestSaveCount).to(equal(1))
                    }
                }
            }
        }
    }
}

extension UIButton {
    func tap(repeat: Int = 1) {
        for _ in 1...`repeat` {
            self.sendActions(for: .touchUpInside)
        }
    }
}

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

            it("+」ボタンが活性であること") {
                expect(vc.incrementButton.isEnabled).to(beTrue())
            }

            it("｢-｣ボタンが非活性であること") {
                expect(vc.decrementButton.isEnabled).to(beFalse())
            }
        }

        // 「+」ボタンをタップしたときのテスト
        describe("「+」ボタンをタップ") {
            context("現在値が「0」") {
                it("カウンタが「1」に増えること") {
                    vc.incrementButton.tap()
                    expect(vc.countLabel.text).to(equal("1"))
                }

                it("下限値でなくなるので｢-｣ボタンが活性になること") {
                    vc.incrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beTrue())
                }
            }

            context("上限値に達した場合") {
                beforeEach {
                    // 1「+」ボタンを10回タップ
                    vc.incrementButton.tap(repeat: 10)
                }

                it("上限値なので「+」ボタンが非活性になること") {
                    expect(vc.countLabel.text).to(equal("10"))
                    expect(vc.incrementButton.isEnabled).to(beFalse()) // 2【失敗】
                }
            }
        }

        describe("｢-｣ボタンをタップ") {
            context("現在値が｢1｣") {
                beforeEach {
                    // 1事前に現在値を「1」にしておく
                    vc.incrementButton.tap()
                }

                it("カウンタが｢0｣に減ること") {
                    // 2カウントが「0」になることを検証
                    vc.decrementButton.tap()
                    expect(vc.countLabel.text).to(equal("0"))
                }

                it("下限値になるので「-」ボタンが非活性になること") {
                    vc.decrementButton.tap()
                    expect(vc.decrementButton.isEnabled).to(beFalse())
                }
            }
        }

        describe("現在値の保存") {
            context("現在値が2") {
                beforeEach {
                    vc.incrementButton.tap(repeat: 2)
                    UserDefaults.standard.set(0, forKey: "count")
                }
                context("「+」ボタンをタップ") {
                    it("現在値「3」がUserDefaultsに保存されること") {
                        vc.incrementButton.tap()

                        // 3UserDefaultsのキー「count」から値を取得してアサーション
                        let actual = UserDefaults.standard.integer(forKey: "count")
                        expect(actual).to(equal(3))
                    }
                }
                context("「-」ボタンをタップ") {
                    it("現在値「1」がUserDefaultsに保存されること") {
                        vc.decrementButton.tap()

                        // 3UserDefaultsのキー「count」から値を取得してアサーション
                        let actual = UserDefaults.standard.integer(forKey: "count")
                        expect(actual).to(equal(1))
                    }
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
