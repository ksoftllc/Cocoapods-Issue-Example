//
//  HomeScreenViewController.swift
//
//  Created by Chuck Krutsinger on 2/5/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import UIKit
import RxSwift

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var viewProfileButton: UIButton!
    @IBOutlet weak var playGamesButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var memoryLeakExample: UIButton!
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = homeScreenViewModel(
            viewProfileTap: viewProfileButton.rx.tap.asObservable(),
            playGamesTap: playGamesButton.rx.tap.asObservable(),
            memoryLeakExampleTap: memoryLeakExample.rx.tap.asObservable(),
            logoutTap: logoutButton.rx.tap.asObservable()
        )
        
        bag.insert(
            viewModel.username.drive(usernameLabel.rx.text),
            viewModel.viewProfileDisposable,
            viewModel.playGamesDisposable,
            viewModel.logoutDisposable
        )
    }
    
    #if DEBUG
    deinit {
        print("\(String(describing: self)) deinit")
    }
    #endif
}
