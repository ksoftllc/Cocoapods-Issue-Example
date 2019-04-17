//
//  ViewController.swift
//
//  Created by Chuck Krutsinger on 2/1/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import UIKit
import RxSwift
import ReSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inputs = LoginViewModel.UIInputs(
            viewState: Dependencies.loginViewState.share(),
            username: usernameTextField.rx.text.unwrapOptional(),
            password: passwordTextField.rx.text.unwrapOptional(),
            loginTap: loginButton.rx.tap.asObservable()
        )
        
        let viewModel = LoginViewModel(inputs)
        
        bag.insert(
            viewModel.loginEnabled.drive(loginButton.rx.isEnabled),
            viewModel.validatingCredentials.drive(activityIndicator.rx.isAnimating),
            viewModel.loginTapDisposable,
            viewModel.endEditing.drive(view.rx.isUserInteractionEnabled)
        )
    }
    
    #if DEBUG
    deinit {
        print("\(String(describing: self)) deinit")
    }
    #endif
}
