//
//  FirtsCardCreationComp.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 30-05-26.
//
import SwiftUI

struct FirstCardCreationComp: View {
    
    @Binding var word: String
    @Binding var translation: String
    
    @State private var isVisible: Bool = false
    @State private var showInfo: Bool = false
    
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            VStack(spacing: 0) {
                TextField("",
                          text: $word,
                          prompt: Text("Add new word")
                            .font(.system(size: showInfo ? 22 : 22, weight: .bold))
                            .foregroundColor(.white.opacity(0.6))
                )
                .focused($isInputFocused)
                .submitLabel(.done)
                .font(.system(size: showInfo ? 22 : 22, weight: .bold))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.vertical, 40)
                
                Divider()
                    .background(.white.opacity(0.3))
                    .padding(.horizontal, 20)
                
                Text(translation.isEmpty ? "Translation" : translation)
                    .font(.system(size: showInfo ? 22 : 22, weight: .bold))
                    .foregroundColor(translation.isEmpty ? .white.opacity(0.6) : .white)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 40)
                    .frame(maxWidth: .infinity)
            }
            .background(Color("CardBackground"))
            .cornerRadius(25)
            .shadow(color: .black.opacity(isInputFocused ? 0.2 : 0.1),
                    radius: isInputFocused ? 20 : 10,
                    y: isInputFocused ? 10 : 5)
            
            
            if showInfo {
                TextInfo()
                    .frame(width: 120)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .padding(20)
        .offset(y: isVisible ? 0 : 600)
        .opacity(isVisible ? 1 : 0)
        
        .onChange(of: isInputFocused) { isFocused in
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                showInfo = !isFocused
            }
        }
        
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                isVisible = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    showInfo = true
                }
            }
        }
    }
}
