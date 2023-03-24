//
//  ContentView.swift
//  Schrodinger DiffEq
//
//  Created by IIT PHYS 440 on 3/10/23.
//

import SwiftUI
import Charts

typealias extrapolatedDifferenceFunction = (_ C: Double, _ energy: Double) -> Double
typealias rootFinderFunctionAlias = (_ C: Double, _ energy: Double) -> Double


struct ContentView: View {
    @ObservedObject var myfunctionalinstance = Functional()
    @ObservedObject var mypotentialinstance = Potential()
    @ObservedObject var mywavefxnvariableinstance = Wavefunctions()
    @ObservedObject var mysolutioninstance = Solutions()
    @ObservedObject var myholdvariableinstance = HoldVariable()
    @EnvironmentObject var plotData :PlotClass
    //@State var plotData = [PlotDataStruct]()
    @ObservedObject private var calculator = CalculatePlotData()
    @State var isChecked:Bool = false
    @State var tempInput = ""
    @State var selector = 0
    @State var outputText = ""
    @MainActor func setObjectWillChange(theObject:PlotClass){
        
        theObject.objectWillChange.send()
        
    }
    @MainActor func setupPlotDataModel(selector: Int){
        
        calculator.plotDataModel = self.plotData.plotArray[selector]
    }
 
    @State var psi_0 = 0.0
    @State var psi_n = 0.0
    @State var psi_nplus1 = 0.0
    @State var psi_prime_n = 0.0
    @State var psi_prime_nplus1 = 0.0
    @State var delta_xstring = "0.05" //The size of delta_x determines the granularity of the Euler's solution, how accurate it is.
    @State var delta_x = 0.005
    @State var x_max = 10.0
    @State var x_min = 0.0
    @State var x_maxstring = "10.0"
    @State var x_minstring = "0.0"
   // @State var potential = 0.0
    @State var psi_doubleprime_n = 0.0
    
    @State var m_e = 510998.950 //MeV/c^2 (0.51 MeV)v FIX THESEE UNITS   eV* s^2/(eV^2 * s^2 * m^2) = 1/eV * m^2
    @State var h_barc = 0.1973269804 //eV⋅μm
    
