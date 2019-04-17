//
//  Game.swift
//
//  Created by Chuck Krutsinger on 2/12/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

typealias GameName = String
typealias Objective = String

struct Game {
    let name: GameName
    let minPlayers: Int
    let maxPlayers: Int
    let objective: Objective
    
    static func displayGameDetails(_ game: Game) {
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
}

