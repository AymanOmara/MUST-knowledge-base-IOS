//
//  PDFView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import SwiftUI

struct ReferenceView: View {
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
                    .frame(width: 100, height: 100, alignment: .center)
            }
            
        }.onAppear{
            repo.getDataFromURL(url: URL(string: url)!, complition: { progress in
                self.data = progress
                self.isDone = true
            })
        }
    }
        
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        ReferenceView(url: "")
    }
}
