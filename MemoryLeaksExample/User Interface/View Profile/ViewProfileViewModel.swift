//
//  ViewProfileViewModel.swift
//  MemoryLeaksExample
//
//  Created by Chuck Krutsinger on 2/14/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import RxSwift
import RxCocoa

func viewProfileViewModel()
  -> (
        username: Driver<Username>,
        fullname: Driver<Name>,
        profilePicture: Driver<UIImage?>
     )
{
    let username = Dependencies.appState
        .map { $0.loginState.loginStatus.username }
        .unwrapOptional()
        .asDriverLogError()
    
    let fullname = Dependencies.appState
        .map(combineFirstLastNames())
        .asDriverLogError()
    
    let profilePicture = Dependencies.appState
        .map { $0.loginState.loginStatus.profilePicture }
        .asDriverLogError()
    
    return (username, fullname, profilePicture)
}

fileprivate func combineFirstLastNames() -> (AppState) -> String {
    return { "\($0.loginState.loginStatus.first ?? "") \($0.loginState.loginStatus.last ?? "")" }
}

