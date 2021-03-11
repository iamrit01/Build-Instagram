//
//  LoginViewModel.swift
//  Build-Instagram
//
//  Created by Mizia Lima on 3/10/21.
//
import UIKit
import SafariServices

protocol LoginViewModelProtocol: AnyObject {
    func didTapLoginButton()
    func didTapTermsOfService()
    func didTapPrivacyPolitic()
    func didTapTCreateAccount()
    var viewController: LoginViewEvents? { get set }
}

class LoginViewModel: LoginViewModelProtocol {
    weak var viewController: LoginViewEvents?
    
    func didTapLoginButton(){
        let tabBarViewController = UITabBarController()
        
        let view1 = UINavigationController(rootViewController: HomeViewController())
        let view2 = UINavigationController(rootViewController: CameraViewController())
        let view3 = UINavigationController(rootViewController: ExploreViewController())
        let view4 = UINavigationController(rootViewController: NotificationsViewController())
        let view5 = UINavigationController(rootViewController: ProfileViewController())
        
        view1.title = "Home"
        view2.title = "Camera"
        view3.title = "Explore"
        view4.title = "Notifications"
        view5.title = "Profile"
        
        tabBarViewController.setViewControllers([view1, view2, view3, view4, view5], animated: false)
        
        setupTabBarItens(tabBarViewController: tabBarViewController)
        
        viewController?.root(viewController: tabBarViewController)
        //UIViewController.replaceRootViewController(viewController: tabBarViewController)
    }
    
    func didTapTermsOfService(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else { return }
        let termsView = SFSafariViewController(url: url)
        viewController?.present(viewController: termsView)
    }
    
    func didTapPrivacyPolitic(){
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else { return }
        let privacyPoliticView = SFSafariViewController(url: url)
        viewController?.present(viewController: privacyPoliticView)
    }
    
    func didTapTCreateAccount(){
        let registerView = RegisterViewController()
        viewController?.present(viewController: registerView)
    }
    
    private func setupTabBarItens(tabBarViewController: UITabBarController){
        guard let items = tabBarViewController.tabBar.items else { return }
        let images = ["house", "camera", "magnifyingglass", "bell", "person.circle"]
        let selectedImages = ["house.fill", "camera.fill", "magnifyingglass.circle.fill", "bell.fill", "person.circle.fill"]
        
        for i in 0...4 {
            items[i].image = UIImage(systemName: images[i])
            items[i].selectedImage = UIImage(systemName: selectedImages[i])
            UITabBar.appearance().tintColor = .black
            UITabBar.appearance().unselectedItemTintColor = .mediumGray()
        }
    }
}
