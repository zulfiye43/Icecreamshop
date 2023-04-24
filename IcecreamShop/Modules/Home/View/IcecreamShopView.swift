//
//  RatingViewElements.swift
//  
//
//
//

import SwiftUI

struct IcecreamShopView: View {
    
    let icecreamShop: IcecreamShop
    @ObservedObject var icecreamShopViewModel = IcecreamShopViewModel()
    @ObservedObject var homeViewModel: HomeViewModel
    @State private var isDisclosed = false
    
    var body: some View {
        VStack {
            HStack {
                icecreamshopImage
                Text(icecreamShop.name).foregroundColor(Color.gray)
            }
            
            ScrollView {
                    HStack {
                        availableFlavors
                    }
                        VStack {
                            Text(icecreamShop.adress.street)
                                .foregroundColor(Color.gray)
                            Text(icecreamShop.comment)
                                .foregroundColor(Color.gray)
                            starRatingIcon
                        }          
               
            }
            .frame(maxHeight: isDisclosed ? nil : 0, alignment: .top)
            .clipped()
            
        }
        .rectangleElement()
        .onTapGesture {
            withAnimation(.spring()) {
                isDisclosed.toggle()
            }
        }
   
        
//        VStack {
//            ZStack {
//
//                VStack {
//                    if icecreamShopViewModel.isExtended {
//                        VStack {
//                            HStack {
//                                availableFlavors
//                                VStack {
//                                    Text(icecreamShop.adress.street)
//                                        .foregroundColor(Color.gray)
//                                    Text(icecreamShop.comment)
//                                        .foregroundColor(Color.gray)
//                                    starRatingIcon
//                                }
//                            }
//                        }
//                    }
//                }
//                .rectangleElement()
//                .offset(y: icecreamShopViewModel.isExtended ? 110 : 0)
//                .scaleEffect(icecreamShopViewModel.isExtended ? 1.2 : 1)
//
//
//                HStack {
//                    icecreamshopImage
//
//                    Text(icecreamShop.name)
//                        .foregroundColor(Color.gray)
//                }.rectangleElement()
//                    .onTapGesture {
//                        withAnimation {
//                            icecreamShopViewModel.onItemTapped()
//                        }
//                    }
//            }
//        }
    }
    
    
    private var icecreamshopImage: some View {
        HStack {
            Image(uiImage: icecreamShop.image)
                .resizable()
                .cornerRadius(50)
                .frame(width: 50, height: 50)
                .background(Color.black.opacity(0.2))
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .scaledToFit()
        }.padding(.leading)
    }
    
    private var starRatingIcon: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image.starRatingIcon(index: index, rating: icecreamShop.rating)
                    .foregroundColor(Color.orange)
            }
        }
    }
    
    private var availableFlavors: some View {
        HStack {
            ForEach(icecreamShop.availableFlavorIds, id: \.self) { flavorID in
                homeViewModel.getFlavor(id: flavorID).image
                    .resizable()
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0), style: FillStyle())
            }
        }
    }
}

struct IcecreamShopView_Previews: PreviewProvider {
    
    static var icecream1 = IcecreamShop(
        name: "Kuhbar",
        comment: "sehr lecker!",
        rating: 5,
        adress: Adress(
            street: "straße",
            housenumber: "",
            zipcode: "",
            city: ""
        ),
        imageData: nil,
        availableFlavors: [
            Flavor(
                image: Image(systemName: "erdbeere"),
                title: "",
                id: 1
            )
        ]
    )
    
    static var previews: some View {
        Group {
            IcecreamShopView( icecreamShop: icecream1, homeViewModel: HomeViewModel())
        }
        .previewLayout(.sizeThatFits)
    }
}
