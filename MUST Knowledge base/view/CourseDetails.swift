//
//  CourseDetails.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI

struct CourseDetails: View {
    
    var course:Course
    var preRequisite:[String]
    
    var body: some View {
        VStack(alignment: .leading){
            Header(courseName: course.courseName, courseCode: course.courseCode,courseLevel: course.level)
                .padding([.leading,.top],5)
            Divider()
            
            HStack{
                Text("Pre req")
                
                ScrollView(.horizontal,showsIndicators: false){
                    
                    HStack(spacing:10){
                        
                        ForEach(0..<preRequisite.count) {index in
                        
                            PrerequizstItem(name: preRequisite[index])
                        }
                        
                    }
                }
            }
            Divider()
            
            Spacer()
            
        }
        .onAppear{
            
        }
    }
}
struct Header:View{
    @State private var isActive = false
    var courseName:String
    var courseCode:String
    var courseLevel:String
    var body: some View{
        HStack(alignment: .top){
            VStack(alignment:.leading){
                Row(title: "Course Name", value: courseName)
                Row(title: "Course Code", value: courseCode)
                Row(title: "level", value: courseLevel)
            }
            Spacer()
            
            HStack(alignment:.bottom){
                Image(systemName: "suit.heart.fill")
                    .frame(width: 40, height: 40, alignment: .bottom)
                    .onTapGesture {
                        isActive = true
                    }
                Image("must_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .padding(.horizontal,0)
            }
            
            
        }
        .alert("Hello", isPresented: $isActive) {
            Button("Ok",role: .cancel){
                isActive = false
            }
        }
    }
}
struct Row:View{
    var title,value:String
    var body: some View{
        HStack(alignment: .top){
            Text(title)
                .font(.caption2)
            Text(value)
                .font(.caption2)
            Spacer()
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
                    .background(.red)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.6), radius: 10, x: 6, y: 6)
                    .foregroundColor(Color.white)
            }
        }
    }
}
