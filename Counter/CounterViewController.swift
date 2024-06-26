//
//  ViewController.swift
//  Counter
//
//  Created by koala panda on 2024/06/24.
//

import UIKit

class Counter {
    private (set) var count: Int

    init(count: Int = 0) {
        self.count = count
    }

    var isNotLowerLimit: Bool { return count > 0 }
    var isNotUpperLimit: Bool { return count < 10 }

    func increment() {
        count += 1
    }

    func decrement() {
        count -= 1
    }
}

class CounterViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!

    var counter = Counter()

    static func make() -> CounterViewController {
        let storyboard = UIStoryboard(name: "Counter", bundle: nil)
        return storyboard.instantiateInitialViewController() as! CounterViewController
    }

    @IBAction func tapIncrementButton(_ sender: Any) {
        counter.increment()
        updateView()
    }

    @IBAction func tapDecrementButton(_ sender: Any) {
        counter.decrement()
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    private func updateView() {
        countLabel.text = "\(counter.count)"
        decrementButton.isEnabled = counter.isNotLowerLimit
        incrementButton.isEnabled = counter.isNotUpperLimit
    }
}

