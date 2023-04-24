//
//  RatingButton.swift
//  
//
//
//

import SwiftUI

struct RatingView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: RatingViewModel
    
    var body: some View {
        
        ZStack {
    
            ScrollView {
                
                VStack {
                
                    textFieldView
                                        
                    flavorTapView
                    
                    starRatingTapView
                    
                    selectImageView
                    
                    saveButtonView
                    
                    cancelButtonView
                }
            }
    

        }.background(Color.primaryColor)
        
    }
    
    
    private var textFieldView: some View {
        VStack {
            TextField("Name", text: $viewModel.textFieldName )
                .neumorphicStyleTextField()
                .padding([.horizontal],16)
                .padding([.bottom],14)

            TextField("Straße", text: $viewModel.textFieldAdress.street)
                .neumorphicStyleTextField()
                .padding([.horizontal],16)
                .padding([.bottom],14)

            
            TextField("Kommentar", text: $viewModel.textFieldComment )
                .neumorphicStyleTextField()
                .padding([.horizontal],16)
                .padding([.bottom],14)
            
        }.padding([.bottom],16)
    }
    
    private var flavorTapView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.flavors, id: \.id) { flavor in
                
                    Button(action: {
                        viewModel.onFlavorButtonTapped(flavor: flavor)
                    }) {
                        if flavor.flavorState == .marked {
                            flavor.image
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 25.0
                                    ),
                                    style: FillStyle()
                                )
                                .modifier(RoundedEdge())
                            
                        } else if flavor.flavorState == .notMarked {
                            flavor.image
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0), style: FillStyle())
                        }
                    }
                }
            }
        }
        .emptyNeumorphicStyleElement()
        .padding([.horizontal],16)
    }
    
    private var starRatingTapView: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image.starRatingIcon(index: index, rating: viewModel.currentRating ?? 0)
                    .foregroundColor(Color.orange)
                    .onTapGesture {
                        viewModel.onRatingItemTapped(rating: index)
                    }
            }
        }.emptyNeumorphicStyleElement()
            .padding()
    }
    
    private var selectImageView: some View {
        HStack {
            HStack {
                Button(action: {viewModel.showSheet = true }) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.largeTitle)
                        .foregroundColor(Color.gray)
                        .padding(.leading, 150)
                }.padding()
                    .actionSheet(isPresented: $viewModel.showSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.viewModel.showImagePicker = true
                                self.viewModel.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.viewModel.showImagePicker = true
                                self.viewModel.sourceType = .camera
                            },
                            .cancel()
                        ])
                    }
                    .sheet(isPresented: $viewModel.showImagePicker) {
ImagePickerView(sourceType: self.viewModel.sourceType, selectedImage: self.$viewModel.selectedImage, isShown: self.$viewModel.showImagePicker)
                    }
            }

        }.emptyNeumorphicStyleElement()
            .padding([.horizontal],16)
            .overlay(imagePreview.padding(.trailing, 150))
    }
    
    private var saveButtonView: some View {
        Button {
            Task {
                await viewModel.onSaveButtonTapped()
                self.presentationMode.wrappedValue.dismiss()
            }
        } label: {
            Text("Bewertung abgeben")
        }.buttonStyle(SaveButtonTappedStyle())
            .padding()
    }
    
    private var cancelButtonView: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("abbrechen")
                .foregroundColor(Color.gray)
        }
    }
    
    private var imagePreview: some View {
        
        Image(uiImage: viewModel.selectedImage)
            .resizable()
            .cornerRadius(50)
            .frame(width: 80, height: 80)
            .background(Color.black.opacity(0.2))
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .scaledToFit()
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        
        RatingView(viewModel: RatingViewModel())
    }
}
