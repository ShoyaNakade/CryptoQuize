//
//  HomeView.swift
//  CryptoQuize
//
//  Created by 中出翔也 on 2022/09/03.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    Text("Quize Crypto!")
                        .font(.title2)
                }
                .padding()
                .frame(width: .infinity, height: 50, alignment: .center)
                .background(Color.green)
                
                QuizeCategoryView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct QuizeCategoryView: View {
    var body: some View {
        ScrollView {
            VStack{
                
                NavigationLink(destination: QuizeListView()) {
                    HStack(){
                        Text("初心者")
                            .foregroundColor(.primary)
                    }.padding()
                        .frame(width: .infinity, height: 30, alignment: .center)
                        .background(Color.yellow)
                }
                HStack(){
                    Text("初心者")
                }.padding()
                    .frame(width: .infinity, height: 30, alignment: .center)
                    .background(Color.yellow)
                HStack(){
                    Text("初心者")
                }.padding()
                    .frame(width: .infinity, height: 30, alignment: .center)
                    .background(Color.yellow)
            }
        }
    }
}
