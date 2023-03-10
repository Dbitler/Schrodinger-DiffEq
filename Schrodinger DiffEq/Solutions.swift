//
//  Solutions.swift
//  Schrodinger DiffEq
//
//  Created by IIT PHYS 440 on 3/10/23.
//

import SwiftUI
import Foundation

class Solutions: ObservableObject {
    
    @Published var solutionData = [(EnergyPoint: Double, Wavefunction: [(xPoint: Double, PsiPoint: Double)])]()

}
