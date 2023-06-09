//
//  CatDetailInterfaces.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol CatDetailWireframeInterface: WireframeInterface {
}

protocol CatDetailViewInterface: ViewInterface {
}

protocol CatDetailPresenterInterface: PresenterInterface {
    var catName: String { get }
    var catdescription: String { get }
}

protocol CatDetailInteractorInterface: InteractorInterface {
}
