//
//  QuizeListView.swift
//  CryptoQuize
//
//  Created by 中出翔也 on 2022/09/03.
//

import SwiftUI

struct QuizeListView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(1...10, id: \.self) { chapter in
                    if chapter > 3 {
                        QuizeColumn(chapter, false)
                    } else {
                        QuizeColumn(chapter, true)
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct QuizeColumn: View {
    var chapter: Int
    var clear:Bool = false
    
    init(_ chapter: Int, _ clear: Bool ){
        self.chapter = chapter
        self.clear = clear
    }
    
    var body: some View {
        NavigationLink {
            QuizeMainView()
        } label: {
            HStack {
                
                Text("Chapter \(chapter)")
                    .padding()
                    .foregroundColor(.primary)
                if clear {
                    Spacer()
                    Text("Clear!")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding()
                        .rotationEffect(Angle.degrees(10))
                    //                        .offset(x: 0, y: -20)
                }
            }.frame(width: 250, height: 50, alignment: .leading)
                .background(clear ? .green : .gray )
                .cornerRadius(10)
        }
    }
}

struct QuizeListView_Previews: PreviewProvider {
    static var previews: some View {
        QuizeListView()
    }
}
