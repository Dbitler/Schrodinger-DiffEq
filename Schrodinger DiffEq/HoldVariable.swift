//
//  HoldVariable.swift
//  Quantum-Orbital
//
//  Created by IIT PHYS 440 on 2/10/23.
//

import SwiftUI

class HoldVariable: ObservableObject {
    
    @ObservedObject private var calculator = CalculatePlotData()
    @Published var insideData = [(xPoint: Double, yPoint: Double)]()
    @Published var outsideData = [(xPoint: Double, yPoint: Double)]()
    @Published var pickerAnswers = [Double]()
    @Published var pickerAnswerText = "jeff"
    
    
    
    enum Orientation: String, CaseIterable, Identifiable {
        case Square_well, Linear_well, Parabolic_Well, Square_barrier, Squarelinear_barrier, Triangle_barrier, Coupled_Parabolic_Well, Coupled_Square_Well_Field, Harmonic_Oscillator, Kronig_penney, Variable_Kronig, KP2_a
        var id: Self { self }
    }
    
    
    @Published var selectedOrientation: Orientation = .Square_well
    
    var xmaxstring = ""
    var xminstring = ""
    var ymaxstring = ""
    var yminstring = ""
    var zmaxstring = ""
    var zminstring = ""
    var integral = 0.0
    var guesses = 0
    var inneratomicspacing = ""
    //inner atomic spacing
    var iterations = ""

    

}
