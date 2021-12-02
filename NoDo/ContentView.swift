// Author: George Aziz
// Date last modified: 02/12/2021
// Purpose: A Simple NoDo (Opposite of a ToDo) application to list all the things that you do not want to do
 

import SwiftUI

//Main View of the NoDo List screen
struct ContentView: View {
    @State var nodo: String = "" //The content of the textfield once committed
    var body: some View {
        NavigationView{
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "plus.circle").padding(.leading)
                    Group {
                        
                        TextField("What do you NOT want to do today?",
                                  text: self.$nodo,
                                  onEditingChanged: { (changed) in print(changed) },
                                  onCommit: { print("onCommit")}
                        ).padding(.all, 12)
                        
                    }.background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(radius: 5).padding(.trailing, 8)
                }
            }.navigationBarTitle (Text ("NoDo"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
