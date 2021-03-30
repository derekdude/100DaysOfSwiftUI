//
//  DetailView.swift
//  Bookworm
//
//  Created by Derek Santolo on 1/27/21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader
        { geometry in
            VStack
            {
                ZStack(alignment: .bottomTrailing)
                {
                    Color.black
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: geometry.size.width, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 210, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Image(self.book.genre ?? "Unknown")
                        .frame(maxWidth: geometry.size.width)
                    
                    HStack(alignment: .bottom)
                    {
                        Text(getBookDateString(book: book))
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.75))
                            .clipShape(Capsule())
                            .offset(x: 0, y: -5)
                        
                        Spacer()
                        
                        Text(self.book.genre?.uppercased() ?? "UNKNOWN")
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(8)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.75))
                            .clipShape(Capsule())
                            .offset(x: -5, y: -5)
                    }
                    
                    
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
            .navigationBarTitle(Text(book.title ?? "Unknown book"), displayMode: .inline)
            .alert(isPresented: $showingDeleteAlert) {
                Alert(title: Text("Delete Book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                }, secondaryButton: .cancel())
            }
            .navigationBarItems(trailing: Button(action: {
                self.showingDeleteAlert = true
            }) {
                Image(systemName: "trash")
            })
        }
    }
    
    func getBookDateString(book: Book) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: book.date ?? Date())
    }
    
    func deleteBook()
    {
        moc.delete(book)
        
        //try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Unknown"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView
        {
            DetailView(book: book)
        }
    }
}
