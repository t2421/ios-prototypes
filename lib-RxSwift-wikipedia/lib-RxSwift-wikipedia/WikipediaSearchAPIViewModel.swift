//
//  WikipediaSearchAPIViewModel.swift
//  lib-RxSwift-wikipedia
//
//  Created by taigakiyotaki on 2019/03/26.
//  Copyright © 2019 taigakiyotaki. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

class WikipediaSearchAPIViewModel {
    
    var searchWord   = Variable<String>("")
    var items        = Variable<[Result]>([])
    
    private let model = WikipediaSearchAPIModel()
    private var disposeBag   = DisposeBag()
    
    init() {
        // searchWordからWikipedia APIの検索結果を得てitemsにbind
        searchWord.asObservable()
            .filter { $0.count >= 3 }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] str in
                return self.model.searchWikipedia(["srsearch": str])
            }
            .bind(to: self.items)
            .disposed(by: self.disposeBag)
    }
    
}
