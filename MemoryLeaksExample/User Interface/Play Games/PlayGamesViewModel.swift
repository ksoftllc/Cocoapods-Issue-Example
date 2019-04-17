//
//  PlayGamesViewModel.swift
//  MemoryLeaksExample
//
//  Created by Chuck Krutsinger on 2/11/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import RxSwift
import RxCocoa

struct PlayGamesViewModel {
    
    private let games = Dependencies.gamesRepository.allGames.share()
    
    #if DEBUG
    private let printOnDeinit = PrintOnDeinit(message: "\(String(describing: PlayGamesViewModel.self)) deinit")
    #endif
    
    struct UIInputs {
        let rowSelected: Observable<Int>
    }
    
    //UI Outputs
    let gameNames: Observable<[GameName]>
    let rowSelectedDisposable: Disposable
    
    init(inputs: UIInputs) {
        gameNames = games.map { $0.map { $0.name } }
 
        rowSelectedDisposable = Observable.combineLatest(inputs.rowSelected, games)
            .map { row, games in games[row] }
            .subscribe(onNext: Game.displayGameDetails)
    }
}


