//
//  StringCell.swift
//  MUST Knowledge base
//
//  Created by ARG on 12/05/2022.
//

import SwiftUI

struct StringListView:View{
    var title:String
    var body: some View{
        HStack{
            Text(title)
        }
    }
}


struct StringCell_Previews: PreviewProvider {
    static var previews: some View {
        StringListView(title: "Hello brothers dont worry with indain guy sound")
    }
}
