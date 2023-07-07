//
//  HomeGameView.swift
//  learning-game
//
//  Created by Vandit Jindal on 7/6/23.
//

import SwiftUI

struct Question {
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
}

struct HomeGameView: View {
    let questions: [Question] = [
        Question(question: "What is the house number?", options: ["1234", "5678", "9101", "1213"], correctAnswerIndex: 0),
        Question(question: "What is the street name?", options: ["Home", "Street", "Avenue", "Lane"], correctAnswerIndex: 0),
        Question(question: "What is the street type?", options: ["Dr", "Rd", "St", "Ave"], correctAnswerIndex: 0),
        Question(question: "What is the city?", options: ["Frisco", "Dallas", "Plano", "Austin"], correctAnswerIndex: 0),
        Question(question: "What is the state?", options: ["TX", "CA", "NY", "FL"], correctAnswerIndex: 0),
        Question(question: "What is the ZIP code?", options: ["54321", "12345", "98765", "67890"], correctAnswerIndex: 0)
    ]
    
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                .font(.headline)
                .padding()
            
            Text(questions[currentQuestionIndex].question)
                .font(.title)
                .padding()
            
            ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                Button(action: {
                    checkAnswer(index)
                }) {
                    Text(questions[currentQuestionIndex].options[index])
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            
            Text("Score: \(score)")
                .font(.headline)
                .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Result"),
                message: Text("Your score is \(score) out of \(questions.count)"),
                dismissButton: .default(Text("OK")) {
                    resetGame()
                }
            )
        }
    }
    
    func checkAnswer(_ selectedAnswerIndex: Int) {
        if selectedAnswerIndex == questions[currentQuestionIndex].correctAnswerIndex {
            score += 1
        }
        
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        } else {
            showAlert = true
        }
    }
    
    func resetGame() {
        currentQuestionIndex = 0
        score = 0
    }
}

struct HomeGameView_Previews: PreviewProvider {
    static var previews: some View {
        HomeGameView()
    }
}
