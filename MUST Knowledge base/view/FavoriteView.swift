//
//  FavoriteView.swift
//  MUST Knowledge base
//
//  Created by ARG on 12/05/2022.
//

import SwiftUI

struct FavoriteView: View {
    @StateObject private var viewModel = FavoriteViewModel()
    @State var isEmpty = false
    
    var body: some View {
        if isEmpty{
            LottieView(fileName: "empty")
                .frame(width: 300, height: 300, alignment: .center)
        }else{
            List(viewModel.courses,id:\.id) { item in
                FavoriteCell(viewModel: viewModel, item: item)
                
                    .navigationTitle("Courses")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear{
                viewModel.getAllCourses()
            }
        }

        

    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()

    }
}
struct FavoriteCell:View{
    enum Action {
        case view
        case edit
    }
    @State private var isActive = false
    @State private var action: Action?
    
    var viewModel:FavoriteViewModel
    var item:Course
    var body: some View{
        NavigationLink(item.courseName, destination: CourseDetails(course: item, preRequisite: item.preRequest.components(separatedBy: ",")), isActive: $isActive)
            .swipeActions(edge: .leading, allowsFullSwipe: true, content: {
                Button(role: .destructive, action: {
                    action = .edit
                    // specific action
                    //isActive = false
                    viewModel.removeCourse(course: item)
                } ) {
                    Label("Delete", systemImage: "trash")
                }
            })
        
            .onChange(of: isActive) {
                if !$0 {
                    action = nil  // reset back
                }
            }
        
        
    }

}
