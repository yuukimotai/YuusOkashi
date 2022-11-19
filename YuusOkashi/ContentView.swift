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
    @State var showSafari = false
    
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
        .submitLabel(.search)
        .padding()
        
        List(okashiDataList.okashiList) { okashi in
            Button(action: {
                showSafari.toggle()
            }) {
                HStack {
                    AsyncImage(url: okashi.image) {image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 40)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(okashi.name)
                }
            }//Button end
            .sheet(isPresented: self.$showSafari, content: {
                SafariView(url: okashi.link)
                    .edgesIgnoringSafeArea(.bottom)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
