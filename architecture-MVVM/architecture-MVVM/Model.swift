//
//  Model.swift
//  architecture-MVVM
//
//  Created by taigakiyotaki on 2019/03/26.
//  Copyright © 2019 taigakiyotaki. All rights reserved.
//

import Foundation
enum Result<T> {
    case success(T)
    case failure(Error)
}
enum ModelError: Error{
    case invaildId
    case invaildPassword
    case invaildIdAndPassword
}
protocol ModelProtocol{
    func validate(idText: String?, passwordText: String?) -> Result<Void>
}

final class Model : ModelProtocol{
    
    func validate(idText: String?, passwordText: String?) -> Result<Void> {
        switch(idText, passwordText){
        case(.none,.none):
            return .failure(ModelError.invaildIdAndPassword)
        case(.some,.none):
            return .failure(ModelError.invaildPassword)
        case(.none,.some):
            return .failure(ModelError.invaildId)
        case(let idText?, let passwordText?):
            switch(idText.isEmpty,passwordText.isEmpty){
            case(false,false):
                return .success(())
            case(false,true):
                return .failure(ModelError.invaildPassword)
            case(true,false):
                return .failure(ModelError.invaildId)
            case(true,true):
                return .failure(ModelError.invaildIdAndPassword)
            }
        }
        
    }
}
