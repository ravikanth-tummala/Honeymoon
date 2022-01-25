//
//  GuideView.swift
//  HoneyMoon
//
//  Created by GeoSpark on 24/01/22.
//

import SwiftUI

struct GuideView: View {
    // MARK: PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                
                Spacer(minLength: 10)
                
                Text("Get Started!")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                Text("Discount and pick the perfect destination for your romatic honeymoon!")
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                
                VStack(alignment: .leading, spacing: 25) {
                    GuideComponet(title: "Like",
                                  subtitle: "Swipe right",
                                  description: "Do you like this destination? Touch the screen and swipe right. It will be saved to the favourites.",
                                  icon: "heart.circle")
                    
                    
                    GuideComponet(title: "Dismiss",
                                  subtitle: "Swipe left",
                                  description: "Would you rather skip this place? Touch the screen and swipe left. You will no longer see it.",
                                  icon: "xmark.circle")
                    
                    GuideComponet(title: "Book",
                                  subtitle: "Tap the button",
                                  description: "Our selection of honeymoon report is perfect setting for you ro embark new life together.",
                                  icon: "checkmark.square")
                    
                }
                
                Spacer(minLength: 10)
                
                Button {
                    // ACTION
                    self.presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Continue".uppercased())
                        .modifier(ButtonModifier())
                }
                
            }
            .frame(minWidth:0, maxWidth: .infinity)
            .padding(.top,15)
            .padding(.bottom,25)
            .padding(.horizontal,25)
            
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
