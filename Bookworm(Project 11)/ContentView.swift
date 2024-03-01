//
//  ContentView.swift
//  Bookworm(Project 11)
//
//  Created by mac on 17.04.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults <Book>
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
   }
    @State private var ShowAddScreen = false
    var body: some View {
        NavigationView {
                    List{
                        ForEach(books){ book in
                            NavigationLink {
                                DetailView(book:book)
                            } label: {
                                HStack{
                                    EmojiRatingView(rating: book.rating)
                                        .font(.largeTitle)
                                    
                                    VStack(alignment: .leading){
                                        Text(book.title ?? "Uknown title")
                                            .font(.headline)
                                            .foregroundStyle(book.rating == 1 ? .red : .primary)
                                        
                                        Text(book.author ?? "Uknown author")
                                            .foregroundColor(.secondary)
                                    }.opacity(book.rating == 1 ? 0.5 : 1)
                                }
                            }
                        }.onDelete(perform: deleteBooks)
                    
            }.background(Color("Color"))
                .scrollContentBackground(.hidden)
               .navigationTitle("BookWorm")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton().foregroundStyle(.white)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            ShowAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus").foregroundStyle(.white)
                        }
                    }
                }

                .sheet(isPresented: $ShowAddScreen){
                    AddBookView()
                }
            
        }
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
            
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
