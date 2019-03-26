//
//  ViewModel.swift
//  architecture-MVVM
//
//  Created by taigakiyotaki on 2019/03/26.
//  Copyright © 2019 taigakiyotaki. All rights reserved.
//
import Foundation
import UIKit.UIColor

final class ViewModel{
    let changeText = Notification.Name("changeText")
    let changeColor = Notification.Name("changeColor")
    
    private let notificationCenter: NotificationCenter
    private let model: ModelProtocol
    
    init(notificationCenter: NotificationCenter,model: ModelProtocol = Model()){
        self.notificationCenter = notificationCenter
        self.model = model
    }
    
    func idPasswordChanged(id: String?, password: String?){
        let result = model.validate(idText: id, passwordText: password)
        
        switch(result){
        case .success:
            notificationCenter.post(name: changeText, object: "OK!")
            notificationCenter.post(name: changeColor, object: UIColor.green)
        case .failure(let error as ModelError):
            notificationCenter.post(name: changeText, object: error.errorText)
            notificationCenter.post(name: changeColor, object: UIColor.red)
        case _:
            fatalError("Unexpected error")
            
        }
    }
}

//表示に必要なものなので、Modelではなく、ViewModelに置いている
extension ModelError{
    fileprivate var errorText: String{
        switch self{
        case .invaildId:
            return "IDが未入力"
        case .invaildPassword:
            return "PASSWORDが未入力"
        case .invaildIdAndPassword:
            return "ID PASSWORDが未入力"
        }
    }
}
