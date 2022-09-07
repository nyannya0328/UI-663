//
//  Home.swift
//  UI-663
//
//  Created by nyannyan0328 on 2022/09/07.
//

import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

struct Home: View {
    @EnvironmentObject var model : LockScreenViewModel
    var body: some View {
        VStack{
            
            
            if let compressedImage = model.compressedImage{
                
                GeometryReader{proxy in
                    let size = proxy.size
                    
                    Image(uiImage: compressedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width,height: size.height)
                        .overlay {
                            
                            
                            TimeView()
                                .environmentObject(model)
                               
                        }
                        .scaleEffect(model.scale)
                       
                    
                }
                
            
                
            }
            else{
                
                PhotosPicker(selection: $model.pickedItem,matching: .images,preferredItemEncoding: .automatic,photoLibrary : .shared()) {
                    
                    VStack(spacing:23){
                        
                         Image(systemName: "plus.viewfinder")
                            .font(.title)
                        
                        Text("Add to Image")
                    }
                    .foregroundColor(.primary)
                    
                }
                
            }
            
        }
        .ignoresSafeArea()
        .overlay(alignment: .topLeading) {
            
            
            Button("Cancel"){
                
                withAnimation(.easeInOut(duration: 2)){
                    
                    model.compressedImage = nil
                    model.scale = 1
                }
                
            }
            .foregroundColor(.primary)
            .padding(.vertical,15)
            .padding(.horizontal,15)
            .background{
             
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.ultraThickMaterial)
            }
            .opacity(model.compressedImage == nil ? 0 : 1)
            .padding(.leading,15)
        }
        
      
       
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimeView : View{
    
    @EnvironmentObject var model : LockScreenViewModel
    var body: some View{
        
        HStack(spacing:10){
            
            Text(Date.now.convertToString(.hour))
                .font(.system(size: 95).weight(.heavy))
            
            
            VStack(spacing:13){
                
                
                Circle()
                    .fill(.white)
                     .frame(width: 15,height: 15)
                
                
                Circle()
                    .fill(.white)
                     .frame(width: 15,height: 15)
                
            }
            
            Text(Date.now.convertToString(.min))
                .font(.system(size: 95).weight(.heavy))
            
            Text(Date.now.convertToString(.sec))
                .font(.system(size: 95).weight(.heavy))
                
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .padding(.top,130)
        
    }
}

enum DateFormat : String{
    
    case hour = "hh"
    case min = "mm"
    case sec = "ss"
}

extension Date{
    
    func convertToString(_ format : DateFormat) -> String{
        
        let formattter = DateFormatter()
        formattter.dateFormat = format.rawValue
        
        return formattter.string(from: self)
    }
}
