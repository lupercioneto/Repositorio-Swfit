//
//  ListaDeTasks.swift
//  ListaDeTarefas
//
//  Created by user on 21/08/24.
//

import SwiftUI

struct Task: Identifiable, Codable {
    var id = UUID()
    let title: String
    let description: String
    var ready: Bool = false
}


import SwiftUI

struct ListaDeTask: View {
    @State private var tasks: [Task] = JSONCoder.shared.read()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(tasks.indices, id: \.self) { index in
                        NavigationLink(destination: DetalhesTask(task: $tasks[index])) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(tasks[index].title)
                                        .font(.headline)
                                    Text(tasks[index].description)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                if tasks[index].ready {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationTitle("Lista de Tarefas")
                .onAppear {
                    tasks = JSONCoder.shared.read()
                }
            }
        }
    }
        

    // Função para deletar a tarefa
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        JSONCoder.shared.write(tarefas: tasks)
    }
}

struct ListaDeTask_Previews: PreviewProvider {
    static var previews: some View {
        ListaDeTask()
    }
}



