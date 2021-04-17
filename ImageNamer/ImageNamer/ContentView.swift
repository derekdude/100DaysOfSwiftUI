//
//  ContentView.swift
//  ImageNamer
//
//  Created by Derek Santolo on 4/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var newImageName = ""
    
    @State private var showingImagePicker = false
    @State private var showingImageNamer = false
    
    @State private var inputImage: UIImage?
    @State private var pictures: [Picture] = []

    var body: some View {
        NavigationView
        {
            VStack
            {
                List
                {
                    ForEach(pictures, id: \.self)
                    { picture in
                        Text("\(picture.id)")
                            .sheet(isPresented: $showingImageNamer, onDismiss: appendNewPicture(newID: newImageName, newImage: image!)) {
                                VStack
                                {
                                    Text("Please name this image: ")
                                    TextField("Image name", text: $newImageName)
                                }
                            }
                    }
                }
                .navigationBarTitle("ImageNamer")
            }
            .navigationBarItems(trailing: Button(action: {
                print("Button pressed")
                self.showingImagePicker = true })
            {
                Image(systemName: "plus")
            })
        }
        .padding([.horizontal, .bottom])
        .sheet(isPresented: $showingImagePicker,
               onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        self.showingImageNamer = true
    }
    
    func appendNewPicture(newID: String, newImage: Image) {
        var newPicture = Picture(inID: newID, inImage: newImage)
        pictures.append(newPicture)
    }
}

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(pictures: [])
    }
}*/
