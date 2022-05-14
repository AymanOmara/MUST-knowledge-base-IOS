//
//  CourseDetails.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI
import Combine
struct CourseDetails: View {
    
    var course:Course
    var preRequisite:[String]
    
    
    var body: some View {
        VStack(alignment: .center){
            Header(course:course)
                .padding([.leading,.top],5)
            Divider()
            
            HStack{
                Text(LocalizedStringKey("prerequisite"))
                    .padding(.leading,5)
                
                ScrollView(.horizontal,showsIndicators: false){
                    
                    HStack(spacing:10){
                        
                        ForEach(preRequisite) {item in
                            
                            PrerequizstItem(name: item)
                                .padding(.vertical,10)
                                .padding(.leading,3)
                        }
                        
                    }
                }
            }
            Divider()

                Text(LocalizedStringKey("courseDescription"))
                    .padding(.leading)
            
            CourseDescription(courseDescription: course.courseDescription)
            Divider()
            NavigationLink(LocalizedStringKey("references"), destination: ReferenceView(url: course.refreces))
                .cornerRadius(20)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity,maxHeight: 30)
                .background(Color.blue)
                .padding(.horizontal)
                
            
            Spacer()
            
        }
        
        
        
    }
}
struct CourseDescription:View{
    var courseDescription:String
    var body: some View{
        Text(courseDescription)
            .cornerRadius(10)
            .padding(.horizontal,8)
            .padding(.vertical,10)
            .background(.white)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 2)
            
    }
}
struct Header:View{
    var course:Course
    @StateObject var viewModel = FavoriteViewModel()
    
    var body: some View{
        HStack(alignment: .top){
            VStack(alignment:.leading){
                Text(course.courseName)
                Text(course.courseCode)
                Text("Level \(course.level)")

            }
            Spacer()
            
            HStack(alignment:.bottom){
                Image(systemName: "suit.heart.fill")
                    .frame(width: 40, height: 40, alignment: .bottom)
                    .padding(.bottom,0)
                    .onTapGesture {
                        viewModel.shouldAddCourseToFavorite(course: course)
                    }
                Image("must_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.horizontal,0)
                    .padding(.bottom,0)
            }
            
            
        }
        .alert(item:$viewModel.alertItem){ alert in
            Alert(title: alert.title, message: alert.body, dismissButton: alert.dissmissButton)
            
        }
    }
}

struct CourseDetails_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetails(course: AllFaculties.initFaculties()[0].majors[0].courses[0],preRequisite: AllFaculties.initFaculties()[0].majors[0].courses[0].preRequest.components(separatedBy: ","))
    }
}
struct PrerequizstItem:View{
    var name:String
    var body: some View{
        VStack{
            Section{
                Text(name)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 2)
            }
        }
    }
}
extension String:Identifiable{
    public var id:UUID{
        return UUID()
    }
}
