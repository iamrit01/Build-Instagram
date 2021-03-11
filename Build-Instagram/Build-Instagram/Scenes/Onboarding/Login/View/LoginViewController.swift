//
//  LoginViewController.swift
//  Build-Instagram
//
//  Created by Mizia Lima on 3/10/21.
//
import UIKit
import SafariServices

//MARK: EVENTS
protocol LoginViewEvents: AnyObject {
    func root(viewController: UIViewController)
    func push(viewController: UIViewController)
    func present(viewController: UIViewController)
}

//MARK: VIEWCONTROLLER
class LoginViewController: UIViewController {
    
    lazy var usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Nome de Usuário ou Email"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    lazy var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Senha"
        field.returnKeyType = .continue
        field.isSecureTextEntry = true
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.backgroundColor = .secondarySystemBackground
        field.delegate = self
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Termos de Serviço", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Política de Privacidade", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Novo usuário? Crie uma conta." , for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "Gradient"))
        view.addSubview(backgroundImageView)
        return view
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
        self.viewModel.viewController = self
        setupViewHierarchy()
        setupActionsFromButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupElementsUI()
    }
    
    private func setupViewHierarchy(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    private func setupElementsUI(){
        //Header
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.widht,
            height: view.height / 3.0)
        
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 30,
            width: view.widht - 50,
            height: 52)
        
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.widht - 50,
            height: 52)
        
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.widht - 50,
            height: 52)
        
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 10,
            width: view.widht - 50,
            height: 52)
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom - 100,
            width: view.widht - 20,
            height: 50)
        
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height-view.safeAreaInsets.bottom - 50,
            width: view.widht - 20,
            height: 50)
        
        configureHeaderView()
    }
    
    private func setupActionsFromButtons(){
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyPoliticButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }
    
    private func configureHeaderView(){
        //Configure Header with a background gradient from Instagram
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //Configure Logo with a logo-text from Instagram
        let imageView = UIImageView(image: UIImage(named: "Text-Logo"))
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.widht / 4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.widht / 2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    @objc func didTapLoginButton() {
        //Refatorar - Regra de negócio
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                  return
        }
    }
    
    @objc func didTapTermsButton() {
        viewModel.didTapTermsOfService()
    }
    
    @objc func didTapPrivacyPoliticButton() {
        viewModel.didTapPrivacyPolitic()
    }
    
    @objc func didTapCreateAccount() {
        viewModel.didTapTCreateAccount()
    }
}

//MARK: EXTENSIONS
extension LoginViewController: LoginViewEvents {
    func root(viewController: UIViewController) {
        UIViewController.replaceRootViewController(viewController: viewController)
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            usernameEmailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            passwordField.resignFirstResponder()
            didTapLoginButton()
        }
        return true
    }
}
