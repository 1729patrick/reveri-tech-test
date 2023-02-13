//
//  AnimatedCounterView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI


struct AnimatedCounterView: View {
    class CounterTimer {
        @State private var impactFeedback = UIImpactFeedbackGenerator(style: .light)
        
        var onFire: () -> Void
        var timer: Timer!
        
        init(_ onFire: @escaping ()-> Void){
            self.onFire = onFire;
            
            self.startTimer()
        }
        
        func startTimer() {
            self.timer = Timer.scheduledTimer(
                timeInterval: 2.5,
                target: self,
                selector: #selector(fireTimer),
                userInfo: nil,
                repeats: false)
        }
        
        func stopTimer() {
            self.timer?.invalidate()
        }
        
        func restartTimer() {
            self.stopTimer()
            self.startTimer()
        }
        
        @objc private func fireTimer() {
            onFire()
        }
    }
    
    @State private var impactFeedback = UIImpactFeedbackGenerator(style: .light)
    
    @State var editing: Bool = false
    @State var timer: CounterTimer?
    
    @Binding var amount: Int
    
    var lowerBound: Int? = .zero
    var upperBound: Int?
    
    var body: some View {
        HStack {
            if editing {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 20, height: 20)
                    .onTapGesture {  decrease() }
                    .overlay(
                        Image(systemName: "minus")
                            .imageScale(.small)
                            .foregroundColor(.white)
                    )
                    .transition(
                        .asymmetric(
                            insertion: .scale,
                            removal: .identity
                        )
                    )
            }
            
            Button {
                toggleEditing()
            } label: {
                Text(String(amount))
                    .frame(minWidth: 20)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.plain)
            
            if editing {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 20, height: 20)
                    .onTapGesture {  increase() }
                    .overlay(
                        Image(systemName: "plus")
                            .imageScale(.small)
                            .foregroundColor(.white)
                    )
                    .transition(
                        .asymmetric(
                            insertion: .scale,
                            removal: .identity
                        )
                    )
            }
        }
        .padding(.horizontal, editing ? 10 : 16)
        .padding(.vertical, 6)
        .background(Color.accentColor.opacity(editing ? 0.2 : 0))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.accentColor, lineWidth: 1)
        )
    }
    
    func toggleEditing() {
        guard editing == false else {
            return
        }
        
        timer = CounterTimer(fireTimer)
        
        withAnimation(.linear(duration: 0.15)) {
            editing = true
        }
    }
    
    func decrease() {
        impactFeedback.impactOccurred()
        
        timer?.restartTimer()
        
        if let limit = lowerBound {
            guard amount > limit else {
                return
            }
        }
        
        impactFeedback.impactOccurred()
        amount -= 1
    }
    
    func increase() {
        impactFeedback.impactOccurred()
        timer?.restartTimer()
        
        if let limit = upperBound {
            guard amount < limit else {
                return
            }
        }
        
        
        impactFeedback.impactOccurred()
        amount += 1
    }
    
    func fireTimer() {
        withAnimation(.linear(duration: 0.2)) {
            editing = false
        }
    }
}

struct AnimatedCounterView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCounterView(amount: .constant(0))
    }
}
