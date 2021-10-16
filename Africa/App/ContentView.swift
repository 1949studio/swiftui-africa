//
//  ContentView.swift
//  Africa
//
//  Created by Jack Pyo Toke on 10/10/21.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    let animals: [Animal] = Bundle.main.decode("animals.json")
    @State private var isGridViewActivated : Bool = false
    let haptics = UIImpactFeedbackGenerator(style: .medium)
//    @State private var gridNumber : Int = 1
    
    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Int = 2
    @State private var toolbarIcon: String = "square.grid.2x2"
    
    // MARK: - Function
    func gridSwitch(){
        gridLayout = Array(repeating: .init(.flexible()), count: gridLayout.count % 3 + 1)
        gridColumn = gridLayout.count
        
        //Toolbar Image
        switch gridColumn {
        case 1:
            toolbarIcon = "rectangle.grid.1x2"
        case 2:
            toolbarIcon = "square.grid.2x2"
        case 3:
            toolbarIcon = "square.grid.3x2"
        default:
            toolbarIcon = "square.grid.2x2"
        }
        print("Grid Column: \(gridColumn)")
    }
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            Group {
                if !isGridViewActivated {
                    List {
                        CoverImageView()
                            .frame(height: 300)
                            .listRowInsets(EdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0))
                        
                        ForEach(animals) { animal in
                            NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                AnimalListItemView(animal: animal)
                            }
                        }
                        CreditsView()
                            .modifier(CenterModifier())
                    } //: List
                }
                else {
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                            ForEach(animals){ animal in
                                NavigationLink(destination: AnimalDetailView(animal: animal)) {
                                    AnimalGridItemView(animal: animal)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Africa", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 16) {
                        Button(action: {
                            print("List view is activated")
                            isGridViewActivated = false
                            haptics.impactOccurred()
                        }) {
                            Image(systemName: "square.fill.text.grid.1x2")
                                .font(.title2)
                                .foregroundColor(isGridViewActivated ? .primary : .accentColor)
                        }//: Button
                        
                        Button(action: {
                            print("Grid view is activated")
                            isGridViewActivated = true
                            haptics.impactOccurred()
                            gridSwitch()
                        }) {
                            Image(systemName: toolbarIcon)
                                .font(.title2)
                                .foregroundColor(isGridViewActivated ? .accentColor : .primary)
                        }
                    }//: HStack
                }//: ToolbarItem
            }
        }//: Navigation
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 mini")
    }
}
