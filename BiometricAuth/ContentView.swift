//
//  ContentView.swift
//  BiometricAuth
//
//  Created by Jorge Luis Paillao on 14-06-22.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var auth = false
    
    var body: some View {
        VStack{
            Text(auth ? "estas autenticado" : "Necesitas Autenticarte").font(.title).bold()
            Button(auth ? "Cerrar" : "Autenticar") {
                if auth {
                    auth = false
                } else{
                    autentication()
                }
                
            }.buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .accentColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(auth ? Color.green : Color.red)
    }
    
    private func autentication(){
        var error: NSError?
        
        let laContext = LAContext()
        if
            laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Autentícate usando el sensor Biométrico") { autenticated, error in
                if autenticated{
                    auth = true
                }
            }
        } else{
            auth = true
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
