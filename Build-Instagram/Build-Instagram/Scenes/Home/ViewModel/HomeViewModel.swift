//
//  HomeViewModel.swift
//  Build-Instagram
//
//  Created by Mizia Lima on 3/11/21.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    //func checkStatus()
    var viewController: HomeViewEvents? { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    weak var viewController: HomeViewEvents?
    
//    func checkStatus(){
//        if UserReference.isLogged() {
//            //show Home Principal
//        }
//        if UserReference.isNotLogged() {
//            // show Login
//            let loginView = LoginViewController()
//            loginView.modalPresentationStyle = .fullScreen
//            viewController?.present(viewController: loginView)
//        }
//    }
}
