//
//  UpdateTodo.swift
//  ToDoHomework#2
//
//  Created by AlDanah Aldohayan on 07/11/2021.
//

import SwiftUI

struct UpdateTodo: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    
    let todoie: ToDoie?
    @State var title: String = ""
    @State var notes: String = ""
    @State var favourite: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    init(todoie: ToDoie? = nil){
        self.todoie = todoie
        _title = State(initialValue: todoie?.title ?? "")
        _notes = State(initialValue: todoie?.notes ?? "")
        _favourite = State(initialValue: todoie?.favourite ?? false)
    }
    var body: some View {
        NavigationView{
            VStack{
                TextField("Update Title", text: $title).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Update Note", text:  $notes).textFieldStyle(RoundedBorderTextFieldStyle())
                Toggle(isOn: $favourite) {}.labelsHidden().colorInvert()
                
                Spacer()
                Button("Update"){
                    do{
                        if let todoie = todoie {
                            todoie.title = title
                            todoie.notes = notes
                            todoie.favourite = favourite
                            try viewContext.save()
                        }
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        
                    }
                }
                .buttonStyle(GrowingButton())
            }
        }.preferredColorScheme(.dark)
        
    }
}

struct UpdateTodo_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTodo()
    }
}
