//
//  PDFView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import SwiftUI

struct MYpdf: View {
    var url:String
    var repo = Repo()
    @State var data:Data?
    @State var isDone = false
    var body: some View {
        ZStack{
            if isDone{
                PDFKitRepresentedView(data!)
            }else{
                ProgressView()
            }
            
        }.onAppear{
            print(url)
            repo.getDataFromURL(url: URL(string: url)!, complition: { progress in
                self.data = progress
                self.isDone = true
            })
        }
    }
        
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        MYpdf(url: "")
    }
}
