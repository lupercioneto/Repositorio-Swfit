//
//  TelaInicial.swift
//  ListaDeTarefas
//
//  Created by user on 21/08/24.
//

import SwiftUI

struct TelaInicial: View {
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Image(systemName: "pencil.and.list.clipboard")
                        .font(.system(size: 30))
                        .padding()
                    
                    Spacer()
                    
                    Image(systemName: "pencil.and.ellipsis.rectangle")
                        .font(.system(size: 30))
                        
                        .padding()
                    
                    Spacer()
                    
                    Image(systemName: "suitcase")
                        .font(.system(size: 30))
                        
                        .padding()
                }
                Spacer()
                
                VStack(spacing: 40) {
                    Text("Bem-vindo ao")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    
                    Text("Work Arrange!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, -35)
                        .foregroundStyle(Color(hue: 0.6, saturation: 0.7, brightness: 0.8))
                    
                    Text("Organize suas tarefas de forma eficiente!")
                        .font(.subheadline)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .padding([.bottom], 20)
                    
                    NavigationLink(destination: ListaDeTask()) {
                        Text("Ver Lista de Tarefas")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: AdicionarTask()) {
                        Text("Adicionar Nova Tarefa")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                
                
                Spacer()
            }
        }
    }
}

struct TelaInicial_Previews: PreviewProvider {
    static var previews: some View {
        TelaInicial()
    }
}


