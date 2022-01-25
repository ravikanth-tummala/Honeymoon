//
//  GuideComponet.swift
//  HoneyMoon
//
//  Created by GeoSpark on 24/01/22.
//

import SwiftUI

struct GuideComponet: View {
    // MARK: - PROPERTIES
    
    var title:String
    var subtitle:String
    var description:String
    var icon:String
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(Color.pink)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack{
                    Text(title.uppercased())
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    
                    Text(subtitle.uppercased())
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.pink)
                }
                Divider().padding(.bottom,4)
                Text(description)
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                    .fixedSize(horizontal: false, vertical: true)

            }
        }
    }
}

struct GuideComponet_Previews: PreviewProvider {
    static var previews: some View {
        GuideComponet(title: "Title",
                      subtitle: "Swipe right",
                      description: "This is placeholder sentence. This is placeholder sentence. This is placeholder sentence.", icon: "heart.circle")
            .previewLayout(.sizeThatFits)
    }
}
