//
//  DestinationPage.swift
//  NavigationStepDemo
//
//  Created by Alex Nagy on 17.05.2021.
//

import SwiftUI
import SwiftUIPlus

struct DestinationPage: View {
    
    // MARK: - View Model
    
    // MARK: - Environments
    @Environment(\.presentationMode) private var presentationMode
    
    // MARK: - EnvironmentObjects
    
    // MARK: - StateObjects
    
    // MARK: - ObservedObjects
    
    // MARK: - States
    @State private var progressHUDManager = ProgressHUDManager()
    @State private var alertManager = AlertManager()
    
    @State private var isActive = false
    
    @State private var styleSelection = 0
    
    // MARK: - Bindings
    
    // MARK: - Properties
    
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
extension DestinationPage {
    func content() -> some View {
        VStack {
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
                    isActive.toggle()
                } label: {
                    Text("Back isActive")
                }
            case 1:
                Text("Back isActive")
                    .onTapGesture {
                        isActive.toggle()
                    }
            default:
                EmptyView()
            }
            NavigationDismissStep(presentationMode: presentationMode, isActive: $isActive)
            
            NavigationDismissStep(style: getStyle(), presentationMode: presentationMode, isActive: $isActive) {
                Text("Back isActive action")
            } action: {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    isActive.toggle()
                }
            }
            
            NavigationDismissStep(style: getStyle(), presentationMode: presentationMode) {
                Text("Back style")
            }
            
            Spacer()
        }
        .navigationBarTitle("NavigationDismissStep")
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
extension DestinationPage {
    func navigationSteps() -> some View {
        Group {
            
        }
    }
}

// MARK: - Lifecycle
extension DestinationPage {
    func didAppear() {
        
    }
    
    func didDisappear() {
        
    }
}

// MARK: - Supplementary Views
extension DestinationPage {
    
}

// MARK: - Actions
extension DestinationPage {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
