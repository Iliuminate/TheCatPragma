//
//  CatDetailWireframe.swift
//  TheCatPragma
//
//  Created by CarlosDz on 9/06/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class CatDetailWireframe: BaseWireframe<CatDetailViewController> {

    // MARK: - Module setup -
    init(_ cat: Cat) {
        let moduleViewController = CatDetailViewController()
        super.init(viewController: moduleViewController)

        let interactor = CatDetailInteractor()
        let presenter = CatDetailPresenter(view: moduleViewController, interactor: interactor, wireframe: self, cat: cat)
        moduleViewController.presenter = presenter
    }

}

// MARK: - CatDetailWireframeInterface -

extension CatDetailWireframe: CatDetailWireframeInterface {
}
