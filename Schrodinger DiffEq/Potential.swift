//
//  Potential.swift
//  Schrodinger Eqn
//
//  Created by IIT PHYS 440 on 2/24/23.
//

import SwiftUI

class Potential: ObservableObject {
    @Published var PotentialData = [(xPoint: Double, PotentialPoint: Double)]()
    @Published var xOffset = 0.0
    
    
    
    func particleinaboxcalc(xmin: Double, xmax: Double, delta_x: Double) {
        
        startPotential(xMin: xmin, xMax: xmax, xStep: delta_x)
        
        for x in stride(from: xmin + delta_x, to: xmax, by: delta_x){
            PotentialData.append((xPoint: x, PotentialPoint: 0.0))
        }
        finishPotential(xMin: xmin, xMax: xmax, xStep: delta_x)
    }
    
    func startPotential(xMin: Double, xMax: Double, xStep: Double){
        PotentialData.append((xPoint: xMin, PotentialPoint: 1000000000.0))
        
    }
    func finishPotential(xMin: Double, xMax: Double, xStep: Double){
        PotentialData.append((xPoint: xMax, PotentialPoint: 1000000000.0))
        
    }

    func getPotential(potentialType: String, xMin: Double, xMax: Double, xStep: Double)
      {
          PotentialData.removeAll()
          PotentialData.removeAll()
          PotentialData.removeAll()
          
          xOffset = 0.0
          
    
          var count = 0
          
          switch potentialType {
          case "Square Well":
              
                  startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
                  
              for x in stride(from: xMin+xStep, through: xMax-xStep, by: xStep) {
                  
                  PotentialData.append((xPoint: x, PotentialPoint: 0.0))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
              }
                  
                  finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
//
//              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
//
//          for i in stride(from: xMin+xStep, through: xMax-xStep, by: xStep) {
//
//              PotentialData.append(i)
//              PotentialData.append(0.0)
//
//              count = PotentialData.oneDPotentialXArray.count
//              dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
//              contentArray.append(dataPoint)
//          }
//
//              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
//
              
              
          case "Linear Well":
              
              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              for i in stride(from: xMin+xStep, through: xMax-xStep, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append((i-xMin)*4.0*1.3)
                  //PotentialData.oneDPotentialYArray.append((i-xMin)*0.25)
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
          case "Parabolic Well":
              
              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              for i in stride(from: xMin+xStep, through: xMax-xStep, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append((pow((i-(xMax+xMin)/2.0), 2.0)/1.0))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)

              }
              
              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
          case "Square + Linear Well":
              
              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              for i in stride(from: xMin+xStep, to: (xMax+xMin)/2.0, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              for i in stride(from: (xMin+xMax)/2.0, through: xMax-xStep, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(((i-(xMin+xMax)/2.0)*4.0*0.1))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              
          case "Square Barrier":
              
              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              for i in stride(from: xMin+xStep, to: xMin + (xMax-xMin)*0.4, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.4, to: xMin + (xMax-xMin)*0.6, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(15.000000001)
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.6, to: xMax, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
              }
              
              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
          case "Triangle Barrier":
              
              var dataPoint: plotDataType = [:]
              var count = 0
              
              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              for i in stride(from: xMin+xStep, to: xMin + (xMax-xMin)*0.4, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.4, to: xMin + (xMax-xMin)*0.5, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append((abs(i-(xMin + (xMax-xMin)*0.4))*3.0))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.5, to: xMin + (xMax-xMin)*0.6, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append((abs(i-(xMax - (xMax-xMin)*0.4))*3.0))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)

              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.6, to: xMax, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
              }
              
              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
          
          case "Coupled Parabolic Well":
              
              var dataPoint: plotDataType = [:]
              var count = 0
              
              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              for i in stride(from: xMin+xStep, to: xMin + (xMax-xMin)*0.5, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append((pow((i-(xMin+(xMax-xMin)/4.0)), 2.0)))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.5, through: xMax-xStep, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append((pow((i-(xMax-(xMax-xMin)/4.0)), 2.0)))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
                  
              }
              
              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
          
          case "Coupled Square Well + Field":
              
              var dataPoint: plotDataType = [:]
              
              startPotential(xMin: xMin, xMax: xMax, xStep: xStep)
              
              for i in stride(from: xMin+xStep, to: xMin + (xMax-xMin)*0.4, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
                  
              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.4, to: xMin + (xMax-xMin)*0.6, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(4.0)
                  
              }
              
              for i in stride(from: xMin + (xMax-xMin)*0.6, to: xMax, by: xStep) {
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
      
              }
              
              for i in 1 ..< (PotentialData.oneDPotentialXArray.count) {
                  
                  PotentialData.oneDPotentialYArray[i] += ((PotentialData.oneDPotentialXArray[i]-xMin)*4.0*0.1)
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[i], .Y: PotentialData.oneDPotentialYArray[i]]
                  contentArray.append(dataPoint)
              }
              
              
              finishPotential(xMin: xMin, xMax: xMax, xStep: xStep)
          
          case "Harmonic Oscillator":
              
              var dataPoint: plotDataType = [:]
              var count = 0
              
              let xMinHO = -20.0
              let xMaxHO = 20.0
              let xStepHO = 0.001
              
              startPotential(xMin: xMinHO+xMaxHO, xMax: xMaxHO+xMaxHO, xStep: xStepHO)
              
              for i in stride(from: xMinHO+xStepHO, through: xMaxHO-xStepHO, by: xStepHO) {
                  
                  PotentialData.oneDPotentialXArray.append(i+xMaxHO)
                  PotentialData.oneDPotentialYArray.append((pow((i-(xMaxHO+xMinHO)/2.0), 2.0)/15.0))
                  
                  count = PotentialData.oneDPotentialXArray.count
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                  contentArray.append(dataPoint)
              }
              
              finishPotential(xMin: xMinHO+xMaxHO, xMax: xMaxHO+xMaxHO, xStep: xStepHO)
              
          case "Kronig - Penney":
              
              var dataPoint: plotDataType = [:]
              var count = 0
              
              let xMinKP = 0.0
              
              let xStepKP = 0.001
              
              let numberOfBarriers = 10.0
              let boxLength = 10.0
              let barrierPotential = 100.0*hbar2overm/2.0
              let latticeSpacing = boxLength/numberOfBarriers
              let barrierWidth = 1.0/6.0*latticeSpacing
              var barrierNumber = 1;
              var currentBarrierPosition = 0.0
              var inBarrier = false;
              
              let xMaxKP = boxLength
              
              
              startPotential(xMin: xMinKP, xMax: xMaxKP, xStep: xStepKP)
              
              for i in stride(from: xMinKP+xStepKP, through: xMaxKP-xStepKP, by: xStepKP) {
                  
                  currentBarrierPosition = -latticeSpacing/2.0 + Double(barrierNumber)*latticeSpacing
                  
                  if( (abs(i-currentBarrierPosition)) < (barrierWidth/2.0)) {
                      
                      inBarrier = true
                      
                      PotentialData.oneDPotentialArray.append((xCoord: i, Potential: barrierPotential))
                      
                      PotentialData.oneDPotentialXArray.append(i)
                      PotentialData.oneDPotentialYArray.append(barrierPotential)
                      
                      count = PotentialData.oneDPotentialXArray.count
                      dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                      contentArray.append(dataPoint)
                      
                      
                  }
                  else {
                      
                      if (inBarrier){
                          
                          inBarrier = false
                          barrierNumber += 1
                          
                      }
                      
                      PotentialData.oneDPotentialXArray.append(i)
                      PotentialData.oneDPotentialYArray.append(0.0)
                      
                      count = PotentialData.oneDPotentialXArray.count
                      dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
                      contentArray.append(dataPoint)
                      
                      
                  }
                  
                  
              }
              
              PotentialData.oneDPotentialXArray.append(xMax)
              PotentialData.oneDPotentialYArray.append(5000000.0)
              
              dataPoint = [.X: PotentialData.oneDPotentialXArray[count-1], .Y: PotentialData.oneDPotentialYArray[count-1]]
              contentArray.append(dataPoint)
              
              /** Fixes Bug In Plotting Library not displaying the last point **/
              dataPoint = [.X: xMax+xStep, .Y: 5000000.0]
              contentArray.append(dataPoint)
              
              let xMin = PotentialData.minX(minArray: PotentialData.oneDPotentialXArray)
              let xMax = PotentialData.maxX(maxArray: PotentialData.oneDPotentialXArray)
              let yMin = PotentialData.minY(minArray: PotentialData.oneDPotentialYArray)
              var yMax = PotentialData.maxY(maxArray: PotentialData.oneDPotentialYArray)
              
              if yMax > 500 { yMax = 10}
              
              makePlot(xLabel: "x Å", yLabel: "Potential V", xMin: (xMin - 1.0), xMax: (xMax + 1.0), yMin: yMin-1.2, yMax: yMax+0.2)
              
              contentArray.removeAll()
              
          case "Variable Kronig - Penney":
              
              /****  Get Parameters ****/
              
              if let kpDataController = storyboard!.instantiateController(withIdentifier: "theSecondViewController") as? secondViewController {
                  kpDataController.delegate = self
                  presentAsSheet(kpDataController)
              }

              
          case "KP2-a":
              
              var dataPoint: plotDataType = [:]
              var count = 0
              
              let xMinKP = 0.0
              
              let xStepKP = 0.001
              
             // let numberOfBarriers = 2.0
              let boxLength = 10.0
              let barrierPotential = 100.0*hbar2overm/2.0
              let latticeSpacing = 1.0 //boxLength/numberOfBarriers
              let barrierWidth = 1.0/6.0*latticeSpacing
              var barrierNumber = 1;
              var currentBarrierPosition = 0.0
              var inBarrier = false;
              
              let xManKP = boxLength
              
              
              PotentialData.oneDPotentialArray.append((xCoord: xMinKP, Potential: 5000000.0))
              dataPoint = [.X: PotentialData.oneDPotentialArray[0].xCoord, .Y: PotentialData.oneDPotentialArray[0].Potential]
              contentArray.append(dataPoint)
              
              for i in stride(from: xMinKP+xStepKP, through: xManKP-xStepKP, by: xStepKP) {
                  
                  let term = (-latticeSpacing/2.0) * (pow(-1.0, Double(barrierNumber))) - Double(barrierNumber)*Double(barrierNumber-1) * (pow(-1.0, Double(barrierNumber)))
                  
                  currentBarrierPosition =  term + Double(barrierNumber)*latticeSpacing*4.0
                  
                  if( (abs(i-currentBarrierPosition)) < (barrierWidth/2.0)) {
                      
                      inBarrier = true
                      
                      PotentialData.oneDPotentialArray.append((xCoord: i, Potential: barrierPotential))
                      
                      let count = PotentialData.oneDPotentialArray.count - 1
                      let dataPoint: plotDataType = [.X: PotentialData.oneDPotentialArray[count].xCoord, .Y: PotentialData.oneDPotentialArray[count].Potential]
                      contentArray.append(dataPoint)
                      
                  }
                  else {
                      
                      if (inBarrier){
                          
                          inBarrier = false
                          barrierNumber += 1
                          
                      }
                      
                      PotentialData.oneDPotentialArray.append((xCoord: i, Potential: 0.0))
                      
                      let count = PotentialData.oneDPotentialArray.count - 1
                      let dataPoint: plotDataType = [.X: PotentialData.oneDPotentialArray[count].xCoord, .Y: PotentialData.oneDPotentialArray[count].Potential]
                      contentArray.append(dataPoint)
                      
                      
                  }
                  
                  
              }
              
              count = PotentialData.oneDPotentialArray.count
              PotentialData.oneDPotentialArray.append((xCoord: xManKP, Potential: 5000000.0))
              dataPoint = [.X: PotentialData.oneDPotentialArray[count-1].xCoord, .Y: PotentialData.oneDPotentialArray[count-1].Potential]
              contentArray.append(dataPoint)
              
              /** Fixes Bug In Plotting Library not displaying the last point **/
              dataPoint = [.X: xManKP+xStepKP, .Y: 5000000]
              contentArray.append(dataPoint)
              
              let xMin = PotentialData.minX(minArray: PotentialData.oneDPotentialXArray)
              let xMax = PotentialData.maxX(maxArray: PotentialData.oneDPotentialXArray)
              let yMin = PotentialData.minY(minArray: PotentialData.oneDPotentialYArray)
              var yMax = PotentialData.maxY(maxArray: PotentialData.oneDPotentialYArray)
              
              if yMax > 500 { yMax = 10}
              
              makePlot(xLabel: "x Å", yLabel: "Potential V", xMin: (xMin - 1.0), xMax: (xMax + 1.0), yMin: yMin-1.2, yMax: yMax+0.2)
              
              contentArray.removeAll()
              
          default:
              let tab: Character = "\t"
              let geFilePanel: NSOpenPanel = NSOpenPanel()
              var filePath :URL = URL(string:("file://"))!
              
              var dataPoint: plotDataType = [:]
              
              geFilePanel.runModal()
              
              // Get the file path from the NSSavePanel
              
              filePath = URL(string:("file://" + (geFilePanel.url?.path)!))!
              
              print(filePath)
              
              do {
                  let tsv = try CSV(url: filePath, delimiter: tab, encoding: String.Encoding.utf8, loadColumns: true)
                      
                  var xArray: Array = (tsv.namedColumns[tsv.header[0]] as Array?)!
                  var yArray: Array = (tsv.namedColumns[tsv.header[1]] as Array?)!
                  
                  
                  for index in 0..<xArray.count {
                      
                      PotentialData.oneDPotentialXArray.append(Double(xArray[index])!)
                      PotentialData.oneDPotentialYArray.append(Double(yArray[index])!)
                      
                  }

                  let xMin = PotentialData.minX(minArray: PotentialData.oneDPotentialXArray)
                  let xMax = PotentialData.maxX(maxArray: PotentialData.oneDPotentialXArray)
                  let yMin = PotentialData.minY(minArray: PotentialData.oneDPotentialYArray)
                  var yMax = PotentialData.maxY(maxArray: PotentialData.oneDPotentialYArray)
                  
                  if (xMin < 0.0) {
                      
                      xOffset = -xMin
                      
                      for i in 0..<PotentialData.oneDPotentialXArray.count {
                          
                          dataPoint = [.X: PotentialData.oneDPotentialXArray[i], .Y: PotentialData.oneDPotentialYArray[i]]
                          contentArray.append(dataPoint)
                          
                          PotentialData.oneDPotentialXArray[i] += xOffset
                          
                      }
                      
                      
                  }
                  
                  if yMax > 500 { yMax = 10}
                  
                  makePlot(xLabel: "x Å", yLabel: "Potential V", xMin: (xMin - 1.0), xMax: (xMax + 1.0), yMin: yMin-1.2, yMax: yMax+0.2)
                  
                  contentArray.removeAll()
                  
                  
              } catch {
                  // Error handling
              }
              
              
              
          }

      
      }
      
