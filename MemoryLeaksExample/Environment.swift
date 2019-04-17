//
//  Dependencies.swift
//
//  Created by Chuck Krutsinger on 2/4/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import Foundation
import RxSwift
import ReSwift
import CMUtilities

//Functional method of dependency injection as described at https://www.pointfree.co/blog/posts/21-how-to-control-the-world
struct Environment {
    //LoginService
    var loginValidator = mockLoginValidatorService
    
    //AppState
    var app: (AppAction) -> Void = { action in appStateStore.dispatch(action) }
    var appState: Observable<AppState> = appStateStore.state
    
    //AppRouter
    var routerAction: (AppRouterAction) -> Void = { action in appRouterStateStore.dispatch(action) } 
    var appRouterState: Observable<AppRouterState> = appRouterStateStore.state
    
    //LoginView
    var loginView: (LoginViewAction) -> Void = { action in loginViewStateStore.dispatch(action) }
    var loginViewState: Observable<LoginViewState> = loginViewStateStore.state
    
    //Global Constants
    var FETCH_PAGE_SIZE = 3
    
    //Repositories
    var gamesRepository = GamesRepository()
}

//immutable for release build
#if DEBUG
var Dependencies = Environment()
#else
let Dependencies = Environment()
#endif

fileprivate var appStateStore = RxStore<AppState>(reducer: appReducer, initialState: nil)
fileprivate var appRouterStateStore = AppRouter.storeInstance(reducer: routingReducer,
                                                              initialState: AppRouterState(route: initialRoute))
fileprivate var loginViewStateStore = RxStore<LoginViewState>(reducer: loginViewReducer, initialState: nil)
