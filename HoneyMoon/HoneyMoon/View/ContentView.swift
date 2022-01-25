//
//  ContentView.swift
//  HoneyMoon
//
//  Created by GeoSpark on 24/01/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: PROPERTIES
    
    @State var showAler:Bool = false
    @State var showGuide:Bool = false
    @State var showInfo:Bool = false
    @GestureState private var draState = DragState.inactive
    private var dragAreaThreshold : CGFloat = 65.0
    @State private var lastCardIndex:Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingButtom
    
    // MARK: - CARD VIEWS
    
    @State var cardViews: [CardView] = {
        var views = [CardView]()
        
        for index in 0..<2{
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        
        return views
    }()
    
    // MARK: - MOVE CARD
    
    private func moveCards() {
        cardViews.removeFirst()
        self.lastCardIndex += 1
        
        let honeymoon = honeymoonData[lastCardIndex % honeymoonData.count]
        let newCardView = CardView(honeymoon: honeymoon)
        cardViews.append(newCardView)
    }
    
    // MARK: - TOP CARD
    private func isTopCard(cardview:CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardview.id}) else {
            return false
        }
        return index == 0
    }
    
    // MARK: - DRAG STATE
    
    enum DragState {
        case inactive
        case pressing
        case dragging(translation:CGSize)
        
        var translation:CGSize{
            switch self {
            case .inactive,.pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging:Bool {
            switch self {
            case .dragging:
                return true
            case .pressing,.inactive:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .inactive:
                return false
            case .pressing,.dragging:
                return true
            }
        }
    }
    
    var body: some View {
        VStack {
            // MARK: - Header
            HeaderView(showGuideView: $showGuide, showInfoView: $showInfo)
                .opacity(draState.isDragging ? 0.0 : 1.0)
                .animation(.default)
            
            Spacer()
            
            // MARK: - Card
            
            ZStack{
                ForEach(cardViews) { cardview in
                    cardview
                        .zIndex(self.isTopCard(cardview: cardview) ? 1 : 0)
                        .overlay(
                            
                            ZStack{
                                // X MARK
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.draState.translation.width < -self.dragAreaThreshold && self.isTopCard(cardview: cardview) ? 1.0 : 0.0)
                                
                                // X HEART
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(self.draState.translation.width > self.dragAreaThreshold && self.isTopCard(cardview: cardview) ? 1.0 : 0.0)
                                
                                
                            }
                        )
                        .offset(x: self.isTopCard(cardview: cardview) ? self.draState.translation.width : 0,
                                y: self.isTopCard(cardview: cardview) ? self.draState.translation.height : 0)
                        .scaleEffect(self.draState.isDragging && self.isTopCard(cardview: cardview) ? 0.85 : 1.0)
                        .rotationEffect(Angle(degrees: self.isTopCard(cardview: cardview) ? Double(self.draState.translation.width/12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120))
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                                    .sequenced(before: DragGesture())
                                    .updating(self.$draState, body: { value, state, transaction in
                            
                            switch value {
                            case .first(true):
                                state = .pressing
                                
                            case .second(true, let drag):
                                state = .dragging(translation: drag?.translation ?? .zero)
                                
                            default:
                                break
                            }
                        })
                        .onChanged({ value in
                            guard case .second(true,let drag?) =  value else {
                                return
                            }
                            
                            if drag.translation.width < -self.dragAreaThreshold {
                                self.cardRemovalTransition = .leadingButton
                            }
                            
                            if drag.translation.width > self.dragAreaThreshold {
                                self.cardRemovalTransition = .trailingButtom
                            }
                        })
                        .onEnded({ value in
                            
                            guard case .second(true,let drag?) =  value else {
                                return
                            }
                            if drag.translation.width < -self.dragAreaThreshold || drag.translation.width > self.dragAreaThreshold {
                                playSound(sound: "sound-rise", type: "mp3")
                            
                                self.moveCards()
                            }
                        })
                        ).transition(self.cardRemovalTransition)
                }
            }
            .padding(.horizontal)
            
            
            Spacer()
            
            // MARK: - Footer
            
            FooterView(showBookingAlert: $showAler)
                .opacity(draState.isDragging ? 0.0 : 1.0)
                .animation(.default)
            
        }
        .alert(isPresented: $showAler) {
            Alert(title: Text("SUCCESS"),
                  message: Text("Wishing a lovely and most precious of the times toghter for amazing couple."), dismissButton: .default(Text("Happt Honeymoon")))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
