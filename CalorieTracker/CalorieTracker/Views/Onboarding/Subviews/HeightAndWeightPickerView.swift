//
//  HeightAndWeightPickerView.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 22/02/2025.
//

import SwiftUI

struct HeightAndWeightPickerView: View {
    //MARK: - States
    @State private var isMetric = false
    @State private var selectedFeet = 5
    @State private var selectedInches = 6
    @State private var selectedWeightLb = 120
    @State private var selectedHeightCm = 167
    @State private var selectedWeightKg = 54
    @Binding var data: HeightWeightData?

    //MARK: -
    let feetRange = Array(1...8)
    let inchesRange = Array(0...11)
    let weightRangeLb = Array(50...700)
    
    let heightRangeCm = Array(60...243)
    let weightRangeKg = Array(20...360)
    
    //MARK: - View assembling
    var body: some View {
        VStack {
            unitSystemToggleView
        
            HStack {
                heightPickerView
                
                Spacer()

                weightPickerView
            }
            .padding()
        }
        .onAppear() {
            setData()
        }
        .onChange(of: isMetric) { _, _ in
            saveData()
        }
    }
    
    private var unitSystemToggleView: some View {
        HStack(spacing: 16) {
            Text("Imperial")
                .foregroundColor(isMetric ? .gray: .black)
                .font(.title2).bold()
            
            Toggle("", isOn: $isMetric)
                .labelsHidden()
                .tint(Color.text.introTitle)
            
            Text("Metric")
                .foregroundColor(!isMetric ? .gray : .black)
                .font(.title2).bold()
        }
        .padding()
    }
    
    private var heightPickerView: some View {
        VStack {
            Text("Height")
                .font(.title2).bold()
            
            if !isMetric {
                HStack(spacing: 10) {
                    Picker("Feet", selection: $selectedFeet) {
                        ForEach(feetRange, id: \.self) {
                            Text("\($0) ft")
                        }
                    }
                    .frame(width: 80)
                    .clipped()
                    .pickerStyle(.wheel)
                    .onChange(of: selectedFeet) { _, _ in
                        saveData()
                    }

                    Picker("Inches", selection: $selectedInches) {
                        ForEach(inchesRange, id: \.self) {
                            Text("\($0) in")
                        }
                    }
                    .frame(width: 80)
                    .clipped()
                    .pickerStyle(.wheel)
                    .onChange(of: selectedInches) { _, _ in
                        saveData()
                    }
                }
            } else {
                Picker("Height", selection: $selectedHeightCm) {
                    ForEach(heightRangeCm, id: \.self) {
                        Text("\($0) cm")
                    }
                }
                .frame(width: 170)
                .clipped()
                .pickerStyle(.wheel)
                .onChange(of: selectedHeightCm) { _, _ in
                    saveData()
                }
            }
        }
    }
    
    private var weightPickerView: some View {
        VStack {
            Text("Weight")
                .font(.title2).bold()
            
            if !isMetric {
                Picker("Weight", selection: $selectedWeightLb) {
                    ForEach(weightRangeLb, id: \.self) {
                        Text("\($0) lb")
                    }
                }
                .frame(width: 170)
                .clipped()
                .pickerStyle(.wheel)
                .onChange(of: selectedWeightLb) { _, _ in
                    saveData()
                }
            } else {
                Picker("Weight", selection: $selectedWeightKg) {
                    ForEach(weightRangeKg, id: \.self) {
                        Text("\($0) kg")
                    }
                }
                .frame(width: 170)
                .clipped()
                .pickerStyle(.wheel)
                .onChange(of: selectedWeightKg) { _, _ in
                    saveData()
                }
            }
        }
    }
    
    //MARK: - Actions
    
    func setData() {
        if let data {
            if data.unitSystem == .imperial {
                selectedFeet = Int(data.height) / 12
                selectedInches = Int(data.height) % 12
                selectedWeightLb = Int(data.weight)
            } else {
                selectedHeightCm = Int(data.height)
                selectedWeightKg = Int(data.weight)
            }
        }
    }

    func saveData() {
        if !isMetric {
            let height = Double(selectedFeet * 12 + selectedInches)
            let weight = Double(selectedWeightLb)
            self.data = HeightWeightData(unitSystem: .imperial, height: height, weight: weight)
        } else {
            let height = Double(selectedHeightCm)
            let weight = Double(selectedWeightKg)
            self.data = HeightWeightData(unitSystem: .imperial, height: height, weight: weight)
        }
    }
}

#Preview {
    HeightAndWeightPickerView(data: .constant(.init(unitSystem: .metric, height: 170, weight: 70)))
}
