//
//  ContentView.swift
//  NavigationStepDemo
//
//  Created by Alex Nagy on 17.05.2021.
//

import SwiftUI
import SwiftUIPlus

struct ContentView: View {
    
    @State private var typeSelection = 0
    @State private var styleSelection = 0
    
    @State private var typeIsActive = false
    @State private var typeIsActiveOnDismiss = false
    @State private var actionIsActive = false
    @State private var actionIsActiveOnDismiss = false
    
    @State private var tagSelection: Int? = nil
    @State private var tagSelectionOnDismiss: Int? = nil
    
    var body: some View {
        ScrollView {
            
            Group {
                Picker(selection: $typeSelection, label: Text("Picker"), content: {
                    Text(".push").tag(0)
                    Text(".sheet").tag(1)
                    Text(".fullScreenSheet").tag(2)
                })
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                .padding(.top)
                .onChange(of: typeSelection) { _ in
                    tagSelection = nil
                    tagSelectionOnDismiss = nil
                }
                
                Picker(selection: $styleSelection, label: Text("Picker"), content: {
                    Text(".button").tag(0)
                    Text(".view").tag(1)
                })
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Divider()
            }
            
            Group {
                
                switch styleSelection {
                case 0:
                    Button(action: {
                        typeIsActive.toggle()
                    }, label: {
                        Text("type isActive")
                    })
                case 1:
                    Text("type isActive")
                        .onTapGesture {
                            typeIsActive.toggle()
                        }
                default:
                    EmptyView()
                }
                NavigationStep(type: getType(), isActive: $typeIsActive) {
                    DestinationPage()
                }
                
                switch styleSelection {
                case 0:
                    Button(action: {
                        typeIsActiveOnDismiss.toggle()
                    }, label: {
                        Text("type isActive onDismiss")
                    })
                case 1:
                    Text("type isActive onDismiss")
                        .onTapGesture {
                            typeIsActiveOnDismiss.toggle()
                        }
                default:
                    EmptyView()
                }
                NavigationStep(type: getType(), isActive: $typeIsActiveOnDismiss) {
                    DestinationPage()
                } onDismiss: {
                    print("Dismissed")
                }
                
                Divider()
            }
            
            Group {
                NavigationStep(type: getType(), style: getStyle()) {
                    DestinationPage()
                } label: {
                    Text("type style")
                }
                
                NavigationStep(type: getType(), style: getStyle()) {
                    DestinationPage()
                } label: {
                    Text("type style onDismiss")
                } onDismiss: {
                    print("Dismissed")
                }
                
                Divider()
            }
            
            Group {
                NavigationStep(type: getType(), style: getStyle(), isActive: $actionIsActive) {
                    DestinationPage()
                } label: {
                    Text("type style isActive action")
                } action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        actionIsActive.toggle()
                    }
                }
                
                NavigationStep(type: getType(), style: getStyle(), isActive: $actionIsActiveOnDismiss) {
                    DestinationPage()
                } label: {
                    Text("type style isActive action onDismiss")
                } action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        actionIsActiveOnDismiss.toggle()
                    }
                } onDismiss: {
                    print("Dismissed")
                }
                
                Divider()
            }
            
            Group {
                Group {
                    ForEach(0...2, id:\.self) { index in
                        NavigationStep(type: getType(), style: getStyle(), tag: index, selection: $tagSelection) {
                            TagDestinationPage(selection: $tagSelection, index: index)
                        } label: {
                            Text("type style tag: \(index)")
                        }
                    }
                    Divider()
                    
                    ForEach(0...2, id:\.self) { index in
                        NavigationStep(type: getType(), style: getStyle(), tag: index, selection: $tagSelectionOnDismiss) {
                            TagDestinationPage(selection: $tagSelectionOnDismiss, index: index)
                        } label: {
                            Text("type style tag onDismiss: \(index)")
                        } onDismiss: {
                            print("Dismissed: \(index)")
                        }
                    }
                    Divider()
                }
                
                Group {
                    ForEach(0...2, id:\.self) { index in
                        NavigationStep(type: getType(), style: getStyle(), tag: index, selection: $tagSelection) {
                            TagDestinationPage(selection: $tagSelection, index: index)
                        } label: {
                            Text("type style tag action: \(index)")
                        } action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                tagSelection = index
                            }
                        }
                    }
                    Divider()
                    
                    ForEach(0...2, id:\.self) { index in
                        NavigationStep(type: getType(), style: getStyle(), tag: index, selection: $tagSelectionOnDismiss) {
                            TagDestinationPage(selection: $tagSelectionOnDismiss, index: index)
                        } label: {
                            Text("type style tag action onDismiss: \(index)")
                        } action: {
                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                tagSelectionOnDismiss = index
                            }
                        } onDismiss: {
                            print("Dismissed: \(index)")
                        }
                    }
                    Divider()
                }
                
                Group {
                    ForEach(0...2, id:\.self) { index in
                        
                        switch styleSelection {
                        case 0:
                            Button(action: {
                                tagSelection = index
                            }, label: {
                                Text("type tag: \(index)")
                            })
                        case 1:
                            Text("type tag: \(index)")
                                .onTapGesture {
                                    tagSelection = index
                                }
                        default:
                            EmptyView()
                        }
                        NavigationStep(type: getType(), tag: index, selection: $tagSelection) {
                            TagDestinationPage(selection: $tagSelection, index: index)
                        }

                    }
                    Divider()
                    
                    ForEach(0...2, id:\.self) { index in
                        
                        switch styleSelection {
                        case 0:
                            Button(action: {
                                tagSelectionOnDismiss = index
                            }, label: {
                                Text("type tag onDismiss: \(index)")
                            })
                        case 1:
                            Text("type tag onDismiss: \(index)")
                                .onTapGesture {
                                    tagSelectionOnDismiss = index
                                }
                        default:
                            EmptyView()
                        }
                        NavigationStep(type: getType(), tag: index, selection: $tagSelectionOnDismiss) {
                            TagDestinationPage(selection: $tagSelectionOnDismiss, index: index)
                        } onDismiss: {
                            print("Dismissed: \(index)")
                        }
                    }
                    Divider()
                }
            }
            
        }
        .navigationBarTitle("NavigationStep")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func getType() -> NavigationStepType {
        switch typeSelection {
        case 0:
            return .push
        case 1:
            return .sheet
        case 2:
            return .fullScreenSheet
        default:
            return .push
        }
    }
    
    func getStyle() -> NavigationStepStyle {
        switch styleSelection {
        case 0:
            return .button
        case 1:
            return .view
        default:
            return .button
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
