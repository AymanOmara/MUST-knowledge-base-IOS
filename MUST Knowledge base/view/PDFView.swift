//
//  PDFView.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 13/05/2022.
//

import SwiftUI

struct PDFView: View {
    var url:String
    var repo = Repo()
    var body: some View {
        
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                print(url)
                repo.getDataFromURL(URL: URL(string: url)!, complition: { progress in
                    print(progress)
                    
                })
            }
    }
        
}

struct PDFView_Previews: PreviewProvider {
    static var previews: some View {
        PDFView(url: "")
    }
}
