//
//  AppRouter.swift
//
//  Created by Chuck Krutsinger on 2/5/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import ReSwift
import RxSwift
import CMUtilities


//all storyboards need a case
enum AppStoryboard: String, AppRouterDestination {
    case loginStoryboard = "Login"
    case homeScreenStoryboard = "HomeScreen"
    case playGamesStoryboard = "PlayGames"
    case memoryLeakExampleStoryboard = "MemoryLeakExample"
    case viewProfileStoryboard = "ViewProfile"
}

//define an initial route for AppRouterState
let initialRoute = AppRouterState.Route.rootWindow(AppStoryboard.loginStoryboard)

//define actions for the router
enum RoutingAction: AppRouterAction {
    case displayLoginScreen
    case displayHomeScreen
    case pushTetris
    case push(_ destination: AppStoryboard)
    case alert(title: String, message: String, completion: (() -> Void)?)
}

//define how to reduce the actions
func routingReducer(action: AppRouterAction, state: AppRouterState?) -> AppRouterState {
    
    var state = state ?? AppRouterState(route: initialRoute)
    
    if let routingAction = action as? RoutingAction {
        switch routingAction {

        case .push(let destination):
            state.updateRoute(.push(destination))
        case .alert(let title, let message, let completion):
            state.updateRoute(.alert(title: title, message: message, completion: completion))
        case .displayLoginScreen:
            state.updateRoute(.rootWindow(AppStoryboard.loginStoryboard))
        case .displayHomeScreen:
            state.updateRoute(.rootWindow(AppStoryboard.homeScreenStoryboard))
        case .pushTetris:
            //use alert until this is implemented
            state.updateRoute(.alert(title: "Not Implemented", message: "Tetris is not yet implemented", completion: nil))
        }
    }
    
    return state
}


//Convenience functions

///Route an `Action` to the `AppRouter`
func appRouterAction(_ action: RoutingAction) {
    Dependencies.routerAction(action)
}
