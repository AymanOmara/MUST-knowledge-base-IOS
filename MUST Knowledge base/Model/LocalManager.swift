//
//  LocalManager.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import CoreData
import Combine
class LocalModel:BaseLocalModel{
    
    
    var subscriber =  Set<AnyCancellable>()
    
    static let shared = LocalModel()
    
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MUST_Knowledge_base")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    func shouldAddItem(course: Course) -> AnyPublisher<Bool, Never>{
        return Deferred{
            Future{[weak self] promise in
                guard let self = self else{return}
                
                self.getAllCourses().sink { complition in
                    
                } receiveValue: { courses in

                    if courses?.first(where: { it in it.courseCode == course.courseCode}) != nil{
                        promise(.success(false))
                    }else{
                        self.addItem(course: course)
                        promise(.success(true))
                    }
                }.store(in: &self.subscriber)
            }
        }.eraseToAnyPublisher()
        
    }
    private func addItem(course:Course) {
        let newItem = Item(context: container.viewContext)
        
        newItem.name = course.courseName
        newItem.id = course.courseCode
        newItem.courseDescription = course.courseDescription
        newItem.prerequisite = course.preRequest
        newItem.refreces = course.refreces
        newItem.level = course.level
            
        do {
            try container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func getAllCourses()-> AnyPublisher<[Course]?, Error> {
        return Deferred {
            Future {[weak self] promise in
                guard let self = self else{return}
                let featchRequest:NSFetchRequest<Item> = Item.fetchRequest()
                do{
                    let data = try self.container.viewContext.fetch(featchRequest).publisher.map{(item)  in
                        
                        return Course(courseName: item.name!, courseCode: item.id!, courseDescription: item.courseDescription!, level: item.level!, refreces: item.refreces!, preRequest: item.prerequisite!)
                        
                    }
                    promise(.success(data.sequence))
                }catch{
                    promise(.failure(error))
                }
            }
            
        }.eraseToAnyPublisher()
        
        
    }
    func removeAllFavoriteCourses(){
        let featchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        do{
            let data = try container.viewContext.fetch(featchRequest).publisher.map{(item)  in
                
                container.viewContext.delete(item)
            
//                return Course(courseName: item.name!, courseCode: item.id!, courseDescription: item.courseDescription!, level: item.level!, refreces: item.refreces!, preRequest: item.prerequisite!)
                
            }
           try container.viewContext.save()
//            promise(.success(data.sequence))
        }catch{
//            promise(.failure(error))
        }
        
    }
    func removeCourseByID(courseIndex:Int){
        let featchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        do{
           let v =  try container.viewContext.fetch(featchRequest)
            for (index, element) in v.enumerated(){
                if index == courseIndex{
                    container.viewContext.delete(element)
                    do {
                        try container.viewContext.save()
                    } catch {
                        // Replace this implementation with code to handle the error appropriately.
                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                    }
                }
            }
            
        }catch{
            
        }
//        for (index, element) in container.viewContext.fetch(featchRequest.enumerated()) {}
//        container.viewContext.fetch(featchRequest).map { item in
//            c
//        }
//        container.viewContext.fetch(featchRequest).remove(at: index)
//        container.viewContext.delete(<#T##object: NSManagedObject##NSManagedObject#>)
//        featchRequest
//        getAllCourses().sink { _ in
//
//        } receiveValue: { courses in
//            var v = courses?.firstIndex(where: { it in
//                it.courseCode == course.courseCode
//            })
//
//
//        }.store(in: &subscriber)

//        let newItem = Item(context: container.viewContext)
//        newItem.name = course.courseName
//        newItem.id = course.courseCode
//        newItem.courseDescription = course.courseDescription
//        newItem.prerequisite = course.preRequest
//        newItem.refreces = course.refreces
//        newItem.level = course.level
//        container.viewContext.delete(Item[1])
//        container.viewContext.delete(newItem)
        //container.viewContext
        do {
            try container.viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
//    func unfavorite(_ item: Item) {
//        viewContext.delete(item)
//        try? viewContext.save()
//    }
    
}
protocol BaseLocalModel{
    func getAllCourses()-> AnyPublisher<[Course]?, Error>
    func shouldAddItem(course:Course)->AnyPublisher<Bool,Never>
    
}
