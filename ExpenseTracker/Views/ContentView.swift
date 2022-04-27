//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardTabView()
                .tabItem {
                    VStack {
                        Text("Dashboard").font(Font.custom("Canela-Light", size: 10))
                        Image(systemName: "chart.pie")
                    }
            }
            .tag(0)
            
            LogsTabView()
                .tabItem {
                    VStack {
                        Text("Logs").font(Font.custom("Canela-Light", size: 10))
                        Image(systemName: "tray")
                    }
            }
            .tag(1)
            
            MonthlyTabView()
                .tabItem {
                    VStack {
                        Text("Monthly").font(Font.custom("Canela-Light", size: 10))
                        Image(systemName: "calendar")
                    }
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
