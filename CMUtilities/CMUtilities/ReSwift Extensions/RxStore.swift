//
//  RxStore.swift
//
//  Created by Chuck Krutsinger on 2/6/19.
//  Copyright © 2019 Countermind, LLC. MIT License.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this
//  software and associated documentation files (the "Software"), to deal in the Software
//  without restriction, including without limitation the rights to use, copy, modify, merge,
//  publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
//  to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or
//  substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
//  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  SOFTWARE.


import RxSwift
import ReSwift
import RxCocoa

///Wrapper class to provide an RxSwift `Observable` of ReSwift `Store`.
public class RxStore<AnyStateType: StateType> {
    
    private var stateRelay: BehaviorRelay<AnyStateType?> = BehaviorRelay<AnyStateType?>(value: nil)
    private var store: Store<AnyStateType>
    
    /**
     Create an instance of an `Observable` wrapper for ReSwift `Store` class.
     
     - Parameters:
         - reducer: ReSwift style reducer function that takes an action and the current state of the store and returns updated state.
         - initialState: the initial state
         - middleware: ReSwift middleware classes that receive the actions before the reduce and can act on, modify, replace,
             or swallow the action.

     - Returns: new instance
     */
    public init(reducer: @escaping Reducer<AnyStateType>, initialState: AnyStateType?, middleware: [Middleware<AnyStateType>] = []) {
        self.store = Store<AnyStateType>(reducer: reducer, state: initialState, middleware: middleware)
        self.store.subscribe(self)
    }
    
    deinit {
        self.store.unsubscribe(self)
    }
    
    ///Relay function for `Store.dispatch(...)`.
    public func dispatch(_ action: Action) {
        store.dispatch(action)
    }
    
    ///`Observable` state from the `Store`
    public var state: Observable<AnyStateType> {
        return stateRelay.asObservable().unwrapOptional()
    }
}

extension RxStore: StoreSubscriber {
    
    public func newState(state newState: AnyStateType) {
        stateRelay.accept(newState)
    }
}


