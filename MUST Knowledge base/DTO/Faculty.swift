//
//  Faculty.swift
//  MUST Knowledge base
//
//  Created by Ayman on 10/05/2022.
//

import SwiftUI
struct Faclty:Identifiable{
    let id = UUID()
    let imageName,facultyName:String
    let majors:[Major]
}
struct Major:Identifiable{
    var id = UUID()
    let majorName:String
    let courses:[Course]
}

class Course:Identifiable{
    var id = UUID()
    var isRecent = false
    var courseName:String = ""
    var courseCode:String = ""
    var courseDescription:String = ""
    var level:String = ""
    var refreces:String = ""
    var preRequest:String = ""
    init(courseName:String, courseCode:String, courseDescription:String, level:String, refreces:String, preRequest:String){
        self.courseName =  courseName
        self.courseCode = courseCode
        self.courseDescription = courseDescription
        self.level = level
        self.preRequest = preRequest
        self.refreces = refreces
    }
    init(){}
}
