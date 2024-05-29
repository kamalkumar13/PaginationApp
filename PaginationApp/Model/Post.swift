//
//  Post.swift
//  PaginationApp
//
//  Created by Kamal Kumar on 29/05/24.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
