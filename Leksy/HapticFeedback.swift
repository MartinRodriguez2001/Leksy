//
//  HapticFeedback.swift
//  Leksy
//
//  Created by Martin Adolfo Rodriguez Riquelme on 31-05-26.
//


import UIKit

func triggerHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle) {
   let generator = UIImpactFeedbackGenerator(style: style)
   generator.impactOccurred()
}
