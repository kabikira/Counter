//
//  ViewController.swift
//  Counter
//
//  Created by koala panda on 2024/06/24.
//

import UIKit

class CounterViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!

    var count: Int = 0

    static func make() -> CounterViewController {
        let storyboard = UIStoryboard(name: "Counter", bundle: nil)
        return storyboard.instantiateInitialViewController() as! CounterViewController
    }

    @IBAction func tapIncrementButton(_ sender: Any) {
        count += 1
        updateView()
    }

    @IBAction func tapDecrementButton(_ sender: Any) {
        count -= 1
        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }

    private func updateView() {
        countLabel.text = "\(count)"
        decrementButton.isEnabled = count > 0
        incrementButton.isEnabled = count < 10
    }
}

