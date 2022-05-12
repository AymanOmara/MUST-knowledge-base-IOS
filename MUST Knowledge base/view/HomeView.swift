//
//  HomeView.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI

struct TabBarView:View{
    var courses:[Course]
    var body: some View{
        TabView{
            HomeView(courses: courses)
                .tabItem {
                    Image(systemName: "house")
                    
                    Text(LocalizedStringKey("Home"))
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                    
                    Text(LocalizedStringKey("Favorite"))
                }
        }
    }
}


struct HomeView: View {
    @StateObject var viewModel = FavoriteViewModel()
    @State var dark = false
    @State var show = false
    var courses:[Course]
    var body: some View {
        
        
        let drag = DragGesture()
            .onEnded { _ in
                withAnimation(.default){
                    show.toggle()
                }
                
            }
        
        return  ZStack(alignment: .leading){
            
            
            GeometryReader{_ in
                VStack{
                    ZStack{
                        Button(action: {
                            show.toggle()
                            withAnimation(.default){
                            }
                        }) {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .renderingMode(.original)
                                .frame(width: 20, height: 20)
                            
                            Spacer()
                            
                        }
                        HStack{
                            Text("Home")
                        }
                        
                    }
                    .padding()
                    .foregroundColor(.primary)
                    .overlay(Rectangle().stroke(Color.primary.opacity(0.1),lineWidth: 1).shadow( radius: 3).edgesIgnoringSafeArea(.top))
                    Spacer()
                    List(courses,id:\.id) { item in
                        
                        NavigationLink(item.courseName, destination: CourseDetails(course: item, preRequisite: item.preRequest.components(separatedBy: ",")),isActive: $dark)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true, content: {
                                Button(role: .destructive, action: {
                                    viewModel.shouldAddCourseToFavorite(course: item)
                                } ) {
                                    
                                    Label("Add", systemImage: "plus")
                                    
                                }.tint(Color.green)
                            })
                        
                            .navigationTitle("Courses")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    
                    Spacer()
                    
                }
            }
            
            
            HStack{
                Menu(dark: $dark, show: $show)
                    .preferredColorScheme(dark ? .dark : .light)
                    .offset(x:self.show ? 0 : -UIScreen.main.bounds.width / 1.5)
                Spacer(minLength: 0)
                
            }
            .background(Color.primary.opacity(self.show ? (self.dark ? 0.05 : 0.2): 0).edgesIgnoringSafeArea(.all))
            
            
        }
        //        .gesture(drag)
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
struct Menu:View{
    @Binding var dark: Bool
    @Binding var show: Bool
    var  body: some View{
        
        VStack{
            HStack{
                Button(action: {
                    
                    withAnimation(.default){
                        show.toggle()
                    }
                }){
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 12, height: 20)
                    
                    
                }
                Spacer()
                
            }
            
            Image("must_logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            HStack(spacing:10){
                Button(action: {
                    dark.toggle()
                    UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = self.dark ? .dark : .light
                }) {
                    
                    Image(systemName: "moon.fill")
                        .font(.title)
                    Spacer()
                    Text("Dark mode")
                    
                    //                    Spacer()
                    
                }
                Toggle("",isOn: $dark)
                    .frame(width: 60)
                    .padding(0)
                    .onTapGesture {
                        dark.toggle()
                    }
                
            }
            HStack(spacing:10){
                Button(action: {}){
                    Image(systemName: "globe.badge.chevron.backward")
                        .font(.title)
                    
                    Text("change language")
                    Spacer()
                }
                
            }.padding(.top,10)
            
            Divider()
            Group{
                Button(action: {}) {
                    HStack(spacing:22){
                        Image("image")
                            .resizable()
                            .frame(width: 25, height: 28)
                        
                        Text("chats")
                        Spacer()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .foregroundColor(.primary)
        .padding(.horizontal,20)
        .padding([.top],25)
        .frame(width: UIScreen.main.bounds.width / 1.5)
        .background((self.dark ? Color.black : Color.white  ))
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2),lineWidth: 2).shadow( radius: 3)).edgesIgnoringSafeArea(.all)
        
    }
    
}
