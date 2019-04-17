//
//  LoginState.swift
//
//  Created by Chuck Krutsinger on 2/5/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import ReSwift



struct LoginState: StateType {
    
    enum LoginStatus {
        case loggedOut, loggedIn(user: User, jwt: String)
        
        ///Returns username if logged in
        var username: Username? {
            switch self {
            
            case .loggedOut:
                return nil
            case .loggedIn(let user, _):
                return user.username
            }
        }
        
        var first: Name? {
            switch self {
                
            case .loggedOut:
                return nil
            case .loggedIn(let user, _):
                return user.first
            }
        }
        
        var last: Name? {
            switch self {
                
            case .loggedOut:
                return nil
            case .loggedIn(let user, _):
                return user.last
            }
        }
        
        var profilePicture: UIImage? {
            switch self {
                
            case .loggedOut:
                return nil
            case .loggedIn(let user, _):
                return user.profilePicture
            }
        }
    }
    
    var loginStatus: LoginStatus
    
    init(loginStatus: LoginStatus = .loggedOut) {
        self.loginStatus = loginStatus
    }
}

func loginReducer(action: Action, state: LoginState?) -> LoginState {
    
    var state = state ?? LoginState()

    if let loginAction = action as? AppAction {
        switch loginAction {
            
        case .logUserIn(let user, let jwt):
            state.loginStatus = .loggedIn(user: user, jwt: jwt)
        case .logUserOut:
            state.loginStatus = .loggedOut
        }
    }

    return state
}

//convenience functions
func logUserOut() {
    Dependencies.app(.logUserOut)
}

func logUserIn(user: User, jwt: JWT) {
    Dependencies.app(.logUserIn(user: user, jwt: jwt))
}
