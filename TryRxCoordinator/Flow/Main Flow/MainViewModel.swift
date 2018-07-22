//
//  MainViewModel.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/22.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import RxSwift

struct MainViewModel {
  let repos: Observable<[Repository]>
  let title: Observable<String>

  let reload: AnyObserver<Void>
  let currentLanguage: AnyObserver<String>

  let changeLanguage: AnyObserver<Void>

  let disposeBag = DisposeBag()

  init() {
    let _reload = PublishSubject<Void>()
    reload = _reload.asObserver()

    let _currentLanguage = BehaviorSubject<String>(value: "Swift")
    currentLanguage = _currentLanguage.asObserver()

    let _title = BehaviorSubject<String>(value: "Yaaa")
    title = _title.asObservable()

    repos = Observable.combineLatest(_currentLanguage, _reload).map({ l, _ in l })
      .flatMapLatest({
        return API.shared.request(GitHub.FetchRepo(language: $0))
      }).catchError({ _ in return Observable.empty() })

    let _changeLangauge = PublishSubject<Void>()
    changeLanguage = _changeLangauge.asObserver()

    _changeLangauge
      .map({ _ in GitHub.FetchRepo.getRandomLanguage() })
      .bind(to: _currentLanguage)
      .disposed(by: disposeBag)

    _currentLanguage
      .bind(to: _title)
      .disposed(by: disposeBag)
  }
}
