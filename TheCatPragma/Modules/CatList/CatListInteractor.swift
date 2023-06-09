//
//  CatListInteractor.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class CatListInteractor {
    private let serviceManger = ServicesManager.share
}

// MARK: - CatListInteractorInterface -
extension CatListInteractor: CatListInteractorInterface {
    
    func getCats(completion: @escaping ((CatsResult)->Void)) {
        
        serviceManger.execute(
            method: .get
        ) { (response: Result<[Cat], GeneralResult>) in
            switch response {
            case .BusinessError(let error):
                completion(.error(error?.message))
            case .Failure:
                completion(.error(nil))
            case .Success(let data):
                guard let cats = data else {
                    completion(.ok([]))
                    return
                }
                completion(.ok(cats))
            }
        }
    }
}
