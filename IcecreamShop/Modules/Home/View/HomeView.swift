//
//  HomeView.swift
//  
//
//
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @ObservedObject var locationManager = LocationManager()
    
    var sideBarViewModel = SideBarViewModel()
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                SideBar(
                    filterCallBack: { viewModel.filterCallBack($0) },
                    viewModel:  sideBarViewModel,
                    isSidebarVisible: $viewModel.isSidebarOpened
                )
                .zIndex(1)
                Color.primaryColor.ignoresSafeArea()
                VStack {
                    icecreamShopListView
                    addRatingView
                }
                .background(Color.primaryColor)
                .onAppear{ viewModel.onAppear() }
            }.modifier(
                TablebarView(
                    toggleFilter: $viewModel.isSidebarOpened,
                    secondaryFilter: $viewModel.showOnlyFullPoints
                )
            )
        }
    }
    
    private var icecreamShopListView: some View {
        
        VStack {
            if $viewModel.filteredShops.isEmpty {
                VStack(spacing: 10) {
                    Text("There are no icecream shops")
                        .font(.system(size: 20))
                        .foregroundColor(Color.gray)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text("just click on the plus Button to add your\nfavorite icecream shop")
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                }
            } else {
                ZStack {
                    Color.primaryColor.edgesIgnoringSafeArea(.all)
                    List {
                        Section {
                            ForEach($viewModel.filteredShops,id: \.id) { $icecreamShop in
                                Collapsible(
                                    icecreamShop: icecreamShop,
                                    homeViewModel: viewModel,
                                    locationManager: locationManager
                                )
                            }
                            .onDelete { indexSet in viewModel.removeShop(indexSet)}
                            .padding()

                        }
                        .listRowBackground(Color.transparent)
                        .listRowSeparator(.hidden)

                    }
                    .frame(maxWidth: .infinity,minHeight: 0)
                    .listStyle(.plain)
                    .compositingGroup()
                }
            }
        }
    }
    
    private var addRatingView: some View {
        HStack {
            NavigationLink(destination: RatingView(viewModel: RatingViewModel()).navigationBarBackButtonHidden(true)) {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .opacity(0.4)
            }.buttonStyle(UploadButtonStyle())
                .padding(.top, 0)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
