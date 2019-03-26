//
//  ViewController.swift
//  lib-RxSwift
//
//  Created by taigakiyotaki on 2019/03/26.
//  Copyright © 2019 taigakiyotaki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var sampleButton: UIButton!
    @IBOutlet weak var sampleSwitch: UISwitch!
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSimpleEvent()
        dataBinding()
        dataStream()
    }
    
    func setSimpleEvent(){
        sampleButton.rx.tap.subscribe(
            onNext:{
                print("tap")
        }
            ).disposed(by: disposeBag)
        
        sampleSwitch.rx.isOn.subscribe(
            onNext:{
                print($0)
        }
            ).disposed(by: disposeBag)
    }
    
    func dataBinding(){
        //textFieldのテキストの内容をラベルのテキストにバインドする
        textField.rx.text
            .bind(to:label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func dataStream(){
        textField2.rx.text.orEmpty
            .filter{ $0.count >= 3 } //3文字以上入った時のみ処理が通る
            .map{"入力された文字数は\($0.count)です"} //値を加工して次工程に渡す
            .bind(to: label2.rx.text)
            .disposed(by: disposeBag)
    }

}

