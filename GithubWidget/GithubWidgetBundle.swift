//
//  GithubWidgetBundle.swift
//  GithubWidget
//
//  Created by 김민택 on 2023/03/29.
//

import WidgetKit
import SwiftUI

@main
struct GithubWidgetBundle: WidgetBundle {
    var body: some Widget {
        GithubWidget()
        GithubWidgetLiveActivity()
    }
}
