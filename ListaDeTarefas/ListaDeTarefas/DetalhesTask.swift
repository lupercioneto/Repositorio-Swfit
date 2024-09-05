//
//  DetalhesTask.swift
//  ListaDeTarefas
//
//  Created by user on 21/08/24.
//

import SwiftUI

struct DetalhesTask: View {
    @Binding var task: Task
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(task.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text(task.description)
                .font(.body)
                .padding(.bottom)

            HStack {
                Spacer()
                Button(action: {
                    task.ready.toggle()
                    var tasks = JSONCoder.shared.read()
                    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                        tasks[index].ready = task.ready
                        JSONCoder.shared.write(tarefas: tasks)
                    }
                }) {
                    HStack {
                        Image(systemName: task.ready ? "checkmark.circle.fill" : "circle")
                        Text(task.ready ? "Concluído" : "Marcar como Concluído")
                    }
                    .padding()
                    .background(task.ready ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                Spacer()
            }
            
            Spacer()
        }
        .padding(20) // Padding ao redor de todo o conteúdo
        .navigationTitle("Detalhes da Tarefa")
        .navigationBarBackButtonHidden(true) // Esconder o botão de voltar padrão
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Voltar")
                    }
                }
            }
        }
    }
}

struct DetalhesTask_Previews: PreviewProvider {
    static var previews: some View {
        DetalhesTask(task: .constant(Task(title: "Exemplo", description: "Descrição de Exemplo")))
    }
}






