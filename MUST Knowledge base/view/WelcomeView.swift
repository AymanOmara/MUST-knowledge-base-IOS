//
//  WelcomeView.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI

struct WelcomeView: View {
    @State var isAnimationActive = true
    
    var body: some View {
        VStack{
            if isAnimationActive{
                LottieAnimationView(fileName: "book")
            }else{
                FacultyView(faculties: AllFaculties.initFaculties())
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                withAnimation{
                    isAnimationActive = false
                }
            }
        }
    }
        
}
struct FacultyView:View{
    var faculties:[Faclty]
    private let columns:[GridItem] = [
        GridItem(.flexible(), spacing: 5, alignment: .center),
        GridItem(.flexible(), spacing: 5, alignment: .center)
    ]
    var body: some View{
        NavigationView{
            VStack{
                Text("MUST Knowledge Base contains all the information about all faculties of the university for all Majors and different levels. Where the user can choose the college and then search for the majors, then the courses to know all the details of the courses such as the name of the course, prerequisites, level and know the course reference, which makes him familiar enough with the course.")
                    .padding(.horizontal,5)
                Spacer()
                
                    .navigationBarHidden(true)
                
                ScrollView{
                    
                    LazyVGrid(columns: columns) {
                        ForEach(0..<faculties.count){ index in
                            FacultyCell(faculty: Faclty(imageName: faculties[index].imageName, facultyName: faculties[index].facultyName, majors: faculties[index].majors))
                            
                        }
                        .padding(.horizontal, 5)
                    }
                }
            }
        }
        
    }
}
struct LottieAnimationView:View{
    var fileName:String
    var body: some View{
        VStack{
            LottieView(fileName: fileName)
                .frame(width: 360, height: 360, alignment: .center)
        }
    }
}
struct FacultyCell:View{
    var faculty:Faclty
    @State private var isActive = false
    var body: some View{
        VStack{
            Image(faculty.imageName)
                .resizable()
                .frame(height: 120)
            Text(faculty.facultyName)
            

        }
        .background(
            NavigationLink(
                
                destination: MajorsView(majors: faculty.majors),isActive: $isActive, label: {
                    EmptyView()
                }
            )
        )
        .onTapGesture {
            isActive = true
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
