//
//  AppCoordinator.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/19.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

  private let window: UIWindow

  init(window: UIWindow) {
    self.window = window
  }

  override func start() -> Observable<Void> {
    let module = MainViewController()
    window.rootViewController = module
    window.makeKeyAndVisible()
    return Observable.never() // never terminates app coordinator
  }

}
