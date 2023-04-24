import SwiftUI

struct SideBar: View {

    var filterCallBack: (([Int]) -> Void)? = nil
    @ObservedObject var viewModel: SideBarViewModel
    @Binding var isSidebarVisible: Bool
    
    
    var sideBarWidth = UIScreen.main.bounds.size.width * 0.32
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.3))
            .opacity(isSidebarVisible ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: isSidebarVisible)
            .onTapGesture {
                isSidebarVisible.toggle()
            }
            content
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    var content: some View {
        HStack(alignment: .top) {
            ZStack(alignment: .top) {
                flavorsMenu
                .padding(.top, 80)
                .padding(.horizontal, 40)
            }
            .frame(width: sideBarWidth)
            .offset(x: isSidebarVisible ? 0 : -sideBarWidth)
            .animation(.default, value: isSidebarVisible)
            Spacer()
        }
    }
    
    var flavorsMenu: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                Button {
                    filterCallBack?(viewModel.filters)
                } label: {
                    Text(verbatim: "Apply")
                }.frame(width: sideBarWidth/2)

                ForEach($viewModel.flavors, id: \.id) { $flavor in
                    Button(action: {
                        viewModel.onFlavorButtonTapped(flavor: flavor)
                    }) {
                        if flavor.flavorState == .marked {
                            flavor.image
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .center)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 25.0),
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
            .padding()
            .background(Color.primaryColor)
            .cornerRadius(25)
            .shadow(color: Color.blackOpacity, radius: 10, x: 10, y: 10)
            .shadow(color: Color.whiteOpacity, radius: 10, x: -5, y: -5)
        }
    }
}





struct SideBar_Previews: PreviewProvider {
    static var previews: some View {
        SideBar(viewModel: SideBarViewModel(), isSidebarVisible: .constant(true))
    }
}



