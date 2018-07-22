//
//  MainViewController.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/22.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {

  // show github repo
  // can goto webview
  // can change language
  // can fake login

  private var repoList: UITableView!
  private var repoListLayout: UICollectionViewFlowLayout!
  private var refreshControl: UIRefreshControl!
  private var changeLanguageButton: UIBarButtonItem!
  private let vm = MainViewModel()
  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    setupUI()
    setupBinding()

    refreshControl.sendActions(for: .valueChanged)
  }

  func setupUI() {
    // navigation
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.largeTitleDisplayMode = .always
    let button = UIBarButtonItem(title: "登入",
                                 style: .plain,
                                 target: self,
                                 action: #selector(barButtonTap))
    changeLanguageButton = UIBarButtonItem(title: "換語言",
                                           style: .plain,
                                           target: self,
                                           action: nil)
    navigationItem.rightBarButtonItems = [button, changeLanguageButton]

    repoList = UITableView(frame: view.bounds)
    repoList.backgroundColor = .white
    repoList.register(UITableViewCell.self, forCellReuseIdentifier: "Ya")
    view.addSubview(repoList)

    refreshControl = UIRefreshControl()
    repoList.addSubview(refreshControl)
  }

  func setupBinding() {
    vm.title
      .bind(to: navigationItem.rx.title)
      .disposed(by: disposeBag)

    refreshControl.rx.controlEvent(.valueChanged)
      .bind(to: vm.reload)
      .disposed(by: disposeBag)

    changeLanguageButton.rx.tap
      .bind(to: vm.changeLanguage)
      .disposed(by: disposeBag)

    vm.repos
      .do(onNext: { [weak self] _ in self?.refreshControl.endRefreshing() })
      .bind(to: repoList.rx.items(cellIdentifier: "Ya", cellType: UITableViewCell.self)) { (_, repo, cell) in
        cell.textLabel?.text = repo.fullName
      }
      .disposed(by: disposeBag)

  }

  @objc
  func barButtonTap() {

  }

}
