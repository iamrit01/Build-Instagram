//
//  LoginViewController.swift
//  Build-Instagram
//
//  Created by Mizia Lima on 3/10/21.
//

import UIKit

//MARK: EVENTS
protocol LoginViewEvents: AnyObject {
    func rootViewController(viewController: UIViewController)
}

//MARK: VIEWCONTROLLER
class LoginViewController: UIViewController {
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

//MARK: VIEWMODEL
    private let viewModel: LoginViewModelProtocol
    
    init(viewModel: LoginViewModelProtocol = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginButton.center = view.center
    }
    
    func setupView(){
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc func didTapLoginButton() {
        viewModel.didTapLoginButton()
    }
}

//MARK: EXTENSIONS
extension LoginViewController: LoginViewEvents {
    
    func rootViewController(viewController: UIViewController) {
        UIViewController.replaceRootViewController(viewController: viewController)
    }
}