      func userDidEnterInformation(info: String?) {
                  
          setupVariableKronigPenney(numberOfBarriers: Double(info!)!)
         
      }
      
      
      func setupVariableKronigPenney(numberOfBarriers: Double) {
          var dataPoint: plotDataType = [:]
          var count = 0
          
          let xMinKP = 0.0
          
          let xStepKP = 0.001
          
          let boxLength = numberOfBarriers
          let barrierPotential = 100.0*hbar2overm/2.0
          let latticeSpacing = boxLength/numberOfBarriers
          let barrierWidth = 1.0/6.0*latticeSpacing
          var barrierNumber = 1;
          var currentBarrierPosition = 0.0
          var inBarrier = false;
          
          let xMaxKP = boxLength
          
          
          startPotential(xMin: xMinKP, xMax: xMaxKP, xStep: xStepKP)
          
          for i in stride(from: xMinKP+xStepKP, through: xMaxKP-xStepKP, by: xStepKP) {
              
              currentBarrierPosition = -latticeSpacing/2.0 + Double(barrierNumber)*latticeSpacing
              
              if( (abs(i-currentBarrierPosition)) < (barrierWidth/2.0)) {
                  
                  inBarrier = true
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(barrierPotential)
                  
                  count = PotentialData.oneDPotentialXArray.count - 1
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count], .Y: PotentialData.oneDPotentialYArray[count]]
                  contentArray.append(dataPoint)
                  
              }
              else {
                  
                  if (inBarrier){
                      
                      inBarrier = false
                      barrierNumber += 1
                      
                  }
                  
                  PotentialData.oneDPotentialXArray.append(i)
                  PotentialData.oneDPotentialYArray.append(0.0)
                  
                  count = PotentialData.oneDPotentialXArray.count - 1
                  dataPoint = [.X: PotentialData.oneDPotentialXArray[count], .Y: PotentialData.oneDPotentialYArray[count]]
                  contentArray.append(dataPoint)
                  
                  
              }
              
              
          }
          
          count = PotentialData.oneDPotentialXArray.count-1
          PotentialData.oneDPotentialXArray.append(xMaxKP)
          PotentialData.oneDPotentialYArray.append(5000000.0)
          dataPoint = [.X: PotentialData.oneDPotentialXArray[count], .Y: PotentialData.oneDPotentialYArray[count]]
          contentArray.append(dataPoint)
          
          /** Fixes Bug In Plotting Library not displaying the last point **/
          dataPoint = [.X: xMaxKP+xStepKP, .Y: 5000000]
          contentArray.append(dataPoint)
          
          let xMin = PotentialData.minX(minArray: PotentialData.oneDPotentialXArray)
          let xMax = PotentialData.maxX(maxArray: PotentialData.oneDPotentialXArray)
          let yMin = PotentialData.minY(minArray: PotentialData.oneDPotentialYArray)
          var yMax = PotentialData.maxY(maxArray: PotentialData.oneDPotentialYArray)
          
          if yMax > 500 { yMax = 10}
          
          makePlot(xLabel: "x Å", yLabel: "Potential V", xMin: (xMin - 1.0), xMax: (xMax + 1.0), yMin: yMin-1.2, yMax: yMax+0.2)
          
          contentArray.removeAll()
          
      }

}

