//
//  UserListView.swift
//  when-i-git
//
//  Created by 김민택 on 2023/03/23.
//

import SwiftUI

struct LocalUser: Identifiable {
    let id = UUID()
    let userName: String
}

struct UserListView: View {
    @State private var users = [LocalUser]()
    @State private var isShowedAlert = false
    @State private var userName = ""

    let networkManager = NetworkManager.shared

    var body: some View {
        NavigationView {
            ScrollView {
                Button("사용자 추가") {
                    isShowedAlert = true
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                )
                .padding(.horizontal, 16)
                .alert("추가할 사용자의 아이디를 입력하세요", isPresented: $isShowedAlert, actions: {
                    TextField("사용자 아이디", text: $userName)

                    Button("확인") {
                        users.append(.init(userName: userName))
                        networkManager.requestContributionInfo(userName)
                        userName = ""
                    }
                    Button("취소", role: .cancel, action: {})
                })

                ForEach(users) { user in
                    ContributionGraphView(userName: user.userName)
                        .padding(.horizontal, 16)
                }
            }
            .navigationTitle("User List")
            .background(Color(uiColor: .systemGray6))
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
