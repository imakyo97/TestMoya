//
//  MyService.swift
//  TestMoya
//
//  Created by 今村京平 on 2022/02/26.
//

import Foundation
import Moya

enum MyService {
    case getWeather(city: String)
}

extension MyService: TargetType {
    var baseURL: URL {
        URL(string: "https://api.openweathermap.org/data/2.5")!
    }

    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getWeather:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getWeather(let city):
            let appId = "9f3ab1e7ced559d013692e82ff4f65ea"
            let unit = "metric"
            let lang = "ja"
            return .requestParameters(parameters: ["q": city, "appid": appId, "units": unit, "lang": lang], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
