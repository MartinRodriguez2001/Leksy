//
//  LanguageDownloadView.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 31-05-26.
//

import SwiftUI
import Translation

struct LanguageDownloadView: View {

    var onComplete: () -> Void

    @AppStorage("myLanguage") private var myLanguage: String = ""
    @AppStorage("studyLanguage") private var studyLanguage: String = ""

    @State private var state: DownloadState = .checking
    @State private var translationConfig: TranslationSession.Configuration?

    enum DownloadState {
        case checking, needsDownload, downloading, ready, failed, unsupported
    }

    var body: some View {
        VStack {
            Spacer()

            VStack(spacing: 12) {
                Text("Prepare your languages")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)
                Text("Leksy needs to download the language packs to translate words on your device.")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }

            Spacer()

            switch state {
            case .checking, .downloading:
                ProgressView()
                    .padding(.bottom, 60)

            case .needsDownload, .failed:
                Button(action: triggerDownload) {
                    Text(state == .failed ? "Try again" : "Download languages")
                        .foregroundStyle(.white)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 60)

            case .ready:
                Button(action: onComplete) {
                    Text("Continue")
                        .foregroundStyle(.white)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 60)

            case .unsupported:
                Text("This language pair is not supported on your device.")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 60)
            }
        }
        .translationTask(translationConfig) { session in
            do {
                try await session.prepareTranslation()
                state = .ready
            } catch {
                state = .failed
            }
        }
        .task {
            await checkAvailability()
        }
    }

    private func checkAvailability() async {
        let source = locale(for: myLanguage)
        let target = locale(for: studyLanguage)
        let status = await LanguageAvailability().status(from: source, to: target)
        switch status {
        case .installed:
            state = .ready
        case .supported:
            triggerDownload()
        case .unsupported:
            state = .unsupported
        @unknown default:
            triggerDownload()
        }
    }

    private func triggerDownload() {
        state = .downloading
        translationConfig = TranslationSession.Configuration(
            source: locale(for: myLanguage),
            target: locale(for: studyLanguage)
        )
    }

    private func locale(for language: String) -> Locale.Language {
        switch language {
        case "spanish": return Locale.Language(identifier: "es")
        case "french":  return Locale.Language(identifier: "fr")
        case "english": return Locale.Language(identifier: "en")
        default:        return Locale.Language(identifier: "en")
        }
    }
}

#Preview {
    LanguageDownloadView(onComplete: {
        print("Idiomas listos")
    })
}