    @State var E0string = "0.0" //E0 is an input
    @State var E_maxstring = "10.0" //E would be an input.
    @State var E0 = 0.0
    @State var E_max = 30.0
    @State var E_step = 0.005
    @State var E_stepstring = "0.05" //also an input.
    @State var plotType = ""
    
    
    
//    @State var x1 = 0.0
//    @State var x2 = 0.0
//    @State var x0 = 0.0
//    @State var x0array = [Double]()
//    @State var y1 = 0.0
//    @State var y2 = 0.0
//    @State var m = 0.0
//    @State var b = 0.0
    
    
    var body: some View {
        HStack{
            VStack {
                Text("Enter length parameters")
                HStack {
                    TextField("x-step", text: $delta_xstring)
                    TextField("x-min", text: $x_minstring)
                    TextField("x-max", text: $x_maxstring)
                }
                Text("Enter energy parameters")
                HStack {
                    TextField("E-step", text: $E_stepstring)
                    TextField("E-min", text: $E0string)
                    TextField("E-max", text: $E_maxstring)
                }
                HStack{
                    VStack{
                        List {
                            Picker("Plot", selection: $myholdvariableinstance.selectedPlot) {
                                Text("Potential").tag(HoldVariable.Plot.Potential)
                                Text("Functional").tag(HoldVariable.Plot.Functional)
                                Text("Wave Function").tag(HoldVariable.Plot.Wave_Function)
                            }
                        }
                    }
                    VStack{
                        List {
                            Picker("Potential", selection: $myholdvariableinstance.selectedOrientation) {
                                Group{
                                    Text("Square Well").tag(HoldVariable.Orientation.Square_well)
                                    Text("Linear Well").tag(HoldVariable.Orientation.Linear_well)
                                    Text("Parabolic Well").tag(HoldVariable.Orientation.Parabolic_Well)
                                    Text("Square + Linear Well").tag(HoldVariable.Orientation.Squarelinear_barrier)
                                }
                                Group{
                                    Text("Square Barrier").tag(HoldVariable.Orientation.Square_barrier)
                                    Text("Triangle Barrier").tag(HoldVariable.Orientation.Triangle_barrier)
                                    Text("Coupled Parabolic Well").tag(HoldVariable.Orientation.Coupled_Parabolic_Well)
                                    // Text("Coupled Square Well + Field").tag(HoldVariable.Orientation.Coupled_Square_Well_Field)
                                    Text("Harmonic Oscillator").tag(HoldVariable.Orientation.Harmonic_Oscillator)
                                    // Text("Kronig + Penney").tag(HoldVariable.Orientation.Kronig_penney)
                                    // Text("Variable Kronig - Penney").tag(HoldVariable.Orientation.Variable_Kronig)
                                    // Text("KP2-a").tag(HoldVariable.Orientation.KP2_a)
                                }
                                
                            }
                        }
                    }
                
                }
                
                Button(action: self.graph) {
                    Text("Calculate")
                }
                Button(action: self.printAnswers) {
                    Text("PrintAnswers")
                }
            }
        
            VStack{
                Chart($plotData.plotArray[selector].plotData.wrappedValue) {
                    LineMark(
                        x: .value("Energy", $0.xVal),
                        y: .value("Functional", $0.yVal)
                        
                    )
                    .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                    PointMark(x: .value("Position", $0.xVal), y: .value("Height", $0.yVal))
                    
                        .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                    
                    
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .padding()
                Text($plotData.plotArray[selector].changingPlotParameters.xLabel.wrappedValue)
                    .foregroundColor(.red)
                Text("Zeroes of the Function: ")
                TextEditor(text: $outputText)
            }
            /*
            
            VStack{
                Chart($plotData.plotArray[selector].plotData.wrappedValue) {
                    LineMark(
                        x: .value("Length", $0.xVal),
                        y: .value("Potential", $0.yVal)
                        
                    )
                    .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                    PointMark(x: .value("Position", $0.xVal), y: .value("Height", $0.yVal))
                    
                        .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                    
                    
                }
                .chartYAxis {
                    AxisMarks(position: .leading)
                }
                .padding()
            }
             */
            
        }
    }
    
    func printAnswers(){
        print($mypotentialinstance.PotentialData.wrappedValue)
        
    }
    
    //referenced by schrodingersoln
   func calculatewavefxn(_ C: Double, _ energy: Double) -> Double {
        mywavefxnvariableinstance.wavefxnData = []
        mywavefxnvariableinstance.wavefxnprimeData = []
        
        
        mywavefxnvariableinstance.wavefxnData.append((xPoint: x_min, PsiPoint:  0.0))
        mywavefxnvariableinstance.wavefxnprimeData.append((xPoint: x_min, PsiprimePoint: 7.0)) //Psiprimepoint is arbitrarily chosen number, could be anything
        
        psi_doubleprime_n = C * mywavefxnvariableinstance.wavefxnData[0].PsiPoint * ( energy - mypotentialinstance.PotentialData[0].PotentialPoint)
        
        mywavefxnvariableinstance.wavefxndoubleprimeData.append((xPoint: x_min, PsidoubleprimePoint: psi_doubleprime_n))
        
        for n in stride(from: 1, to: mypotentialinstance.PotentialData.count, by: 1){
            let x = Double(n) * delta_x
            
            psi_doubleprime_n = C * mywavefxnvariableinstance.wavefxnData[n-1].PsiPoint * ( energy - mypotentialinstance.PotentialData[n-1].PotentialPoint)
            psi_prime_nplus1 = mywavefxnvariableinstance.wavefxnprimeData[n-1].PsiprimePoint + (psi_doubleprime_n * delta_x)
            psi_nplus1 = mywavefxnvariableinstance.wavefxnData[n-1].PsiPoint + (mywavefxnvariableinstance.wavefxnprimeData[n-1].PsiprimePoint * delta_x)
            
            mywavefxnvariableinstance.wavefxnprimeData.append((xPoint: x, PsiprimePoint: psi_prime_nplus1))
            mywavefxnvariableinstance.wavefxnData.append((xPoint: x, PsiPoint:  psi_nplus1))
            
            mywavefxnvariableinstance.wavefxndoubleprimeData.append((xPoint: x, PsidoubleprimePoint: psi_doubleprime_n))
            
            
            
        }
       return (mywavefxnvariableinstance.wavefxnData.last?.PsiPoint)!
    }
    
    /// function utilizes the schrodinger equation, Looping over E, looping over x within that loop,
    ///
    ///it finds the value of phi double prime first, utilizing the given potential and that loop's E, and then uses that with the following equations to find the next phi, Phi n+1. Then it redoes the steps
    ///
    ///
    ///
    func schrodingersoln(C:Double){
        
        
        
        /* at the boundaries of the bounding box, psi_0 = 0, and psi_L = 0.
         */
        outputText = ""
        delta_x = Double(delta_xstring)!
         E0 = Double(E0string)!
        E_max = Double(E_maxstring)!
        psi_prime_n = 5
        E_step = Double(E_stepstring)!
        x_max = Double(x_maxstring)!
        x_min = Double(x_minstring)!
        
        
        
        mypotentialinstance.PotentialData = []
        mywavefxnvariableinstance.wavefxnData = []
        mywavefxnvariableinstance.wavefxnprimeData = []
        mywavefxnvariableinstance.wavefxndoubleprimeData = []
        myfunctionalinstance.functionalData = []
        
     //   mypotentialinstance.particleinaboxcalc(xmin: x_min, xmax: x_max, delta_x: self.delta_x)
//        print(mypotentialinstance.PotentialData)
    //    print(myholdvariableinstance.selectedOrientation.rawValue)
        mypotentialinstance.getPotential(potentialType: myholdvariableinstance.selectedOrientation.rawValue, xMin: x_min, xMax: x_max, xStep: self.delta_x)
      
        
        
        for energy in stride(from: E0, to: E_max, by: E_step) {
            let _ = calculatewavefxn(C, energy)
           // print(mywavefxnvariableinstance.wavefxnData)
            
            
            let functionalpoint = mywavefxnvariableinstance.wavefxnData[ mywavefxnvariableinstance.wavefxnData.count-1].PsiPoint - 0.0
            //change 0.0 to be able to fit multiple different potentials.
            
            myfunctionalinstance.functionalData.append((energyPoint: energy, FunctionalPoint: functionalpoint))
            //print(energy)
        }
        //print(myfunctionalinstance.functionalData)
        
       
        
    }
    
    func graph(){
        let C = -((2.0 * m_e) / pow(h_barc, 2.0)) * pow(1E-4,2) // h = eV*s ; m_e = eV/c^2 = eV * s^2/ m^2 => h^2/m = eV*m => eV* Angstrom = eV* m * 1E-10
        //h-bar * c = 0.1973269804... eV⋅μm
   //     print(C)
//print((2/C))
        schrodingersoln(C:C)//within this function, C is being called from where it is declared in the graph function, and pulled into the schrodinger soln function, maybe under a different name, which is why it is black instead of blue color font.
        
        var newfunctionalData: [[Double]]=[]
        for i in 0..<myfunctionalinstance.functionalData.count{
            newfunctionalData.append([myfunctionalinstance.functionalData[i].energyPoint, myfunctionalinstance.functionalData[i].FunctionalPoint])
        }

        let answers = rootFinder(functionData: newfunctionalData, h: 0.0001, step: delta_x, C: C, function: calculatewavefxn)
        
        for item in answers {
            mywavefxnvariableinstance.wavefxnData = []
            mywavefxnvariableinstance.wavefxnprimeData = []
            mywavefxnvariableinstance.wavefxndoubleprimeData = []
            
         let _ =  calculatewavefxn(C, item)
            mysolutioninstance.solutionData.append((EnergyPoint: item, Wavefunction: mywavefxnvariableinstance.wavefxnData))
            
            
        }
        
        myholdvariableinstance.pickerAnswers = answers
        
        for item in answers {
            outputText += "Energy = \(item) eV\n"
            
        }
        
        
       // calculateExtrapolatedDifference(functionToDifferentiate: (Double,Double) -> Double, x: energy, h: 0.00001, C: C)
        self.plotData.plotArray[0].plotData = []
        calculator.plotDataModel = self.plotData.plotArray[0]
        
        
        let plotType = myholdvariableinstance.selectedPlot.rawValue
        
        
        switch plotType {
        case "Functional":
            for m in 0...myfunctionalinstance.functionalData.count-1{
                calculator.appendDataToPlot(plotData: [(x: myfunctionalinstance.functionalData[m].energyPoint, y: myfunctionalinstance.functionalData[m].FunctionalPoint)])
            }
        case "Potential":
            for m in 0...mypotentialinstance.PotentialData.count-1{
                calculator.appendDataToPlot(plotData: [(x: mypotentialinstance.PotentialData[m].xPoint, y: mypotentialinstance.PotentialData[m].PotentialPoint)])
            }
        case "Wave_Function":
            for m in 0...mywavefxnvariableinstance.wavefxnData.count-1{
                calculator.appendDataToPlot(plotData: [(x: mywavefxnvariableinstance.wavefxnData[m].xPoint, y: mywavefxnvariableinstance.wavefxnData[m].PsiPoint)])
            }
        default:
            Text("plot Type Error")
        }
        
        setObjectWillChange(theObject: self.plotData)
        
    }

    
    
     /// calculateExtrapolatedDifference
     ///
     /// Calculates the derivative of a function y(x) at the point x
     ///
     //
     //  Extrapolated Difference Approximation of a Derivative
     //
     //
     //                        h              h               h              h
     //             8 *(y(x + ---)  -  y(x - ---))  - (y(x + ---)  -  y(x - ---))
     //  d                     4              4               2              2
     //  -- y(x) =  ----------------------------------------------------------
     //  dx                                  3h
     //
     ///
     /// - Parameters:
     ///   - functionToDifferentiate: function to be differentiated to calculate the value of y at each of the 4 points in the Extrapolated Difference method. Y in this case is the energy, and x is the position. We aren't using the functional to find zero, we are using the actual schrodinger equation.
     ///   - x: Position at which to calculate the derivative
     ///   - h: Extrapolated Difference h term (The X-step/delta-x)
     /// - Returns: deriviative of the function
   
    func calculateExtrapolatedDifference(functionToDifferentiate: extrapolatedDifferenceFunction, x: Double, h: Double, C: Double)-> (Double) {
        delta_x = Double(delta_xstring)!
        //let h = delta_x
        //let C = -((2.0 * m_e) / pow(h_barc, 2.0)) * pow(1E-4,2)
         let extrapolatedDifferenceDerivativeNumerator = 8.0 * ( functionToDifferentiate(C, x + (h/4.0)) - functionToDifferentiate(C, x - (h/4.0))) - (functionToDifferentiate(C, x + (h/2.0)) - functionToDifferentiate(C, x - (h/2.0)))

         let extrapolatedDifferenceDerivative = extrapolatedDifferenceDerivativeNumerator/(3.0*h)

     return(extrapolatedDifferenceDerivative)

     }

    func rootFinder(functionData: [[Double]], h: Double, step: Double, C: Double, function: rootFinderFunctionAlias) -> [Double]{

        var quickSearchResult :[Double] = []
        var finalRoots :[Double] = []

        var previousFunctionValue = functionData[0][1]

        for item in functionData{

            if(previousFunctionValue*item[1] <= 0){

                quickSearchResult.append(item[0])
            }

            previousFunctionValue = item[1]

        }
      // print(quickSearchResult) //not final roots, just area to search arround

        //WORK ON THIS

        for item in quickSearchResult{

            var x = item - 2.0*step

            //Newton-Raphson Search
           for _ in 0...10 {

                let newtonRaphsonNumerator = function(x, C)

                // Extrapolated Difference
                let newtonRaphsonDenominator = calculateExtrapolatedDifference(functionToDifferentiate: function, x: x, h: h, C: C)

                let deltaX = -newtonRaphsonNumerator/newtonRaphsonDenominator
                x = x + deltaX

                if abs(deltaX) <= x.ulp {

                    break

                }

           }

            finalRoots.append(x)


        }
        print(finalRoots)
        return(finalRoots) //WORKS
        
    }
   
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
