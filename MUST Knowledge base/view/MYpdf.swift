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
    var body: some View {
        PDFKitRepresentedView(data!)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                print(url)
                repo.getDataFromURL(URL: URL(string: url)!, complition: { progress in
//                    print(progress)
                    
                })
            }
    }
        
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        MYpdf(url: "")
    }
}
