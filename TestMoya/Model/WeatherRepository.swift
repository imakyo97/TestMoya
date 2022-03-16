//
//  WeatherRepository.swift
//  TestMoya
//
//  Created by 今村京平 on 2022/02/26.
//

import Foundation
import Moya

typealias CompletionHandler<T> = (Result<T,MoyaError>) -> Void

final class WeatherRepository {
    private let provider = MoyaProvider<MyService>(plugins: [NetworkLoggerPlugin()])

    func getWeathreData(city: String, completion: @escaping CompletionHandler<WeatherData>) {
        provider.request(.getWeather(city: city)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                completion(self.decodeResponseToWeatherData(response: response))
            case let .failure(moyaError):
                completion(.failure(moyaError))
            }
        }
    }

    private func decodeResponseToWeatherData(response: Response) -> Result<WeatherData, MoyaError> {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let response = try response.filterSuccessfulStatusAndRedirectCodes()
            let weatherData = try response.map(WeatherData.self, using: decoder)
            return .success(weatherData)
        } catch let error {
            let moyaError = error as! MoyaError
            return .failure(moyaError)
        }
    }
}
