//
//  TestView.swift
//  
//
//
//

import SwiftUI

struct TestView: View {
//    @State var change: Bool = false
//
//    var body: some View {
//        Rectangle()
//            .frame(width: 200)
//            .modifier(AnimatingCellHeight(height: change ? 300 : 200))
//            .foregroundColor(Color.red)
//            .onTapGesture {
//                withAnimation {
//                    self.change.toggle()
//                }
//            }
//    }
    
    @State private var isDisclosed = false
      
      var body: some View {
          VStack {
//              Button("Expand") {
//                  withAnimation {
//                      isDisclosed.toggle()
//                  }
//              }
//              .buttonStyle(.plain)
              
              VStack {
                  VStack {
                      Text("Hi")
                  }
                  
                  VStack {
                      Text("More details here")
                  }
                  VStack {
                      Text("More details here")
                      
                   
                  }
                  
              }
              .frame(height: isDisclosed ? nil : 0, alignment: .top)
              .clipped()
              
              HStack {
                  Text("Cancel")
                  Spacer()
                  Text("Book")
              }
          }.rectangleElement()
              .onTapGesture {
                  withAnimation(.spring()) {
                      isDisclosed.toggle()
                  }
              }
      }
  }


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
