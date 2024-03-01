//
//  AddBookView.swift
//  Bookworm(Project 11)
//
//  Created by mac on 18.04.2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    init() {
     UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
   }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Book name", text:  $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }.onAppear{
                        genre = "Fantasy"
                    }
                    
                }
                
                Section{
                    TextField("Review", text: $review)
                    
                    RatingView(rating:$rating)
                } header: {
                    Text("Write a review")
                        .foregroundStyle(.white)
                }
                Section{
                    Button("Save"){
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.author = author
                        newBook.genre = genre
                        newBook.rating = Int16(rating)
                        newBook.review = review
                        newBook.title = title
                        newBook.date = Date.now
                        try? moc.save()
                        dismiss()
                    }.disabled(title.isEmpty || author.isEmpty)
                }
            }.background(Color("Color"))
                .scrollContentBackground(.hidden)
                .navigationTitle("Add Book")
        }
    }
}
struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
