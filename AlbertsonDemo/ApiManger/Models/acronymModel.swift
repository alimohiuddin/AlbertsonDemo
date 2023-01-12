//
//  acronymModel.swift
//  AlbertsonDemo
//
//  Created by Ali Mohiuddin on 11/01/23.
//

import Foundation


struct acronymModel : Codable{
    
    let sf : String?
    let lfs : [acronymDataLayer]?
}

struct acronymDataLayer : Codable{
    let lf : String?
    let freq : Int?
    let since : Int?
    let vars : [VarsData]?
}

struct VarsData : Codable{
    let lf : String?
    let freq : Int?
    let since : Int?
}
