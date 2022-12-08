//
//  ContentView.swift
//  TempConverter
//
//  Created by Michael Colvin on 11/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "ºF"
    @State private var outputUnit = "ºC"
    @State private var tempSetting = 0.0
    @State private var allErrorMsgs = ["Cannot convert from ºF to ºF", "Cannot convert from ºC to ºC", "Cannot convert from ºK to ºK"]
    
    @State private var errIndex = 0
    
    @State private var errorMsg = ""
 
//    var errorMsg: String {
//        allErrorMsgs
//    }
//
    @FocusState private var tempIsFocused: Bool
    
    let unitInSelection = ["ºF", "ºC", "ºK"]
    let unitOutSelection = ["ºF", "ºC", "ºK"]
    let convertedTemp = 0.0
    
    var convertTemp: Double {
        
        var convertedTemp = 0.0
        let conversionDirection = inputUnit + outputUnit
        
        switch conversionDirection {
        case "ºFºC":
            convertedTemp = (tempSetting - 32)*(5/9)
            
        case "ºCºF":
            convertedTemp = tempSetting*(9/5) + 32
            
        case "ºFºK":
            convertedTemp = (tempSetting - 32) * (5/9) + 273.15
            
        case "ºKºF":
            convertedTemp = (tempSetting - 273.15) * (9/5) + 32
            
        case "ºCºK":
            convertedTemp =  tempSetting + 273.15
            
        case "ºKºC":
            convertedTemp = tempSetting - 273.15
            
        case "ºCºC":
            convertedTemp = 99999999999999.99
            errIndex = 1
            

        default:
            convertedTemp = 99999999999999.99
//            errorMsg = "Bad"
        }
        
        print("Temp Setting = ", tempSetting)
        print ("Converted Direction = ", conversionDirection)
        print("Conversion Temp = ", conversionDirection)
        print("Converted Temp = ", convertedTemp)
  //      print("Error Message = ", errorMsg)
        
        return convertedTemp
        
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Temperature:")
                        TextField("Temperature: ", value: $tempSetting, formatter: NumberFormatter())
                        
                    }
                        Picker("From:", selection: $inputUnit){
                            ForEach (unitInSelection, id: \.self) {
                                Text("\($0)")
                            }
                        } .pickerStyle(.menu)
                        Picker("To:", selection: $outputUnit){
                            ForEach (unitOutSelection, id: \.self) {
                                Text("\($0)")
                            }
                        } .pickerStyle(.menu)
                        
                  
                    
                }
                    Section {
                        
                        Text(convertTemp, format: .number)
                    }
                    
                    Section {
                                Text(allErrorMsgs[errIndex])
                    }
                
               
            }
            .navigationTitle("Temp Converter")
            .toolbar
            {
               ToolbarItemGroup(placement: .keyboard) {
                   Spacer()
                   Button("Done") {
                      tempIsFocused = false
                   }
                }
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
