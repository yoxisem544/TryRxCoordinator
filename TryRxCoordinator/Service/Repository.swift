//
//  Repository.swift
//  RepoSearcher
//
//  Created by Arthur Myronenko on 6/29/17.
//  Copyright © 2017 UPTech Team. All rights reserved.
//

import Foundation

struct Repository {
    let fullName: String
    let description: String
    let starsCount: Int
    let url: String
}

extension Repository: Equatable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        return lhs.fullName == rhs.fullName
            && lhs.description == rhs.description
            && lhs.starsCount == rhs.starsCount
            && lhs.url == rhs.url
    }
}

extension Repository : Decodable {

  enum CodingKeys: String, CodingKey {
    case fullName = "full_name"
    case description = "description"
    case starsCount = "stargazers_count"
    case url = "html_url"
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    fullName = try container.decodeIfPresent(String.self, forKey: .fullName) ?? ""
    description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    starsCount = try container.decodeIfPresent(Int.self, forKey: .starsCount) ?? 0
    url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
  }

}
