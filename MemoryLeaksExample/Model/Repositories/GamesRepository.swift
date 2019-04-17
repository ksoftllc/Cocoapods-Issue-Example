//
//  GamesRepository.swift
//
//  Created by Chuck Krutsinger on 2/8/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import RxSwift

class GamesRepository {
    
    var allGames: Observable<[Game]> {
        return Observable.of(games)
    }
    
    func getGames(pageIndex: Int) -> Observable<[Game]> {
        return Observable.of(fetchGames(pageIndex: pageIndex))
    }
    
    func getGame(id: Int) -> Observable<Game?> {
        return Observable.of(fetchGame(id: id))
    }
}

fileprivate func page<T>(_ pageIndex: Int, of array: Array<T>) -> [T] {
    let start = min(pageIndex * Dependencies.FETCH_PAGE_SIZE, array.count - 1)
    let end = min(start + Dependencies.FETCH_PAGE_SIZE - 1, array.count - 1)
    let slice = array[start...end]
    return Array(slice)
}

//mock database
fileprivate func fetchGames(pageIndex: Int) -> [Game] {
    return page(pageIndex, of: games)
}

fileprivate func fetchGame(id: Int) -> Game? {
    return id < games.count ? games[id] : nil
}

fileprivate let games = gamesInfoTuples.map { Game(name: $0.0, minPlayers: $0.1, maxPlayers: $0.2, objective: $0.3) }

fileprivate var gamesInfoTuples = [
    ("Monopoly",2,6,"To bankrupt all other players"),
    ("Risk",2,6,"To conquer the world"),
    ("Tetris",1,1,"To score points by completing horizontal rows"),
    ("Checkers",2,2,"To capture all of the opponent's pieces"),
    ("Chess",2,2,"To capture all of the opponent's pieces"),
    ("Backgammon", 2, 2, "To be the first to exit all of your pieces from the board"),
    ("Battleship", 2, 2, "To sink all of your opponent's ships"),
    ("Jenga", 2, 2, "To remove pieces without toppling the tower"),
    ("Scrabble", 2, 6, "To score the moist points by spelling words with letter tiles"),
    ("Skip-Bo", 2, 6, "To be the first to play all of the cards in your play pile"),
    ("Stratego", 2, 2, "To find and capture the opponent's flag")
]
