//
//  ContentView.swift
//  Instafilter
//
//  Created by Derek Santolo on 3/27/21.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    
    
    @State private var showingNilImageAlert = false
    @State private var showingFilterSheet = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State var currentFilterTitle: String = "Sepia Tone"
    let context = CIContext()
    
    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        let radius = Binding<Double>(
            get: {
                self.filterRadius
            },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
            }
        )
        
        return NavigationView
        {
            VStack
            {
                ZStack
                {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                    
                }
                VStack
                {
                    HStack
                    {
                        Text("Intensity")
                        Slider(value: intensity)
                    }.padding(.vertical)
                    
                    if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                        HStack
                        {
                            Text("Radius")
                            Slider(value: radius)
                        }.padding(.vertical)
                    }
                }
                
                HStack
                {
                    Button("\(currentFilterTitle)")
                    {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save")
                    {
                        if image == nil { showingNilImageAlert = true }
                        guard let processedImage = self.processedImage else { return }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Success")
                        }
                        
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                    .alert(isPresented: $showingNilImageAlert) {
                        Alert(title: Text("No Image Selected"), message: Text("Please select an image to save it to your library."),
                                                                            dismissButton: .default(Text("OK")))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker,
                   onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize(), "Crystallize") },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges(), "Edges") },
                    .default(Text("Bokeh Blur")) { self.setFilter(CIFilter.bokehBlur(), "Bokeh Blur") },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate(), "Pixellate") },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone(), "Sepia Tone") },
                    .default(Text("Unsharp Mask")) {
                        self.setFilter(CIFilter.unsharpMask(), "Unsharp Mask") },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette(), "Vignette") },
                    .default(Text("Comic Effect")) {
                        self.setFilter(CIFilter.comicEffect(), "Comic Effect") },
                    .cancel()
                ])
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey:
                               kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        guard let outputImage = currentFilter.outputImage
            else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter, _ filterTitle: String) {
        currentFilter = filter
        currentFilterTitle = filterTitle
        loadImage()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
