//
//  ViewController.swift
//  lib-RxSwift-wikipedia
//
//  Created by taigakiyotaki on 2019/03/26.
//  Copyright © 2019 taigakiyotaki. All rights reserved.
//

import UIKit
import RxSwift
import SafariServices
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag: DisposeBag = DisposeBag()
    private let viewModel: WikipediaSearchAPIViewModel = WikipediaSearchAPIViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 検索欄の入力値とViewModelのsearchWordをbind
        self.searchBar.rx.text.orEmpty
            .bind(to: self.viewModel.searchWord)
            .disposed(by: self.disposeBag)
        
        // 検索結果とテーブルのセルをbind
        self.viewModel.items.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) { index, result, cell in
                cell.textLabel?.text = result.title
                cell.detailTextLabel?.text = "https://ja.wikipedia.org/w/index.php?curid=\(result.pageid)"
            }
            .disposed(by: self.disposeBag)
        
        // ViewModelのsearchWordと検索結果の件数をタイトルに表示
        self.viewModel.items.asDriver()
            .skip(1)
            .map { "\(self.viewModel.searchWord.value) 検索結果:\($0.count)件" }
            .drive(self.navigationItem.rx.title)
            .disposed(by: self.disposeBag)
        
        // セル選択時の処理
        self.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.tableView.cellForRow(at: indexPath)
                if let urlStr = cell?.detailTextLabel?.text, let url = URL(string: urlStr) {
                    let safariViewController = SFSafariViewController(url: url)
                    self?.present(safariViewController, animated: true)
                }
            }).disposed(by: disposeBag)
    }
}

