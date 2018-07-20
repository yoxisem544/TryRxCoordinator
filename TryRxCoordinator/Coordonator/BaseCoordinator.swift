//
//  BaseCoordinator.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/19.
//  Copyright © 2018年 David. All rights reserved.
//

import Foundation
import RxSwift

public class BaseCoordinator<CoordinationResult> {

  private let identifier = UUID()

  private var childCoordinators: [UUID : Any] = [:]

  private func store<R>(coordinator: BaseCoordinator<R>) {
    childCoordinators[coordinator.identifier] = coordinator
  }

  private func free<R>(coordinator: BaseCoordinator<R>) {
    childCoordinators[coordinator.identifier] = nil
  }

  public func coordinate<R>(to coordinator: BaseCoordinator<R>) -> Observable<R> {
    return coordinate(to: coordinator, with: nil)
  }

  public func coordinate<R>(to coordinator: BaseCoordinator<R>, with option: DeepLinkOption?) -> Observable<R> {
    store(coordinator: coordinator)
    return
      coordinator
        .start(with: option)
        .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
  }

  public func start() -> Observable<CoordinationResult> {
    return start(with: nil)
  }

  public func start(with option: DeepLinkOption?) -> Observable<CoordinationResult> {
    fatalError("start(with:) hasn't been implemented...")
  }

}

