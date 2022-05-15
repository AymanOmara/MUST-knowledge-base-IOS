//
//  MajorsView.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI

struct MajorsView: View {
    var majors:[Major]
    var body: some View {
        List(majors,id:\.id) { item in
            NavigationLink(destination: TabBarView(courses: item.courses)) {
                StringListView(title: item.majorName)
                
            }
            
        }
        .navigationTitle("Majors")
    }
}

struct MajorsView_Previews: PreviewProvider {
    static var previews: some View {
        MajorsView(majors: AllFaculties.initFaculties()[0].majors)
    }
}
