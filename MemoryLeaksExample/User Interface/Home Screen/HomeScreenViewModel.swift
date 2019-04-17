//
//  HomeScreenViewModel.swift
//
//  Created by Chuck Krutsinger on 2/8/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import ReSwift
import RxSwift
import RxCocoa

func homeScreenViewModel(viewProfileTap: Observable<Void>,
                         playGamesTap: Observable<Void>,
                         memoryLeakExampleTap: Observable<Void>,
                         logoutTap: Observable<Void>)
    -> (
            username: Driver<Username>,
            viewProfileDisposable: Disposable,
            playGamesDisposable: Disposable,
            memoryLeakDisposable: Disposable,
            logoutDisposable: Disposable
        )
{
    
    let username = Dependencies.appState
        .map { $0.loginState.loginStatus.username }
        .unwrapOptional()
        .map { "\($0) - Home Screen" }
        .asDriverLogError()
    
    let viewProfileDisposable = viewProfileTap
        .subscribe(onNext: pushViewProfileStoryboard)
    
    let playGamesDisposable = playGamesTap
        .subscribe(onNext: pushPlayGamesStoryboard)
    
    let logoutDisposable = logoutTap
        .do(onNext: logUserOut)
        .subscribe(onNext: displayLoginScreen)
    
    let memoryLeakDisposable = memoryLeakExampleTap
        .subscribe(onNext: showMemoryLeakExample)
    
    return (
        username,
        viewProfileDisposable,
        playGamesDisposable,
        memoryLeakDisposable,
        logoutDisposable
    )
}

fileprivate func showMemoryLeakExample() {
    appRouterAction(.push(.memoryLeakExampleStoryboard))
}

fileprivate func pushPlayGamesStoryboard() {
    appRouterAction(.push(.playGamesStoryboard))
}

fileprivate func pushViewProfileStoryboard() {
    appRouterAction(.push(.viewProfileStoryboard))
}

fileprivate func displayLoginScreen() {
    appRouterAction(.displayLoginScreen)
}
