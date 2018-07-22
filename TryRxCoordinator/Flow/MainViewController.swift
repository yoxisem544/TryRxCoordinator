//
//  MainViewController.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/22.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  private var goLoginFlowButton: UIButton!
  private var goNavigationFlowButton: UIButton!
  private var goTabBarFlowButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    goLoginFlowButton = genButton(title: "前往登入流程")
    goLoginFlowButton.center = view.center
    view.addSubview(goLoginFlowButton)
  }

  func genButton(title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.sizeToFit()
    return button
  }

}
