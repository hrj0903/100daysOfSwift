import SwiftUI

struct ContentView: View {
    @State private var srcUnit = 0
    @State private var dstUnit = 1
    @State private var srcValue = "0"
    private let units = ["Celsius", "Fahrenheit", "Kelvin"]
    private var toKelvin = ["Celsius": celsiusToKelvin, "Fahrenheit": degreesToKelvin, "Kelvin": identity]
    private var fromKelvin = ["Celsius": kelvinToCelsius, "Fahrenheit": kelvinToDegrees, "Kelvin": identity]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert from")) {
                    TextField("Temperature", text: $srcValue)
                    Picker("Source units", selection: $srcUnit) {
                        ForEach(0 ..< units.count) {
                            Text(units[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Convert to")) {
                    Picker("Destination units", selection: $dstUnit) {
                        ForEach(0 ..< units.count) {
                            Text(units[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Text("\(convertedValue, specifier: "%.2f") \(units[dstUnit])")
                }
            }
            .navigationTitle("Converter")
        }
    }

    var convertedValue: Double {
        let srcTemp = Double(srcValue) ?? 0
        let kelvTemp = toKelvin[units[srcUnit]]!(srcTemp)
        let dstTemp = fromKelvin[units[dstUnit]]!(kelvTemp)
        return dstTemp
    }

}

func celsiusToKelvin(celsius: Double) -> Double {
    return celsius + 273
}
func degreesToKelvin(degrees: Double) -> Double {
    return (degrees - 32) * 5 / 9 + 273
}
func kelvinToDegrees(kelvin: Double) -> Double {
    return (kelvin - 273) * 9 / 5 + 32
}
func kelvinToCelsius(kelvin: Double) -> Double {
    return kelvin - 273
}
func identity(temp: Double) -> Double {
    return temp
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
