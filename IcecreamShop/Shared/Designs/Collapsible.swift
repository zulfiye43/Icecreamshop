import SwiftUI

struct Collapsible: View {
    
    let icecreamShop: IcecreamShop
    @State private var isDisclosed: Bool = true
    @ObservedObject var icecreamShopViewModel = IcecreamShopViewModel()
    @ObservedObject var homeViewModel: HomeViewModel
    var locationManager: LocationManager? = nil
    
    
    var body: some View {
        VStack {
            Button(
                action: { isDisclosed.toggle()},
                label: {
                    HStack {
                        HStack {
                            icecreamshopImage
                            Text(icecreamShop.name).foregroundColor(Color.gray)
                        }
                        Spacer()
                        Image(systemName: self.isDisclosed ? "chevron.down" : "chevron.up")
                    }
                    .padding(.bottom, 1)
                    .background(Color.white.opacity(0.01))
                }
            )
            .buttonStyle(PlainButtonStyle())
            
            VStack {
                availableFlavors
                VStack {
                    HStack(alignment: .bottom) {
                        Image("map")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 30)
                        Text(icecreamShop.adress.street).foregroundColor(Color.gray)
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            locationManager?.openMapWithAddress(icecreamShop.adress.street)
                        }
                    }
                    Text(icecreamShop.comment)
                        .foregroundColor(Color.gray)
                    starRatingIcon
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: isDisclosed ? 0 : .none)
            .clipped()
            .animation(.spring())
            .transition(.slide)
        }
        .padding(.vertical,20)
        .padding(.horizontal,8)
        .background(Color.offWhite)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 5)
        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -1, y: -1)
        .animation(.spring())
        .transition(.slide)
        .onTapGesture {
            withAnimation(.spring()) {
                isDisclosed.toggle()
            }
        }
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

struct Collapsible_Previews: PreviewProvider {
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
        Collapsible(icecreamShop: icecream1, homeViewModel: HomeViewModel())
    }
}
