//
//  HeaderView.swift
//  HoneyMoon
//
//  Created by GeoSpark on 24/01/22.
//

import SwiftUI

struct HeaderView: View {
    // MARK: Properties
    @Binding var showGuideView:Bool
    @Binding var showInfoView:Bool
    let haptics = UINotificationFeedbackGenerator()

    var body: some View {
        HStack {
            Button {
                // Action:
                playSound(sound: "sound-click", type: "mp3")
                self.haptics.notificationOccurred(.success)
                self.showInfoView.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24,weight: .regular))
            }
            .accentColor(Color.primary)
            .sheet(isPresented: $showInfoView) {
               InfoView()
            }


            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height:28)
            
            Spacer()
            
            Button {
                // Action:
//                print("Guide")
                playSound(sound: "sound-click", type: "mp3")
                self.haptics.notificationOccurred(.success)

                self.showGuideView.toggle()
            } label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24,weight: .regular))
            }
            .accentColor(Color.primary)
            .sheet(isPresented: $showGuideView) {
                GuideView()
            }

        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showAlert:Bool = false
    @State static var showInfo:Bool = false

    static var previews: some View {
        HeaderView(showGuideView: $showAlert, showInfoView: $showInfo)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
