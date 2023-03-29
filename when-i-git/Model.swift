//
//  Model.swift
//  when-i-git
//
//  Created by 김민택 on 2023/03/22.
//

import Foundation

struct GithubModel: Codable {
    let data: GithubData
    let errors: [GithubError]?
}

struct GithubData: Codable {
    let user: User?
}

struct User: Codable {
    let contributionsCollection: ContributionsCollection
}

struct ContributionsCollection: Codable {
    let contributionCalendar: ContributionCalendar
}

struct ContributionCalendar: Codable {
    let totalContributions: Int
    let weeks: [Week]
}

struct Week: Codable, Identifiable {
    let id = UUID()
    let contributionDays: [ContributionDay]
}

struct ContributionDay: Codable, Identifiable {
    let id = UUID()
    let contributionCount: Int
    let contributionLevel: ContributionLevel.RawValue
    let date: String
}

struct GithubError: Codable {
    let type: String
    let path: [String]
    let locations: [ErrorLocation]
    let message: String
}

struct ErrorLocation: Codable {
    let line: Int
    let column: Int
}
