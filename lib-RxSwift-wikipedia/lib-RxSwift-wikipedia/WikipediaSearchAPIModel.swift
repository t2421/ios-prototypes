//
//  WikipediaSearchAPIModel.swift
//  lib-RxSwift-wikipedia
//
//  Created by taigakiyotaki on 2019/03/26.
//  Copyright © 2019 taigakiyotaki. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WikipediaSearchAPIModel {
    
    let client       = WikipediaAPIClient()
    
    // wikipedia Wikipedia APIでの検索結果をObservableで扱えるようにするためのメソッド
    func searchWikipedia(_ parameters:[String:String]) -> Observable<[Result]> {
        // [Result]型のObservableオブジェクトを生成
        return Observable<[Result]>.create { (observer) -> Disposable in
            // Wikipedia APIへHTTPリクエストを送信
            let request = self.client.getRequest(parameters).responseJSON{ response in
                // 結果にエラーがあればonErrorに渡して処理を終える
                if let error = response.error {
                    observer.onError(error)
                }
                // 結果をパースして[Result]に変換
                let results = self.parseJson(response.result.value as? [String: Any] ?? [:])
                // onNextに渡す
                observer.onNext(results)
                // 完了
                observer.onCompleted()
            }
            return Disposables.create { request.cancel() }
        }
    }
    
    // JSON解析メソッド
    private func parseJson(_ json: Any) -> [Result] {
        guard let items = json as? [String: Any] else { return [] }
        var results = [Result]()
        // JSONの階層を追って検索結果を配列で返す
        if let queryItems = items["query"] as? [String:Any] {
            if let searchItems  = queryItems["search"] as? [[String: Any]] {
                searchItems.forEach{
                    guard let title = $0["title"] as? String,
                        let pageid = $0["pageid"] as? Int else {
                            return
                    }
                    results.append(Result(title: title, pageid: pageid))
                }
            }
        }
        return results
    }
}
