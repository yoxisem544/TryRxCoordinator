//
//  ViewController.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/19.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

  var ob: Observable<Int>!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    ob = Observable.of(1,2,3,4)
    ob.subscribe(onNext: { print($0) },
                 onError: nil,
                 onCompleted: { print("C") },
                 onDisposed: { print("D") })

    view.backgroundColor = .white
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    print("")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

