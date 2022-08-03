//
//  ContentView.swift
//  Bitcoin
//
//  Created by peo on 2022/08/03.
//

import SwiftUI

struct ContentView: View {
    @State var coin: Coin?
    
    private var stream = WebSocketStream()
    
    var body: some View {
        NavigationView {
            List {
                Text("\(coin?.c ?? "")")
            }
            .listStyle(.insetGrouped)
            .onAppear {
                Task {
                    coin = await stream.listenForMessages()
                }
            }
            .onChange(of: coin) { newValue in
                Task {
                    coin = await stream.listenForMessages()
                }
            }
        }
    }
}
