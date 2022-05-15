//
//  WelcomeView.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI

struct WelcomeView: View {
    @State var isAnimationActive = true
    @ObservedObject private var isDarkMode = UserSettings()
    var body: some View {
        VStack{
            if isAnimationActive{
                LottieAnimationView(fileName: "book")
            }else{
                FacultyView(faculties: AllFaculties.initFaculties())
            }
        }
        .onAppear {
            changeAppearanceMode()
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                withAnimation{
                    isAnimationActive = false
                }
            }
        }
    }
    func changeAppearanceMode(){
        UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = isDarkMode.username ? .dark : .light
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
                Text(LocalizedStringKey("introduction"))
                    .padding(.horizontal,5)
                Spacer()
                
                    .navigationBarHidden(true)
                
                ScrollView{
                    
                    LazyVGrid(columns: columns,spacing: 10) {
                        ForEach(faculties){ faculty in
                            FacultyCell(faculty: faculty)
                        }
                    }.padding(.horizontal, 5)
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
        .background(Color.white)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 2)
        .padding(.horizontal,2)
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
