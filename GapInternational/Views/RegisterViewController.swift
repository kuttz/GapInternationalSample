//
//  RegisterViewController.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import UIKit

class RegisterViewController: UIViewController {

    var userModel: UserViewModel
    
    fileprivate var nameField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "User name"
        return textField
    }()
    
    fileprivate var passwordField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    fileprivate var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.accentColor
        return button
    }()
    
    init(model: UserViewModel) {
        userModel = model
        super.init(nibName: nil, bundle: nil)
        
        userModel.registerDelegate = self
        addTapToDismiss()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let stack = UIStackView(arrangedSubviews: [nameField, passwordField, registerButton])
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
        
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    @objc fileprivate func register() {
        userModel.registerUser(with: nameField.text, andPassword: passwordField.text)
    }

}

extension RegisterViewController: UserViewRegistrationDelegate {
    
    func onRegistrationSuccess() {
        debugPrint("Registration success")
    }
    
    func onRegistrationFailed(message: String) {
        showAlert(with: message)
    }
}
