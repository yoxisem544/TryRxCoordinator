//
//  API.swift
//  TryRxCoordinator
//
//  Created by David on 2018/7/22.
//  Copyright © 2018年 David. All rights reserved.
//

import Moya
import RxSwift

// 由於我們在輸入網址時，有時會有中文在字串中，如果沒有加以轉換，url 會無法使用
extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
  }
}

protocol DecodableResponseTargetType: TargetType {
  associatedtype ResponseType: Decodable
}

protocol SpecialJSONEntryPath {
  var jsonEntryPath: String { get }
}

class API {

  static let shared: API = API()

  private init() {}

  private let provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin()])

  // 每當我傳入一個 request 時，我都會檢查他的 response 可不可以被 decode，
  // conform DecodableResponseTargetType 的意義在此，
  // 因為我們已經先定好 ResponseType 是什麼了，
  // 儘管 request 不知道確定是什麼型態，但一定可以被 JSONDecoder 解析。
  func request<Request: DecodableResponseTargetType>(_ request: Request) -> Single<Request.ResponseType> {
    let target = MultiTarget.init(request)
    return provider.rx.request(target)
      .filterSuccessfulStatusCodes()
      .map(Request.ResponseType.self) // 在此會解析 Response，具體怎麼解析，交由 data model 的 decodable 去處理。
  }

  func request<Request: DecodableResponseTargetType & SpecialJSONEntryPath>(_ request: Request) -> Single<Request.ResponseType> {
    let target = MultiTarget.init(request)
    return provider.rx.request(target)
      .filterSuccessfulStatusCodes()
      .map(Request.ResponseType.self, atKeyPath: request.jsonEntryPath)
  }

}
