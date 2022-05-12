//
//  FavoriteView.swift
//  MUST Knowledge base
//
//  Created by ARG on 12/05/2022.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    var body: some View {
        List(viewModel.courses,id:\.id) { item in
            StringListView(title: item.courseName)
                .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                    Button(role: .destructive, action: {
//                        viewModel.courses.remove(at: 1)
                        //viewModel.removeCourse(course: item)
                        viewModel.removeCourse(course: item)
                    } ) {
                      Label("Delete", systemImage: "trash")
                    }
                })
                
//            NavigationLink(destination: CourseDetails(course: item, preRequisite: item.preRequest.components(separatedBy: ","))) {
//
//
//            }
            .navigationTitle("Courses")
            .navigationBarTitleDisplayMode(.inline)
            
        
            
        }
        
        .onAppear{
            viewModel.getAllCourses()
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
