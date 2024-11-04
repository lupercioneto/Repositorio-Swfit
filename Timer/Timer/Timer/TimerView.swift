//
//  TimerView.swift
//  Timer
//
//  Created by user on 04/11/24.
//

import SwiftUI

struct TimerView: View {
    @StateObject private var timerModel = TimerModel()
    @State private var selectedHours: Int = 0
    @State private var selectedMinutes: Int = 0
    @State private var selectedSeconds: Int = 0
    
    // Estado para animações de botão
    @State private var isPressed = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                

                Circle()
                    .trim(from: 0, to: CGFloat(timerModel.timeRemaining) / CGFloat(timerModel.totalTime))
                    .stroke(timerColor(), lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 0.1), value: timerModel.timeRemaining)
                    .frame(width: 270, height: 270)

                Text(timerModel.timeString)
                    .font(.system(size: 48)) // Aumenta o tamanho do texto
                    .foregroundColor(.white)
                    .padding(.bottom, 20) // Adiciona espaço abaixo do texto

                HStack {
                    Picker("Horas", selection: $selectedHours) {
                        ForEach(0..<24) { hour in
                            Text("\(hour)").tag(hour)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)

                    Picker("Minutos", selection: $selectedMinutes) {
                        ForEach(0..<60) { minute in
                            Text("\(minute)").tag(minute)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)

                    Picker("Segundos", selection: $selectedSeconds) {
                        ForEach(0..<60) { second in
                            Text("\(second)").tag(second)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 80)
                }
                .padding()

                HStack {
                    Button(action: {
                        let totalTime = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
                        timerModel.setTime(time: totalTime)
                    }) {
                        Text("Definir Tempo")
                            .padding()
                            .background(isPressed ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.easeInOut, value: isPressed)
                    }
                    .simultaneousGesture(DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isPressed = true
                        }
                        .onEnded { _ in
                            isPressed = false
                        })

                    Button(action: {
                        timerModel.startTimer()
                    }) {
                        Text("Iniciar")
                            .padding()
                            .background(isPressed ? Color.gray : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.easeInOut, value: isPressed)
                    }
                    .simultaneousGesture(DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isPressed = true
                        }
                        .onEnded { _ in
                            isPressed = false
                        })

                    Button(action: {
                        timerModel.stopTimer()
                    }) {
                        Text("Parar")
                            .padding()
                            .background(isPressed ? Color.gray : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .scaleEffect(isPressed ? 0.95 : 1.0)
                            .animation(.easeInOut, value: isPressed)
                    }
                    .simultaneousGesture(DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            isPressed = true
                        }
                        .onEnded { _ in
                            isPressed = false
                        })
                }
            }
        }
        .padding()
    }

    // Função para determinar a cor do círculo
    private func timerColor() -> Color {
        if timerModel.timeRemaining <= 10 {
            return Color.red
        } else if timerModel.timeRemaining <= timerModel.totalTime / 2 {
            return Color.orange
        } else {
            return Color.blue
        }
    }
}

