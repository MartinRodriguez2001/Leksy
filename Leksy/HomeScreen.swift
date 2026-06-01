//
//  HomeScreen.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 30-05-26.
//


import SwiftUI
import CoreData

struct HomeScreen: View {
    
    var body: some View  {
        VStack {
            HStack {
                ReusableWordCardView()
                    .frame(width: 300, height: 400)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            ToolBar()
            
        }
        .background(Color(white: 0.95))
    }
}

struct ReusableWordCardView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("Palabra")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.white.opacity(0.6))
                .padding(.top, 20)
            Spacer()
            HStack {
                Text("Leksy")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.secondary)
                Spacer()
                Circle()
                    .fill(.black)
                    .frame(width: 20, height: 20)
//                    .overlay(Circle().stroke(.white, lineWidth: 1.5))
//                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                
            }
            .padding(.bottom, 20)
                         
        }
        .padding(30)
        .background(Color("CardBackground"))
        .cornerRadius(30)
//        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
}

import SwiftUI

struct ToolBar: View {
    let buttonBackground = Color(white: 0.92)
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                print("Menu presionado")
            }) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 55, height: 55)
                    .background(buttonBackground)
                    .clipShape(Circle())
            }
            Spacer()
            Button(action: {
                print("Shuffle presionado")
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "shuffle")
                        .font(.system(size: 18, weight: .bold))
                    Text("Shuffle")
                        .font(.system(size: 18, weight: .bold))
                }
                .foregroundColor(.black)
                .padding(.horizontal, 27)
                .frame(height: 55)
                .background(buttonBackground)
                .clipShape(Capsule())
            }
            
            Spacer()
            Button(action: {
                print("Agregar presionado")
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 55, height: 55)
                    .background(buttonBackground)
                    .clipShape(Circle())
            }
        }
        .padding()
    }
}


#Preview {
    HomeScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
