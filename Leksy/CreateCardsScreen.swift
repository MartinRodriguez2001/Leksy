//
//  home.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 26-05-26.
//

import SwiftUI
import CoreData
import Translation

struct CreateCardsScreen: View {

    var onComplete: (() -> Void)? = nil

    @State private var word: String = ""
    @State private var translation: String = ""
    @State private var translationConfig: TranslationSession.Configuration?

    @AppStorage("myLanguage") private var myLanguage: String = ""
    @AppStorage("studyLanguage") private var studyLanguage: String = ""

    var body: some View {
        VStack {
            Text("Master new words")
                .font(.system(size: 25, weight: .bold))
                .padding(.top, 40)
            Text("Type a word to start building your personalized study deck")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)
                .padding(.horizontal, 30)
            FirstCardCreationComp(word: $word, translation: $translation)

            Spacer()

            if !word.isEmpty {
                Button(action: handleContinue) {
                    Text("Agregar")
                        .foregroundStyle(Color.white)
                        .bold()
                }
                .foregroundStyle(.white)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(.black)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 32)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: word)
        .onChange(of: word) { _, newWord in
            guard !newWord.isEmpty else {
                translation = ""
                return
            }
            scheduleTranslation()
        }
        .translationTask(translationConfig) { session in
            guard !word.isEmpty else { return }
            do {
                let response = try await session.translate(word)
                translation = response.targetText
            } catch {
                print("Translation error: \(error)")
            }
        }
    }

    private func handleContinue() {
        onComplete?()
    }

    private func scheduleTranslation() {
        let source = locale(for: myLanguage)
        let target = locale(for: studyLanguage)
        if translationConfig == nil {
            translationConfig = TranslationSession.Configuration(source: source, target: target)
        } else {
            translationConfig?.invalidate()
        }
    }

    private func locale(for language: String) -> Locale.Language {
        switch language {
        case "spanish": return Locale.Language(identifier: "es")
        case "french": return Locale.Language(identifier: "fr")
        case "english": return Locale.Language(identifier: "en")
        default: return Locale.Language(identifier: "en")
        }
    }
}

#Preview {
    CreateCardsScreen().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
