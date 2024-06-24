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

    static func make() -> CounterViewController {
        let storyboard = UIStoryboard(name: "Counter", bundle: nil)
        return storyboard.instantiateInitialViewController() as! CounterViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

