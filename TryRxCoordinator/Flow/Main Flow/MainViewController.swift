//
//  MainViewController.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/22.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  // show github repo
  // can goto webview
  // can change language
  // can fake login

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    // navigation
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
    let button = UIBarButtonItem(title: "登入",
                                 style: .plain,
                                 target: self,
                                 action: #selector(barButtonTap))
    navigationItem.rightBarButtonItem = button
    title = "看看 Repo"

  }

  @objc
  func barButtonTap() {

  }


}
