//
//  ViewController.swift
//  PM_HW4
//
//  Created by Admin on 1/19/21.
//

import UIKit

class CityViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private let dateLabel = UILabel(title: "--.--")
    private let timeLabel = UILabel(title: "--:--", font: .systemFont(ofSize: 24))
    private let temperatureLabel = UILabel(title: "C°", font: .systemFont(ofSize: 50, weight: .semibold))
    private let weatherDescriptionLabel = UILabel(title: "-")
    private let humidityLabel = UILabel(title: "Humidity: -%")
    private let windSpeedLabel = UILabel(title: "Wind speed: - m/s")
    private let windDirectionLabel = UILabel(title: "Wind directions: -")
    
    private let sunStateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "01d.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leftTopStackView = UIStackView(arrangedSubviews: [dateLabel, timeLabel], axis: .vertical)
    private lazy var rightTopStackView = UIStackView(arrangedSubviews: [sunStateImageView, weatherDescriptionLabel],
                                                     axis: .vertical,
                                                     alignment: .center)
    
    private lazy var topStackView = UIStackView(arrangedSubviews: [leftTopStackView,
                                                                   temperatureLabel,
                                                                   rightTopStackView],
                                                axis: .horizontal,
                                                distribution: .fillEqually)
    
    private lazy var middleStackView = UIStackView(arrangedSubviews: [humidityLabel],
                                                   axis: .vertical,
                                                   alignment: .center)
    
    private lazy var bottomStackView = UIStackView(arrangedSubviews: [windSpeedLabel, windDirectionLabel],
                                                   axis: .horizontal,
                                                   distribution: .fillEqually)
    
    private lazy var currentWeatherStackView = UIStackView(arrangedSubviews: [topStackView,
                                                                              middleStackView,
                                                                              bottomStackView],
                                                           axis: .vertical)

    private let addCityTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search city by name"
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let searchCityWeatherButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .medium)
        button.addTarget(self, action: #selector(getWeather), for: .touchUpInside)
        
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    private let weatherManager = WeatherManager(networkService: NetworkService())
    private var forecast: Forecast? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let FORECAST_4_DAYS = 4
    private var cities = ["Kyiv", "Dnipro"]
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        if let city = cities.first {
            getCurrentWeather(city: city)
        }
    }
    
}

fileprivate extension CityViewController {
    
    func getCurrentWeather(city: String) {
        dateLabel.text = Date().toString(dateFormat: "dd/MM/yy")
        timeLabel.text = Date().toString(dateFormat: "hh:mm")
        title = city
        
        weatherManager.fetchCurrentWeatherWith(cityName: city) { forecast in
            self.forecast = forecast
            
            self.temperatureLabel.text = String(format: "%.0f", forecast.current.temp) + "°"

            if let icon = forecast.current.weather.first?.icon {
                let iconImage = WeatherConditionIconManager(rawValue: icon)
                self.sunStateImageView.image = iconImage.image
            }
            if let weatherDescription = forecast.current.weather.first?.description {
                self.weatherDescriptionLabel.text = weatherDescription
            }
            
            self.humidityLabel.text = "Humidity: \(forecast.current.humidity)%"
            self.windSpeedLabel.text = "Wind speed: " + String(format: "%.1f", forecast.current.windSpeed) + " m/s,    "

            let direction = "\(Int(forecast.current.windDegrees).windDirection())"
            self.windDirectionLabel .text = "  wind direction:  " + direction

        }
    }
    
    @objc func addToFavoriteCitiesAction() {
        guard let cityName = addCityTextField.text else { return }
        guard !cityName.isEmpty else { return }
        guard !cities.contains(cityName) else { return }
        
        cities.append(cityName)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    @objc private func getWeather() {
        guard let cityName = addCityTextField.text else { return }
        getCurrentWeather(city: cityName)
    }
    
}

// MARK: - Setup UI layout
fileprivate extension CityViewController {
    
    func setupUI() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(addToFavoriteCitiesAction))
        
        navigationItem.rightBarButtonItem = rightBarButton
        
        view.addSubview(addCityTextField)
        view.addSubview(searchCityWeatherButton)
        
        setupBackgroundImage()
        setupCurrentWeatherStackView()
        setupCollectionView()
        setupTableView()
    }
    
    func setupBackgroundImage() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "app_background")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    func setupCurrentWeatherStackView() {
        currentWeatherStackView.addBackgroundColor(color: .transparentBlack)
        temperatureLabel.minimumScaleFactor = 0.5
        weatherDescriptionLabel.numberOfLines = 0
        weatherDescriptionLabel.lineBreakMode = .byWordWrapping
        view.addSubview(currentWeatherStackView)
    }
    
    func setupCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.cellID)
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.backgroundColor = .transparentBlack
        view.addSubview(collectionView)
    }
    
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 56, height: 148)
        
        return layout
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "CityTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currentWeatherStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            currentWeatherStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            currentWeatherStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            currentWeatherStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.topAnchor.constraint(equalTo: currentWeatherStackView.bottomAnchor, constant: 30),
            collectionView.heightAnchor.constraint(equalToConstant: 166)
        ])
        
        NSLayoutConstraint.activate([
            addCityTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addCityTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            addCityTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65),
            addCityTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            searchCityWeatherButton.leadingAnchor.constraint(equalTo: addCityTextField.trailingAnchor, constant: 12),
            searchCityWeatherButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchCityWeatherButton.centerYAnchor.constraint(equalTo: addCityTextField.centerYAnchor),
            searchCityWeatherButton.heightAnchor.constraint(equalTo: addCityTextField.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.topAnchor.constraint(equalTo: addCityTextField.bottomAnchor, constant: 30),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension CityViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let forecast = forecast else { return 0 }
        return forecast.daily.count >= FORECAST_4_DAYS ? FORECAST_4_DAYS : 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.cellID, for: indexPath)
            as! WeatherCell
        
        if let dailyForecast = forecast?.daily[indexPath.row + 1] {
            cell.dayLabel.text = dailyForecast.dt.toDateString(dateFormat: "dd/MM")
            cell.minTemperatureLabel.text = String(format: "%.0f", dailyForecast.temp.min) + "°"
            cell.maxTemperatureLabel.text = String(format: "%.0f", dailyForecast.temp.max) + "°"
            if let icon = dailyForecast.weather.first?.icon {
                let iconImage = WeatherConditionIconManager(rawValue: icon)
                cell.weatherImageView.image = iconImage.image
            }
            cell.humidityLabel.text = String(dailyForecast.humidity) + "%"
        }
        
        return cell
    }
        
}

// MARK: - UITableViewDataSource
extension CityViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath)
            as! CityTableViewCell
        
        weatherManager.fetchCurrentWeatherWith(cityName: cities[indexPath.row]) { [weak self] forecast in
            guard let self = self else { return }
            
            cell.cityNameLabel.text = self.cities[indexPath.row]
            if let icon = forecast.current.weather.first?.icon {
                cell.weatherImageView.image = WeatherConditionIconManager(rawValue: icon).image
            }
            cell.temperatureLabel.text = String(format: "%.0f", forecast.current.temp) + "°"
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getCurrentWeather(city: cities[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorite cities"
    }
    
}
