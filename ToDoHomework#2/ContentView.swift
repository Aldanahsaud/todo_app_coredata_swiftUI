//
//  ContentView.swift
//  ToDoHomework#2
//
//  Created by AlDanah Aldohayan on 07/11/2021.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: ToDoie.entity(), sortDescriptors: [NSSortDescriptor(key: "timeStamp", ascending: false)], animation: .default)
    
    private var myToDoie: FetchedResults<ToDoie>
    
    @State var title: String = ""
    @State var notes: String = ""
    @State var favourite: Bool = false
    @State var timeStamp = Date()
    var body: some View {
        NavigationView{
            TabView{
            ZStack(alignment: .top){
                VStack(spacing: 20){
                    TextField("Title", text: $title ).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Note", text: $notes ).textFieldStyle(RoundedBorderTextFieldStyle())
                    Toggle(isOn: $favourite) {}.labelsHidden().colorInvert()
                    
                    
                    Spacer()
                    Button("Add"){
                        do{
                            let todoie = ToDoie(context: viewContext)
                            todoie.title = title
                            todoie.notes = notes
                            todoie.timeStamp = Date()
                            todoie.favourite = favourite
                            try viewContext.save()
                            title = ""
                            notes = ""
                            favourite = false
                        } catch {
                            
                        }
                    }
                    .buttonStyle(GrowingButton())
                }
                .navigationTitle("To-Do")
                .padding(.horizontal)
            }
            
            .tabItem{
                Label("Add", systemImage: "plus.square")
            }
            
            
            ZStack(alignment: .top){
                VStack{
                    List{
                        if myToDoie.isEmpty{
                            Text("oh oh... Tasks are Empty right now add some :)")
                        } else{
                            ForEach(myToDoie){ todoie in
                                NavigationLink(destination: {
                                    UpdateTodo(todoie: todoie)
                                }, label: {
                                    HStack{
                                        HStack{
                                            Text(todoie.title ?? "")
                                                .font(.system(size: 22, weight: .heavy, design: .default))
                                            Text(":")
                                            Text(todoie.notes ?? "").font(.system(size: 10, weight: .heavy, design: .default))
                                        }
                                        Spacer()
                                        Button{
                                            todoie.favourite = !todoie.favourite
                                            do {
                                                try viewContext.save()
                                            } catch {
                                                
                                            }
                                        } label: {
                                            Image(systemName: todoie.favourite ? "star.fill" : "star")
                                        }.buttonStyle(.borderless)
                                        
                                        
                                    }
                                })
                                    .swipeActions(edge: .leading,
                                                  allowsFullSwipe: true,
                                                  content: {
                                        Button(role: .destructive, action: {
                                            if let deletedTodoie = myToDoie.firstIndex(of: todoie){
                                                viewContext.delete(myToDoie[deletedTodoie])
                                                do {
                                                    try viewContext.save()
                                                } catch {
                                                    
                                                }
                                            }
                                        }, label: {Image(systemName: "trash")}
                                               
                                        )})
                            }
                        }
                    }
                }
            }
            .tabItem{
                Label("Tasks", systemImage: "list.bullet")
            }
            
        }
        .preferredColorScheme(.dark)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer = CoreDataManagerr.shared.persistantContainer
        ContentView()
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}



// button styling struct ;p
struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
