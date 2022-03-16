//
//  WeatherViewController.swift
//  TestMoya
//
//  Created by 今村京平 on 2022/02/26.
//

import UIKit

final class WeatherViewController: UIViewController {
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var tempMaxLabel: UILabel!
    @IBOutlet private weak var tempMinlabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var humidtyLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var cityTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherData(city: "Tokyo")
    }

    @IBAction private func didTapEnterButton(_ sender: Any) {
        getWeatherData(city: cityTextField.text!)
    }

    private func getWeatherData(city: String) {
        let weatherRepository = WeatherRepository()
        weatherRepository.getWeathreData(city: city) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherData):
                self.showWeatherData(weatherData: weatherData)
            case .failure(let moyaError):
                print(moyaError.localizedDescription)
            }
        }
    }

    private func showWeatherData(weatherData: WeatherData) {
        cityLabel.text = weatherData.name
        weatherImageView.image = UIImage(named: weatherData.weather.last!.icon)
        weatherLabel.text = weatherData.weather.last!.description
        tempMaxLabel.text = "\(weatherData.main.tempMax)"
        tempMinlabel.text = "\(weatherData.main.tempMin)"
        tempLabel.text = "\(weatherData.main.temp)"
        humidtyLabel.text = "\(weatherData.main.humidity)"
        pressureLabel.text = "\(weatherData.main.pressure)"
    }
}
