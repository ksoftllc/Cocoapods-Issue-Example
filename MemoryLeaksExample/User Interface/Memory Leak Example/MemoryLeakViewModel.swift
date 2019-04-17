//
//  MemoryLeakViewModel.swift
//  MemoryLeaksExample
//
//  Created by Chuck Krutsinger on 2/14/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import RxSwift

class MemoryLeakViewModel {
    
    private let games = Dependencies.gamesRepository.allGames.share()

    struct UIInputs {
        let rowSelected: Observable<Int>
    }
    
    //UI Outputs
    var gameNames: Observable<[GameName]>!
    var rowSelectedDisposable: Disposable!
    
    func configure(using inputs: UIInputs) {
        gameNames = games.map { $0.map { $0.name } }
        
        rowSelectedDisposable = Observable.combineLatest(inputs.rowSelected, games)
            .map { row, games in games[row] }
            .subscribe(onNext: displayGameDetails)
    }
    
    func displayGameDetails(_ game: Game) {
        let players = game.minPlayers == game.maxPlayers
            ? "\(game.minPlayers)"
            : "\(game.minPlayers) to \(game.maxPlayers)"
        let message = """
                      Players: \(players)
                      Objective: \(game.objective)
                      """
        appRouterAction(
            .alert(title: game.name, message: message, completion: nil)
        )
    }
    
    #if DEBUG
    deinit {
        print("\(String(describing: self)) deinit")
    }
    #endif
}
