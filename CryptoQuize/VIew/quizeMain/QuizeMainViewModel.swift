//
//  QuizeMainViewModel.swift
//  CryptoQuize
//
//  Created by 中出翔也 on 2022/09/11.
//

import Foundation
import SwiftUI

class QuizeMainViewModel: ObservableObject{
    var quizes:[QuizeModel] = []
    @Published var currentQuize:QuizeModel = QuizeModel("","",[])
    @Published var currentQuizeIndex = 0
    @Published var hitPoint = 3
    @Published var isGameOver = false
    
    init () {
        fetchQuize()
        currentQuize = quizes.first ?? QuizeModel("クイズを正常に読み込めませんでした。","",[])
    }
    
    func onNextQuestion() {
        self.currentQuizeIndex += 1
        guard quizes.indices.contains(currentQuizeIndex) else { return }
        currentQuize = quizes[currentQuizeIndex]
    }
    
    func fetchQuize() {
        // todo
//        let answerCandidates1 = ["小野小町","聖徳太子","卑弥呼","サトシ"]
//        let quize1:QuizeModel = QuizeModel("仮想通貨の考えをはじめに考えた人は？","サトシ", answerCandidates1)
//
//        let answerCandidates2 = ["GST","GMT","SOL","BNB"]
//        let quize2:QuizeModel = QuizeModel("ガバナンストークンではないものは？","GST", answerCandidates2)
//
//        self.quizes = [quize1, quize2,quize1,quize2]

        guard let url = Bundle.main.url(forResource: "QuizeData", withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
        print("***** JSONデータ確認 *****")
        print(String(bytes: data, encoding: .utf8)!)
        let decoder = JSONDecoder()
        do {
        quizes = try decoder.decode([QuizeModel].self, from: data)
        } catch {
            fatalError("JSON読み込みエラー")
        }
    }
    
    func judgeAnswer(answer:String) -> Bool {
        if answer != currentQuize.answer {
            hitPoint -= 1
            if hitPoint == 0 {
                isGameOver = true
            }
        }
        return answer == currentQuize.answer
    }

}
