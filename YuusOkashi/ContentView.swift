//
//  ContentView.swift
//  YuusOkashi
//
//  Created by 茂田井雄輝 on 2022/11/16.
//

import SwiftUI

struct ContentView: View {
    @StateObject var okashiDataList = OkashiData()
    @State var inputText = ""
    
    var body: some View {
        VStack {
            TextField("キーワード",
                      text: $inputText,
                prompt: Text("キーワードを入力して下さい"))
            .onSubmit {
                Task {
                    await okashiDataList.searchOkashi(keyword: inputText)
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
