
import SwiftUI

//Struct que representa la pantalla principal de la app. Muestra contenido de pantalla
struct ContentView: View {
//    Variables que hacen la interfaz se actualice automaticamente. el checkamount es el monto total de la cuenta y el @State dice: Vigila esta variable por si cambia
    @State private var checkAmount = 0.0
//
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
//    PAra saber si el campo de texto (TextFied) está activo o ono (Si el reclado está abierto=
    @FocusState private var amountIsFocused: Bool
//Lista propinas
    let tipPercentages = [0, 10, 15, 20, 25]
//numOfPeople inicia en 2, pero se suma 2. (relacionada con el PICKER). Se vuelve Double para hacer calculos decimales
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
//        Porcentaje a   decimal
        let tipSelection = Double(tipPercentage)
//Caclula cuanto es de propina
        let tipValue = checkAmount / 100 * tipSelection
//        Cuenta más propina
        let grandTotal = checkAmount + tipValue
//        Se divide entre las personas
        let amountPerPerson = grandTotal / peopleCount

//        Regresa el resultado final Se usa para mostrarlo en pantalla
        return amountPerPerson
    }

//    Se define como se ve la app
        var body: some View{
//            Navegación para titulo y más pantallas
            NavigationStack{
            Form{
//                El TEXTFIELD es el campo donde se escribe la cantidad. Cantidad es el texto que aparece; value: $checkAmount modifica la variable CHECKAMOUNT cin ki que el usuario escriba. El $ significa ENLAZAR LA VARIABLE
                Section{
//                    format: .currency(...) muestra el valor en formato de dineros. Usa la moneda del dispositivo actual. si no se obtiene usa MXN como predetminado
                    TextField("Cantidad", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "MXN"))
//                    Muestra teclado núm con decimales
                        .keyboardType(.decimalPad)
//                    Enlaza el campo con la variable que controla si el teclado esta activo
                        .focused($amountIsFocused)

//                    PICKER: lista desplegable para elegir num personas; selection: $... lo que elijas aquí se guarda en numberOfPeople
                    Picker("Número de personas", selection: $numberOfPeople) {
//                        Crea opciones de 2 a 100 peronas. en el calculo peoplecount se hace numberofpeople +2. para comensar que se guarda como indice base
                        ForEach(2..<101) {
                            Text("\($0) personas")
                        }
                    }
//                    .pickerStyle(.navigationLink)
                }
                Section ("¿Cuánta propina quieres dejar?"){
//                    Picker de forma boton segmentado, Los porcentajes estan en tipPercentages, cada boton tiene el 10, 15,... lo que usuario elige se guarda en tippercentage
                    Picker("Porcentaje propina", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
//                    Se muestra resultado final que debe pagar cada pesona. el totalPerPerson, se calcula automaticamente. Se muestra en MXN por defecto
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "mxd"))
                }
            }
//                Pone titulo bonito :3
            .navigationTitle("La de Puebla")
//                Si campo de texto está activo (teclado abierto) muestra boton HECHO al presionar se cierra teclado  haciendo amountIsFocused = false
            .toolbar{
                if amountIsFocused{
                    Button("Hecho"){
                        amountIsFocused = false
                    }
                }
            }
        }

    }
}

#Preview {
    ContentView()
}




