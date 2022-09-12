//
//  QuizeModel.swift
//  CryptoQuize
//
//  Created by 中出翔也 on 2022/09/11.
//

import Foundation

struct QuizeModel:Codable {
    var level:Int = 0
    var no: Int = 0
    var question:String
    var answer: String
    var answerCandidates: [String]
    
    init( _ question: String, _ answer: String, _ answerCandidates:[String]) {
        self.question = question
        self.answer = answer
        self.answerCandidates = answerCandidates
    }
    
}
        
