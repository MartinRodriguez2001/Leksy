//
//  TextInfo.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 30-05-26.
//

import SwiftUI

struct TextInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Agrega tu palabra")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.vertical, 40)
            
            Divider().opacity(0)
            
            Text("Traducción automática")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.vertical, 40)
        }
    }
}
