//
//  DetailView.swift
//  Bookworm(Project 11)
//
//  Created by mac on 18.04.2023.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "")
                    .resizable().scaledToFit()
                Text(book.genre?.uppercased() ?? "")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Text(book.title ?? "")
                .font(.title)
                .foregroundColor(.white)
            Text(book.review ?? "")
            HStack{
                Spacer()
                Text(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "")
                    .italic()
                    .foregroundColor(.white)
            }
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            
        }.onAppear(){
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }.background(Color("Color"))
        .navigationTitle(book.author ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showDeleteAlert = true
            } label : {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    func deleteBook(){
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}


