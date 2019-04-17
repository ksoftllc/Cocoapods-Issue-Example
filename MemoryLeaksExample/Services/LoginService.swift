//
//  LoginService.swift
//
//  Created by Chuck Krutsinger on 2/4/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import Foundation
import RxSwift

enum LoginError: Error {
    case invalidCredentials
}

enum LoginResult {
    case success(user: User, jwt: JWT)
    case failure(error: LoginError)
}

typealias JWT = String //just for demo
typealias Username = String
typealias Password = String

func mockLoginValidatorService(username: String, password: String) -> Observable<LoginResult> {

    return Single<LoginResult>.create { observer in
        //dispatch to simulate web service
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //pause as if going to web
            //simulates invalid username by using "bogus" as username
            guard username != "bogus" else {
                observer(.success(LoginResult.failure(error: LoginError.invalidCredentials)))
                return
            }
            
            //simulates login failure by using "bogus" as password
            guard password != "bogus" else {
                observer(.success(LoginResult.failure(error: LoginError.invalidCredentials)))
                return
            }
            
            //accept any username/password combo that gets past the guard statements
            observer(.success(LoginResult.success(user: User(username: username), jwt: "SOMEJWTSTRINGWOULDGOHERE")))
        }
        
        return Disposables.create()
    }.asObservable()
}
