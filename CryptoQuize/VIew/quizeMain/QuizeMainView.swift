//
//  QuizeMainView.swift
//  CryptoQuize
//
//  Created by 中出翔也 on 2022/09/03.
//

import SwiftUI

struct QuizeMainView: View {
    @State private var isSheetShow: Bool = false
    @State private var isAnswered: Bool = false
    @State private var isCorrect: Bool = false
    @ObservedObject var viewModel = QuizeMainViewModel()
    
    var body: some View {
        VStack {
        if viewModel.isGameOver {
            Text("GAME\nOVER!")
                .foregroundColor(.red)
                .font(.title)
        } else if viewModel.currentQuizeIndex == 10 {
            Text("おめでとう！！！")
                .foregroundColor(.blue)
                .font(.title)
        } else {
            VStack {
                QuestionHeader(viewModel.currentQuizeIndex+1,$viewModel.hitPoint)
                QuestionCard(viewModel.currentQuize.question)
                ForEach(0..<viewModel.currentQuize.answerCandidates.count) { index in
                    AnswerCard(index,
                            viewModel.currentQuize.answerCandidates[index]
                    ) { answer in
                        isCorrect = viewModel.judgeAnswer(answer: answer)
                        isAnswered = true
                        isSheetShow.toggle()
                    }
                }
                
                HStack {
                    if isAnswered {
                        Spacer()
                        Button {
                            // todo
                            viewModel.onNextQuestion()
                            isAnswered = false
                        } label: {
                            Text("次へ→")
                        }
                    }
                }.padding()
            }.frame(maxWidth: .infinity)
        }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isSheetShow) {
            QuizeAnswerView(isCorrect,viewModel.currentQuize.answer){
                viewModel.onNextQuestion()
                isAnswered = false
            }
        }
    }
}

struct QuestionCard: View {
    let questionTitle:String
    init( _ questionTitle: String) {
        self.questionTitle = questionTitle
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Q.")
                    .foregroundColor(.orange)
                Text(questionTitle)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
            .border(.orange, width: 4)
            .cornerRadius(5)
        }
        .padding()
    }
}

struct AnswerCard: View {
    var onJudge: (String) -> Void
    private var answerIndex:Int
    private var answerCandidate: String
    
    init(_ answerIndex:Int, _ answerCandidate:String,
         onJudge: @escaping (String) -> Void) {
        self.answerIndex = answerIndex
        self.answerCandidate = answerCandidate
        self.onJudge = onJudge
    }
    
    var body: some View {
        VStack {
            Button {
                onJudge(answerCandidate)
            } label: {
                HStack(){
                    Text("\(answerIndex+1).")
                        .foregroundColor(.white)
                        .padding()
                    Text(answerCandidate)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
    }
}

struct QuestionHeader: View {
    private var currentIndex: Int = 1
    @Binding var hitPoint: Int
    
    init(_ index:Int, _ hitPoint:Binding<Int>) {
        currentIndex = index
        self._hitPoint = hitPoint
    }
    var body: some View {
        VStack {
            HStack{
                Text("\(currentIndex)/10")
                    .foregroundColor(.orange)
                Spacer()
                LifeView($hitPoint)
            }
            .padding()
        }
    }
}

struct LifeView: View {
    @Binding var hitPoint: Int
    
    init(_ hitPoint:Binding<Int>) {
        self._hitPoint = hitPoint
    }
    
    var body: some View {
        HStack{
            ForEach(0..<hitPoint, id: \.self){ _ in
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
            ForEach(0..<(3 - hitPoint), id: \.self){ _ in
                Image(systemName: "heart")
            }
        }
    }
}


struct QuizeMainView_Previews: PreviewProvider {
    static var previews: some View {
        QuizeMainView()
    }
}
