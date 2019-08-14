//
//  ViewController.swift
//  Bound MVP 2.1
//
//  Created by Ryan Cornel on 8/1/19.
//  Copyright © 2019 Ryan Cornel for Bound. All rights reserved.
//

import UIKit
import AuthenticationServices

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setBackground()
        setupView()
        
    }

        // Establishes Background Image
        let backgroundImageView = UIImageView()
       
        // Sets Background Image
        func setBackground() {
           
           view.addSubview(backgroundImageView)
           
           backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
           backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0   ).isActive = true
           backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
           backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
           backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
           
           
           backgroundImageView.image = UIImage(named: "Bound Signin Resized")
           view.sendSubviewToBack(backgroundImageView)
           
       }
       
    // Function/Method to create Apple Sign In Button.
    
    func setupView() {
        let appleButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        
            appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
       
            view.addSubview(appleButton)
        NSLayoutConstraint.activate([appleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75), appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0) , appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35), appleButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -35), appleButton.heightAnchor.constraint(equalToConstant: 50), appleButton.widthAnchor.constraint(equalToConstant: 350)])
        
          /*  NSLayoutConstraint.activate([appleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100), appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 125), appleButton.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -125), appleButton.heightAnchor.constraint(equalToConstant: 50), appleButton.widthAnchor.constraint(equalToConstant: 180)]) */
       }
    
    @objc func didTapAppleButton() {
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        // Authorization Controller : Takes in request from provider.
        let controller = ASAuthorizationController(authorizationRequests: [request])
        
        controller.delegate = (self as ASAuthorizationControllerDelegate)
        controller.presentationContextProvider = (self as ASAuthorizationControllerPresentationContextProviding)
        
        controller.performRequests()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let mainViewController = segue.destination as? MainViewController, let user = sender as? User {
            
            mainViewController.user = user
        }

    }
}


// Where All The Magic Happens.

extension SignInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
            
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = User(credentials: credentials)
            performSegue(withIdentifier: "signInSegue", sender: user)
            
        default : break
        }
        
    }
    
    private func authorizaitonController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
        print("An Error Occured \(error)")
    }
}

extension SignInViewController:ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return view.window!
    }
}
