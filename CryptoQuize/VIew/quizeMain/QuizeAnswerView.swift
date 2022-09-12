//
//  QuizeAnswerView.swift
//  CryptoQuize
//
//  Created by 中出翔也 on 2022/09/03.
//

import SwiftUI

struct QuizeAnswerView: View {
    @Environment(\.presentationMode) var presentationMode
    private var isCorrect: Bool
    private var correctAnswer: String
    var onNext: () -> Void
    
    init( _ isCorrect: Bool, _ correctAnswer: String, onNext: @escaping () -> Void){
        self.isCorrect = isCorrect
        self.correctAnswer = correctAnswer
        self.onNext = onNext
    }
    
    var body: some View {
        VStack{
            QuizeAnswerHeader(isCorrect,correctAnswer)
            QuizeAnswerDescription()
            HStack {
                    Spacer()
                    Button {
                        // todo
                        onNext()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("次へ→")
                    }
            }.padding()
        }
    }
}

struct QuizeAnswerHeader: View {
    private var isCorrect: Bool
    private var correctAnswer: String
    
    init(_ isCorrect: Bool, _ correctAnswer: String) {
        self.isCorrect = isCorrect
        self.correctAnswer = correctAnswer
    }
    
    var body: some View {
        VStack {
        if isCorrect {
            HStack{
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .leading)
                Text("正解!")
                    .font(.system(size: 50))
            }.foregroundColor(.blue)
        } else {
            HStack{
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 45, height: 45, alignment: .leading)
                Text("残念!")
                    .font(.system(size: 50))
            }.foregroundColor(.red)
        }
            HStack{
                Text("解答: \(correctAnswer)")
                    .fontWeight(.bold)
            }
        }
    }
}

struct QuizeAnswerDescription: View {
    var body: some View {
        VStack{
            Text("最初にビットコインの原案を考えたのは　サトシナカモト　という人物なんだよ！")
                .padding()
        }.frame(maxWidth: .infinity, maxHeight: 200, alignment: .leading)
            .background(Color.brown)
            .cornerRadius(20)
            .padding()
        
    }
}

struct QuizeAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        QuizeAnswerView(true, "answer", onNext: {})
    }
}
