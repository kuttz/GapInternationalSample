//
//  LoginViewController.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    var userModel: UserViewModel
    
    fileprivate var nameField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "User name"
        textField.text = "Sree123"
        return textField
    }()
    
    fileprivate var passwordField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.text = "Sree@123"
        return textField
    }()
    
    fileprivate var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.accentColor
        return button
    }()
    
    fileprivate var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.accentColor, for: .normal)
        return button
    }()
    
    init(model: UserViewModel) {
        userModel = model
        super.init(nibName: nil, bundle: nil)
        
        userModel.loginDelegate = self
        addTapToDismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let stack = UIStackView(arrangedSubviews: [nameField, passwordField, loginButton, registerButton])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stack)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 260)
        ])
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    @objc fileprivate func login() {
        userModel.userLogin(name: nameField.text, password: passwordField.text)
    }
    
    @objc fileprivate func register() {
        let registerVC = RegisterViewController(model: userModel)
        show(registerVC, sender: self)
    }

}

// MARK: - UserViewLoginDelegate
extension LoginViewController: UserViewLoginDelegate {
    
    func onLoginSuccess(with user: User) {
        debugPrint("New user signin: ", user.userName)
    }
    
    func onLoginFailed(message: String) {
        showAlert(with: message)
    }
}
