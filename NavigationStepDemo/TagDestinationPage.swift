//
//  TagDestinationPage.swift
//  NavigationStepDemo
//
//  Created by Alex Nagy on 17.05.2021.
//

import SwiftUI
import SwiftUIPlus

struct TagDestinationPage: View {
    
    // MARK: - View Model
    
    // MARK: - Environments
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - EnvironmentObjects
    
    // MARK: - StateObjects
    
    // MARK: - ObservedObjects
    
    // MARK: - States
    @State private var progressHUDManager = ProgressHUDManager()
    @State private var alertManager = AlertManager()
    
    @State private var styleSelection = 0
    
    @State private var isActive = false
    
    // MARK: - Bindings
    @Binding var selection: Int?
    
    // MARK: - Properties
    var index: Int
    
    // MARK: - AppStorage
    
    // MARK: - Body
    var body: some View {
        ViewBody {
            content()
                .uses(progressHUDManager)
                .uses(alertManager)
                .onAppear { didAppear() }
                .onDisappear { didDisappear() }
            
            navigationSteps()
        }
    }
}

// MARK: - Content
extension TagDestinationPage {
    func content() -> some View {
        VStack {
            Text("Hello, \(index)!")
            
            Picker(selection: $styleSelection, label: Text("Picker"), content: {
                Text(".button").tag(0)
                Text(".view").tag(1)
            })
            .labelsHidden()
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.top)
            
            switch styleSelection {
            case 0:
                Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                }
            case 1:
                Text("Dismiss")
                    .onTapGesture {
                        dismiss()
                    }
            default:
                EmptyView()
            }
            
            switch styleSelection {
            case 0:
                Button {
                    selection = nil
                } label: {
                    Text("Dismiss selection = nil")
                }
            case 1:
                Text("Dismiss selection = nil")
                    .onTapGesture {
                        selection = nil
                    }
            default:
                EmptyView()
            }
            
            switch styleSelection {
            case 0:
                Button {
                    isActive.toggle()
                } label: {
                    Text("Dismiss isActive")
                }
            case 1:
                Text("Dismiss isActive")
                    .onTapGesture {
                        isActive.toggle()
                    }
            default:
                EmptyView()
            }
            NavigationDismissStep(selection: $selection, isActive: $isActive)
            
            NavigationDismissStep(style: getStyle(), selection: $selection, isActive: $isActive) {
                Text("Dismiss style isActive action")
            } action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    isActive.toggle()
                }
            }
            
            NavigationDismissStep(style: getStyle(), selection: $selection) {
                Text("Dismiss style")
            }
            
            Spacer()
        }
        .padding()
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

// MARK: - Navigation Links
extension TagDestinationPage {
    func navigationSteps() -> some View {
        Group {
            
        }
    }
}

// MARK: - Lifecycle
extension TagDestinationPage {
    func didAppear() {
        
    }
    
    func didDisappear() {
        
    }
}

// MARK: - Supplementary Views
extension TagDestinationPage {
    
}

// MARK: - Actions
extension TagDestinationPage {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
