//
//  LoginViewController.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/22.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  private var usernameField: UITextField!
  private var passwordField: UITextField!
  private var loginButton: UIButton!
  private var goTermsButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    usernameField = genTextField()
    usernameField.placeholder = "帳號"
    usernameField.center = view.center
    view.addSubview(usernameField)
  }

  func genButton(title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.sizeToFit()
    return button
  }

  func genTextField() -> UITextField {
    let f = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: 150, height: 25)))
    return f
  }

}
