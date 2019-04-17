//
//  MemoryLeakViewController.swift
//  MemoryLeaksExample
//
//  Created by Chuck Krutsinger on 2/14/19.
//  Copyright © 2019 Countermind, LLC. All rights reserved.
//

import UIKit
import RxSwift
import CMUtilities

class MemoryLeakViewController: UIViewController {
    
    @IBOutlet weak var gamesTable: UITableView!
    
    private var bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideTableViewFooter(gamesTable)
        let cellNib = UINib.init(nibName: GameCell.id, bundle: nil)
        gamesTable.register(cellNib, forCellReuseIdentifier: GameCell.id)

        let inputs = MemoryLeakViewModel.UIInputs(rowSelected: gamesTable.rx.itemSelected.map { $0.row })
        let viewModel = MemoryLeakViewModel()
        
        viewModel.configure(using: inputs)
        
        bag.insert(
            viewModel.gameNames.bind(to: gamesTable.rx.items) { (tableView, row, element) in
                return self.cellFor(element)
            },
            
            viewModel.rowSelectedDisposable
        )
    }
    
    #if DEBUG
    deinit {
        print("\(String(describing: self)) deinit")
    }
    #endif
}

private extension MemoryLeakViewController {
  
    func cellFor(_ element: GameName) -> UITableViewCell {
        let cell = gamesTable.dequeueReusableCell(withIdentifier: GameCell.id) as! GameCell
        cell.nameLabel.text = element
        return cell
    }
}
