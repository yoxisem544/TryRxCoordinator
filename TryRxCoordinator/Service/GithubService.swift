//
//  GithubService.swift
//  RepoSearcher
//
//  Created by Arthur Myronenko on 6/29/17.
//  Copyright © 2017 UPTech Team. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Alamofire

typealias Method = HTTPMethod

enum ServiceError: Error {
    case cannotParse
}

protocol GithubServiceTargetType: DecodableResponseTargetType {}

extension GithubServiceTargetType {
  var baseURL: URL { return URL(string: "https://api.github.com")! }
  var headers: [String : String]? { return nil }
  var sampleData: Data {
    let path = Bundle.main.path(forResource: "samples", ofType: "json")!
    return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
  }
}

enum GitHub {
  struct FetchRepo: GithubServiceTargetType, SpecialJSONEntryPath {
    typealias ResponseType = [Repository]

    var path: String { return "/search/repositories" }
    var method: Method { return .get }
    var task: Task { return
      .requestParameters(
        parameters: ["q": "language:\(language)", "sort": "stars"],
        encoding: URLEncoding.default) }

    var jsonEntryPath: String { return "items" }

    private let language: String

    init(language: String) {
      self.language = language
    }

    /// - Returns: a list of languages from GitHub.
    static func getLanguageList() -> [String] {
      // For simplicity we will use a stubbed list of languages.
      return [
        "Swift",
        "Objective-C",
        "Java",
        "C",
        "C++",
        "Python",
        "C#"
      ]

    }

    static func getRandomLanguage() -> String {
      let count = getLanguageList().count
      return getLanguageList()[Int(arc4random_uniform(UInt32(count)))]
    }
  }
}
