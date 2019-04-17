//
//  LoginViewState.swift
//
//  Created by Chuck Krutsinger on 2/5/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import ReSwift


struct LoginViewState: StateType {
    enum LoginViewStatus {
        case enteringCredentials, validatingCredentials
    }
    
    var loginViewStatus: LoginViewStatus
    
    init(loginScreenStatus: LoginViewStatus = .enteringCredentials) {
        self.loginViewStatus = loginScreenStatus
    }
}

func loginViewReducer(action: Action, state: LoginViewState?) -> LoginViewState {
    var state = state ?? LoginViewState()
    
    if let loginViewAction = action as? LoginViewAction {
        switch loginViewAction {
            
        case .allowInput:
            state.loginViewStatus = .enteringCredentials
        case .startValidatingCredentials:
            state.loginViewStatus = .validatingCredentials
        }
    }
    
    return state
}

enum LoginViewAction: Action {
    case allowInput, startValidatingCredentials
}

//Convenience functions
func loginViewAction(_ action: LoginViewAction) {
    Dependencies.loginView(action)
}
