//
//  NetworkManager.swift
//  when-i-git
//
//  Created by 김민택 on 2023/03/22.
//

import Foundation

class NetworkManager: ObservableObject {

    static let shared = NetworkManager()
    @Published var userDatas = [String: GithubModel]()

    private init() {}

    func requestContributionInfo(_ userName: String) {
        let semaphore = DispatchSemaphore(value: 0)

        let url = URL(string: AppTexts.requestURL)!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/graphql", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(Token.accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"

        let parameter = ["query": """
                                  query {
                                    user(login: "\(userName)"){
                                      contributionsCollection {
                                        contributionCalendar {
                                          totalContributions
                                          weeks {
                                            contributionDays {
                                              contributionCount
                                              contributionLevel
                                              date
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                  """]

        do {
            urlRequest.httpBody = try JSONEncoder().encode(parameter)
        } catch {
            print("Encoding Error")
        }

        let session = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error)
                return
            }

            guard let data else {
                print("data is nil")
                return
            }

            do {
                let githubData = try JSONDecoder().decode(GithubModel.self, from: data)
                if githubData.data.user != nil {
                    self.userDatas[userName] = githubData
                }
            } catch {
                print("Decoding Error")
            }
            semaphore.signal()
        }

        session.resume()
        semaphore.wait()
    }
}
