//
//  HomeView.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = FavoriteViewModel()
    var courses:[Course]
    var body: some View {
        List(courses,id:\.id) { item in
            
            NavigationLink(item.courseName, destination: CourseDetails(course: item, preRequisite: item.preRequest.components(separatedBy: ",")))
                .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                    Button(role: .destructive, action: {
                        viewModel.shouldAddCourseToFavorite(course: item)
                    } ) {
                        
                        Label("Add", systemImage: "plus")
                        
                    }.tint(Color.green)
                })
            
        }
        .navigationTitle(LocalizedStringKey("Home"))
        .alert(item:$viewModel.alertItem){ alert in
            Alert(title: alert.title, message: alert.body, dismissButton: alert.dissmissButton)
            
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(courses: AllFaculties.initFaculties()[0].majors[0].courses)
    }
}
