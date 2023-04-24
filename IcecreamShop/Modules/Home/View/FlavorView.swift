//
//  CategoryRow.swift
//  
//
//
//

import SwiftUI


struct FlavorView: View {
    
    var flavor: Flavor

    var body: some View {
        HStack {
            Button(action: {
            }) {
                    flavor.image
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0), style: FillStyle())
            }
            Spacer()
        }.padding()
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        FlavorView(flavor: Flavor.init(image: Image("erdbeere"), title: "Erdbeere", id: 1 ))
    }
}
