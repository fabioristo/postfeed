//
//  ErrorType.swift
//  PostFeed
//
//  Created by Fabio Ristoratore on 17/02/23.
//

import Foundation

enum ErrorType: Error {
    case badUrl
    case responseError
    case unauthorized
}
