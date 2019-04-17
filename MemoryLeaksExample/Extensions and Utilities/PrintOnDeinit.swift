// 
// Created on 2/15/19
//  Copyright © 2019 Countermind, LLC. All rights reserved.

///Embed this class as a let in a struct and it will alert you to when struct is released
/// example:  let printOnDeinit = PrintOnDeinit(message: "\(String(describing: StructTypeName.self)) deinit")

public class PrintOnDeinit {
    private let message: String
    
    init(message: String) {
        self.message = message
    }
    
    deinit {
        print("\(message)")
    }
}

