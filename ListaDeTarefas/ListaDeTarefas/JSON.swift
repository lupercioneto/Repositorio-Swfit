//
//  JSON.swift
//  ListaDeTarefas
//
//  Created by user on 28/08/24.
//

import Foundation

struct JSONCoder {
    static var shared = JSONCoder()
    let archivePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent("tasks.json")
    
    func read() -> [Task] {
        guard let data = try? Data(contentsOf: archivePath) else { return [] }
        guard let tarefas = try? JSONDecoder().decode([Task].self, from: data) else { return [] }
        return tarefas
    }
    
    func write(tarefas: [Task]) {
        guard let data = try? JSONEncoder().encode(tarefas) else { return }
        try? data.write(to: archivePath)
    }
}

