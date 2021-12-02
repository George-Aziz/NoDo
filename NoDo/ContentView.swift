// Author: George Aziz
// Date last modified: 02/12/2021
// Purpose: A Simple NoDo (Opposite of a ToDo) application to list all the things that you do not want to do
 

import SwiftUI

//Main View of the NoDo List screen
struct ContentView: View {
    @State var noDoItem: String = "" //The content of the textfield once committed
    @State var noDoItems = [String]()
    
    var body: some View {
        NavigationView{
            VStack {
                HStack(spacing: 5) {
                    Image(systemName: "plus.circle").padding(.leading)
                    Group {
                        
                        //TextField for the top box to input items into the list
                        TextField("What will you NOT do today?",
                                  text: self.$noDoItem,
                                  onEditingChanged: { (changed) in print(changed) },
                                  onCommit: {
                                    self.noDoItems.insert(self.noDoItem, at: 0)
                        }).padding(.all, 12)
                        
                    }.background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(radius: 5).padding(.trailing, 8)
                }
                
                //Creates a list of all the items in the current array
                List(self.noDoItems, id: \.self) { item in
                    NoDoRow(noDoItem: noDoItem)
                }
                
            }.navigationBarTitle (Text ("NoDo"))
        }
    }
}

struct NoDoRow: View {
    @State var noDoItem: String = ""
    @State var isComplete: Bool = false
    var dateObj: Date = Date()
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Group {
                
                //First Line of the row
                HStack {
                    Text(noDoItem)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.leading, 5)
                    
                    Spacer()
                    Image(systemName: (self.isComplete) ? "checkmark" : "square").padding()
                }
                
                //Second line of the row
                HStack(alignment: .center, spacing: 3) {
                    Spacer()
                    
                    Text(dateObj.timeAgo(numericDates:false)).foregroundColor(.white).italic().padding(.all, 5)
                }.padding(.trailing, 15).padding(.bottom, 5)
                
            }.padding(.all, 5)
            
        }.background((self.isComplete) ? .black : .red)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .onTapGesture { isComplete.toggle() }
        .opacity((self.isComplete) ? 0.3 : 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Function obtained from : https://gist.github.com/minorbug/468790060810e0d29545
extension Date {
    func timeAgo(numericDates: Bool) -> String {
        let calendar = Calendar.current
        let now = Date()
        let earliest = self < now ? self : now
        let latest =  self > now ? self : now

        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfMonth, .month, .year, .second]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)

        let year = components.year ?? 0
        let month = components.month ?? 0
        let weekOfMonth = components.weekOfMonth ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0

        switch (year, month, weekOfMonth, day, hour, minute, second) {
            case (let year, _, _, _, _, _, _) where year >= 2: return "\(year) years ago"
            case (let year, _, _, _, _, _, _) where year == 1 && numericDates: return "1 year ago"
            case (let year, _, _, _, _, _, _) where year == 1 && !numericDates: return "Last year"
            case (_, let month, _, _, _, _, _) where month >= 2: return "\(month) months ago"
            case (_, let month, _, _, _, _, _) where month == 1 && numericDates: return "1 month ago"
            case (_, let month, _, _, _, _, _) where month == 1 && !numericDates: return "Last month"
            case (_, _, let weekOfMonth, _, _, _, _) where weekOfMonth >= 2: return "\(weekOfMonth) weeks ago"
            case (_, _, let weekOfMonth, _, _, _, _) where weekOfMonth == 1 && numericDates: return "1 week ago"
            case (_, _, let weekOfMonth, _, _, _, _) where weekOfMonth == 1 && !numericDates: return "Last week"
            case (_, _, _, let day, _, _, _) where day >= 2: return "\(day) days ago"
            case (_, _, _, let day, _, _, _) where day == 1 && numericDates: return "1 day ago"
            case (_, _, _, let day, _, _, _) where day == 1 && !numericDates: return "Yesterday"
            case (_, _, _, _, let hour, _, _) where hour >= 2: return "\(hour) hours ago"
            case (_, _, _, _, let hour, _, _) where hour == 1 && numericDates: return "1 hour ago"
            case (_, _, _, _, let hour, _, _) where hour == 1 && !numericDates: return "An hour ago"
            case (_, _, _, _, _, let minute, _) where minute >= 2: return "\(minute) minutes ago"
            case (_, _, _, _, _, let minute, _) where minute == 1 && numericDates: return "1 minute ago"
            case (_, _, _, _, _, let minute, _) where minute == 1 && !numericDates: return "A minute ago"
            case (_, _, _, _, _, _, let second) where second >= 3: return "\(second) seconds ago"
            default: return "Just now"
        }
    }
}
