//
//  ViewProfileViewController.swift
//
//  Created by Chuck Krutsinger on 2/8/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import UIKit
import RxSwift
import CMUtilities

class ViewProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePictureImageView |> makeViewRound

        let viewModel = viewProfileViewModel()
        
        bag.insert(
            viewModel.username.drive(usernameLabel.rx.text),
            viewModel.fullname.drive(fullnameLabel.rx.text),
            viewModel.profilePicture.drive(profilePictureImageView.rx.image)
        )
    }
    
    #if DEBUG
    deinit {
        print("\(String(describing: self)) deinit")
    }
    #endif
}
