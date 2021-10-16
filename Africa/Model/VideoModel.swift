//
//  VideoModel.swift
//  Africa
//
//  Created by Jack Pyo Toke on 12/10/21.
//

import SwiftUI

struct Video: Codable, Identifiable {
    let id: String
    let name: String
    let headline: String
    
    //Computed property
    var thumbnail: String {
        "video-\(id)"
    }
}
