//
//  ContentView.swift
//  UI-663
//
//  Created by nyannyan0328 on 2022/09/07.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model : LockScreenViewModel = .init()
    var body: some View {
       Home()
            .environmentObject(model)
            .gesture(
            
                MagnificationGesture(minimumScaleDelta: 0.01)
                    .onChanged({ value in
                        
                        model.scale = value + model.lastScale
                        
                        
                    })
                    .onEnded({ value in
                        
                        if model.scale < 1{
                            
                            
                            withAnimation(.easeInOut(duration: 0.2)){
                                
                                model.scale = 1
                                
                            }
                            
                        }
                        else{
                            model.scale = 1
                        }
                        
                        model.lastScale = model.scale - 1
                        
                    })
            
            
            )

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
