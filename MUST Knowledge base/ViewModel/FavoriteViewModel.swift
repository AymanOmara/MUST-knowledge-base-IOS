//
//  FavoriteViewModel.swift
//  MUST Knowledge base
//
//  Created by Ayman Omara on 11/05/2022.
//

import Foundation
import SwiftUI
import Combine
final class FavoriteViewModel:ObservableObject,FavoriteViewModelContracts{
    var localModel: LocalModel = LocalModel.shared
    @Published var courses:[Course] = []
    @Published var alertItem:AlertItem?
    var subscriber:Set<AnyCancellable> = []
    func shouldAddCourseToFavorite(course:Course){
        localModel.shouldAddItem(course: course).sink {[weak self] value in
            guard let self = self else{return}
            
            if value{
                self.alertItem = AlertContext.addedSuccessfully
            }else{
                self.alertItem = AlertContext.exsitBefore
            }
        }.store(in: &subscriber)
    }
    func getAllCourses() {
        localModel.getAllCourses().sink {completion in
            
            switch completion{
            case .failure(let error):
                print(error.localizedDescription)
            case .finished:
                break
            }
        } receiveValue: {[weak self] values in
            guard let self = self else{return}
            if let values = values{
                self.courses = values
            }else{
                
            }
            
        }.store(in: &subscriber)
        
    }
    func removeCourse(course:Course){
        let index = courses.firstIndex(where: {it in course.courseCode == it.courseCode})!
        courses.remove(at: index)

        localModel.removeCourseByID(courseIndex: index)

        getAllCourses()
    }
    
}
protocol FavoriteViewModelContracts:ObservableObject{
    var localModel:LocalModel{get}
    func shouldAddCourseToFavorite(course:Course)
    func getAllCourses()
}
enum AlertContext{
    static let exsitBefore = AlertItem(title: Text(LocalizedStringKey("Error")), body: Text(LocalizedStringKey("isbefore")), dissmissButton: .cancel())
    static let addedSuccessfully = AlertItem(title: Text(LocalizedStringKey("Done")), body: Text(LocalizedStringKey("addedd")), dissmissButton: .cancel())
}
struct AlertItem:Identifiable{
    var id = UUID()
    var title:Text
    var body:Text
    var dissmissButton:Alert.Button?
}
