//
//  AppState.swift
//
//  Created by Chuck Krutsinger on 2/5/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import ReSwift

struct AppState: StateType {
    let loginState: LoginState
}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(loginState: loginReducer(action: action, state: state?.loginState))
}

enum AppAction: Action {
    case logUserIn(user: User, jwt: JWT)
    case logUserOut
}
