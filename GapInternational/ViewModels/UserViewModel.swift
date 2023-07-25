//
//  UserViewModel.swift
//  GapInternational
//
//  Created by Sreekuttan D on 21/07/23.
//

import Foundation

protocol UserViewLoginDelegate: AnyObject {
    
    func onLoginSuccess(with user: User)
    
    func onLoginFailed(message: String)
}

protocol UserViewRegistrationDelegate: AnyObject {
    
    func onRegistrationSuccess()
    
    func onRegistrationFailed(message: String)
}

class UserViewModel: NSObject {
    
    fileprivate let webservice: WebserviceProtocol
    
    fileprivate var onUserChange: (User?, UserViewModel) -> Void
    
    private(set) var user: User? {
        didSet {
            onUserChange(user, self)
        }
    }
    
    weak var loginDelegate: UserViewLoginDelegate?
    
    weak var registerDelegate: UserViewRegistrationDelegate?
    
    init(webservice: WebserviceProtocol, onUserChange: @escaping (User?, UserViewModel) -> Void) {
        self.webservice = webservice
        self.onUserChange = onUserChange
        super.init()
        onUserChange(user, self)
    }
    
    func userLogin(name: String?, password: String?) {
        
        guard let name = name,
              let password = password,
              !name.isEmpty,
              !password.isEmpty else {
            loginDelegate?.onLoginFailed(message: "User name or Password can't be empty")
            return
        }
        
        let user = User(userName: name, password: password)
        guard let request = user.loginRequest() else {
            loginDelegate?.onLoginFailed(message: "Request failed")
            return
        }
        
        Task {
            do {
                let res = try await webservice.load(resource: request)
                Task { @MainActor in
                    if res.result == "Login successful" {
                        self.user = user
                        loginDelegate?.onLoginSuccess(with: user)
                    } else {
                        loginDelegate?.onLoginFailed(message: res.result)
                    }
                }
            } catch {
                Task { @MainActor in
                    loginDelegate?.onLoginFailed(message: "Request failed")
                }
            }
        }
    }
    
    func registerUser(with name: String?, andPassword password: String?) {
        guard let name = name,
              let password = password,
              !name.isEmpty,
              !password.isEmpty else {
            registerDelegate?.onRegistrationFailed(message: "User name or Pasword can't be empty")
            return
        }
        
        let user = User(userName: name, password: password)
        guard let request = user.registerRequest() else {
            registerDelegate?.onRegistrationFailed(message: "Request failed")
            return
        }
        
        Task {
            do {
                let res = try await webservice.load(resource: request)
                
                Task { @MainActor in
                    if res.isSuccess {
                        self.user = user
                        registerDelegate?.onRegistrationSuccess()
                    } else {
                        registerDelegate?.onRegistrationFailed(message: res.result)
                    }
                }
            } catch {
                Task { @MainActor in
                    registerDelegate?.onRegistrationFailed(message: "Request failed")
                }
            }
        }
    }
    
}
