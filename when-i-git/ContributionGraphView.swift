//
//  ContributionGraphView.swift
//  when-i-git
//
//  Created by 김민택 on 2023/03/23.
//

import SwiftUI

struct ContributionGraphView: View {
    let userName: String
    let networkManager = NetworkManager.shared

    var body: some View {
        Button {
            
        } label: {
            VStack {
                HStack {
                    Text(userName)
                    Spacer()
                    if networkManager.userDatas[userName] != nil {
                        Text("total: \(networkManager.userDatas[userName]!.data.user!.contributionsCollection.contributionCalendar.totalContributions)")
                    }
                }
                HStack(spacing: 4) {
                    if networkManager.userDatas[userName] != nil {
                        ForEach(networkManager.userDatas[userName]!.data.user!.contributionsCollection.contributionCalendar.weeks[36...]) { week in
                            VStack(spacing: 4) {
                                ForEach(week.contributionDays) { day in
                                    RoundedRectangle(cornerRadius: 2).fill(ContributionLevel(rawValue: day.contributionLevel)!.fillColor(.green)).frame(width: 16, height: 16)
                                }
                                if week.contributionDays.count != 7 {
                                    Spacer()
                                }
                            }
                        }
                    } else {
                        Text("Invalid UserName")
                    }
                }
            }
        }
        .foregroundColor(.black)
        .padding(16)
        .frame(width: UIScreen.main.bounds.width - 32)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        )
    }
}

//struct ContributionGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContributionGraphView()
//    }
//}
