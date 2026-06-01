//
//  LanguageSetupView.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 30-05-26.
//

import SwiftUI
import CoreData

struct LanguageSetupView: View {
    @State private var showError: Bool = false
    
    @AppStorage("myLanguage") private var myLanguage: String = ""
    @AppStorage("studyLanguage") private var studyLanguage: String = ""
    
    var onSetupComplete: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to Leksy")
                .font(.system(size: 20, weight: .regular))
            Text("Learn new languages with flashcards")
                .font(.system(size: 30, weight: .bold, design: .default))
                .multilineTextAlignment(.center)
                .lineLimit(nil)
            
            Spacer()  // empuja el botón hacia abajo
            HStack {
                Text("I'm learning").bold()
                Spacer()
                Picker("Selecciona tu lenguaje", selection: $studyLanguage) {
                    Text("Spanish").tag("spanish")
                    Text("French").tag("french")
                    Text("English").tag("english")
                }
                .pickerStyle(.menu)
                .tint(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 32)
            
            HStack {
                Text("My language").bold()
                Spacer()
                Picker("My language", selection: $myLanguage) {
                    Text("Spanish").tag("spanish")
                    Text("French").tag("french")
                    Text("English").tag("english")
                }
                .pickerStyle(.menu)
                .tint(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 32)
            
            Spacer()
            Button(action: handleContinue, label: {
                Text("Continue")
            })
            .foregroundStyle(.white)
            .bold()
            .padding()
            .frame(maxWidth: .infinity)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal, 32)
            
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("No puedes aprender el mismo idioma que el tuyo")
            
        }
        .padding(.top, 200)
        .padding(.bottom, 60)
        }
    
    private func handleContinue () {
        if languageValidation() {
            triggerHaptic(style: .medium)
            onSetupComplete()
        } else {
            showError = true
        }
    }
    
    private func languageValidation () -> Bool {
        return studyLanguage != myLanguage
    }
}

#Preview {
    LanguageSetupView(onSetupComplete: {
        print("El usuario terminó el setup en la previsualización")
    })
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
