//
//  AdicionarTask.swift
//  ListaDeTarefas
//
//  Created by user on 21/08/24.
//

import SwiftUI

struct AdicionarTask: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes da Tarefa")) {
                    TextField("Título", text: $title)
                    TextField("Descrição", text: $description)
                }

                Button(action: {
                    let novaTask = Task(title: title, description: description)
                    var tasks = JSONCoder.shared.read()
                    tasks.append(novaTask)
                    JSONCoder.shared.write(tarefas: tasks)
                    dismiss()
                }) {
                    Text("Adicionar Tarefa")
                }
                .disabled(title.isEmpty || description.isEmpty)
            }
            .navigationTitle("Adicionar Nova Tarefa")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AdicionarTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AdicionarTask()
    }
}


