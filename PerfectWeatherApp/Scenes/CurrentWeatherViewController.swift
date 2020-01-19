//
//  CurrentWeatherViewController.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 22.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import UIKit


final class CurrentWeatherViewController: UIViewController{
    
    var currentWeatherPresentation: CurrentWeatherPresentation!
    var dailyWeatherList = [DailyWeatherPresentation]()
    
    let cityLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let iconIV: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .label
        return image
    }()
    let tempLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descriptionLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.minimumScaleFactor = 0.7
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true;
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let feelsLikeLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let humidityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45)
        return label
    }()
    
    let visibilityView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let visibilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45)
        return label
    }()
    let windView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let windLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 45)
        return label
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemGray6
        return cv
    }()
    
    let dailyWeatherListErrorView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .systemGray
        view.translatesAutoresizingMaskIntoConstraints = false
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Daily Weather Data was not loaded."
        lbl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lbl)
        lbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        lbl.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        lbl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.imageView?.tintColor = .label
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.alpha = 0
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray2
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var viewModel: CurrentWeatherViewModel!{
        didSet{
            viewModel.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        addCollectionView()
        emptyValueView()
    }
    private func emptyValueView(){
        self.showOrHideSearchTextField()
    }
    private func setCurrentWeatherData(){
        cityLbl.text = currentWeatherPresentation.cityName
        iconIV.image = UIImage(systemName: currentWeatherPresentation.iconName)
        tempLbl.text = self.currentWeatherPresentation.temp
        feelsLikeLbl.text = "Feels like \(currentWeatherPresentation.feelsLike)"
        descriptionLbl.text = currentWeatherPresentation.description
        humidityLabel.text = currentWeatherPresentation.humidity
        visibilityLabel.text = currentWeatherPresentation.visibility
        windLabel.text = currentWeatherPresentation.windSpeed
    }
    
    private func addViews()  {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(cityLbl)
        self.view.addSubview(iconIV)
        self.view.addSubview(tempLbl)
        self.view.addSubview(feelsLikeLbl)
        self.view.addSubview(descriptionLbl)
        self.view.addSubview(humidityView)
        self.view.addSubview(visibilityView)
        self.view.addSubview(windView)
        self.view.addSubview(searchButton)
        self.view.addSubview(searchTextField)
        
        addCityLabel()
        addIconImageView()
        addDescriptionLabel()
        addTempLabel()
        addFeelsLikeLabel()
        addHumidityView()
        addVisibilityView()
        addWindView()
        addSearchButton()
        addSearchTextField()
        
        UIView.animate(withDuration: 1) {
            self.iconHeightAnchorConstraint.constant = 150
            self.iconWidthAnchorConstraint.constant = 150
            self.iconIV.layoutIfNeeded()
        }
    }
    private func addCityLabel(){
        cityLbl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        cityLbl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        cityLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        cityLbl.text = "--"
    }
    
    var iconHeightAnchorConstraint: NSLayoutConstraint!
    var iconWidthAnchorConstraint: NSLayoutConstraint!
    private func addIconImageView() {
        iconIV.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        iconHeightAnchorConstraint = iconIV.heightAnchor.constraint(equalToConstant: 10)
        iconWidthAnchorConstraint = iconIV.widthAnchor.constraint(equalToConstant: 10)
        self.iconHeightAnchorConstraint.isActive = true
        self.iconWidthAnchorConstraint.isActive = true
        iconIV.topAnchor.constraint(equalTo: self.cityLbl.bottomAnchor, constant: 30).isActive = true
    }
    private func addTempLabel()  {
        tempLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tempLbl.topAnchor.constraint(equalTo: self.descriptionLbl.bottomAnchor).isActive = true
        tempLbl.text = "--"
    }
    private func addFeelsLikeLabel(){
        feelsLikeLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        feelsLikeLbl.topAnchor.constraint(equalTo: self.tempLbl.bottomAnchor).isActive = true
        feelsLikeLbl.text = "--"
    }
    private func addDescriptionLabel() {
        descriptionLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionLbl.topAnchor.constraint(equalTo: self.iconIV.bottomAnchor, constant: 20).isActive = true
        descriptionLbl.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor).isActive = true
        descriptionLbl.text = "--"
    }
    private func addHumidityView(){
        humidityView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        humidityView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        humidityView.topAnchor.constraint(equalTo: feelsLikeLbl.bottomAnchor, constant: 50).isActive = true
        humidityView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        
        let title = UILabel()
        title.text = "Humidty"
        humidityView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: humidityView.topAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
        humidityLabel.text = "--"
        humidityView.addSubview(humidityLabel)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.centerYAnchor.constraint(equalTo:  humidityView.centerYAnchor).isActive = true
        humidityLabel.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
        
        let percentLabel = UILabel()
        percentLabel.text = "%"
        humidityView.addSubview(percentLabel)
        percentLabel.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.bottomAnchor.constraint(equalTo: humidityView.bottomAnchor).isActive = true
        percentLabel.centerXAnchor.constraint(equalTo: humidityView.centerXAnchor).isActive = true
    }
    
    private func addVisibilityView(){
        visibilityView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        visibilityView.topAnchor.constraint(equalTo: feelsLikeLbl.bottomAnchor, constant: 50).isActive = true
        visibilityView.leadingAnchor.constraint(equalTo: humidityView.trailingAnchor).isActive = true
        visibilityView.trailingAnchor.constraint(equalTo: windView.leadingAnchor).isActive = true
        
        let title = UILabel()
        title.text = "Visibility"
        visibilityView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: visibilityView.topAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: visibilityView.centerXAnchor).isActive = true
        
        
        visibilityLabel.text = "--"
        visibilityView.addSubview(visibilityLabel)
        visibilityLabel.translatesAutoresizingMaskIntoConstraints = false
        visibilityLabel.centerYAnchor.constraint(equalTo:  visibilityView.centerYAnchor).isActive = true
        visibilityLabel.centerXAnchor.constraint(equalTo: visibilityView.centerXAnchor).isActive = true
        
        let kmhLabel = UILabel()
        kmhLabel.text = "meter"
        visibilityView.addSubview(kmhLabel)
        kmhLabel.translatesAutoresizingMaskIntoConstraints = false
        kmhLabel.bottomAnchor.constraint(equalTo: visibilityView.bottomAnchor).isActive = true
        kmhLabel.centerXAnchor.constraint(equalTo: visibilityView.centerXAnchor).isActive = true
    }
    private func addWindView(){
        windView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        windView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        windView.topAnchor.constraint(equalTo: feelsLikeLbl.bottomAnchor, constant: 50).isActive = true
        windView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        
        let title = UILabel()
        title.text = "Wind"
        windView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: windView.topAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: windView.centerXAnchor).isActive = true
        
        
        windLabel.text = "--"
        windView.addSubview(windLabel)
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.centerYAnchor.constraint(equalTo:  windView.centerYAnchor).isActive = true
        windLabel.centerXAnchor.constraint(equalTo: windView.centerXAnchor).isActive = true
        
        let kmhLabel = UILabel()
        kmhLabel.text = "km/hr"
        windView.addSubview(kmhLabel)
        kmhLabel.translatesAutoresizingMaskIntoConstraints = false
        kmhLabel.bottomAnchor.constraint(equalTo: windView.bottomAnchor).isActive = true
        kmhLabel.centerXAnchor.constraint(equalTo: windView.centerXAnchor).isActive = true
    }
    private func addSearchButton(){
        searchButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        searchButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchButton.addTarget(self, action: #selector(showOrHideSearchTextField), for: .touchUpInside)
    }
    @objc private func showOrHideSearchTextField(){
        UIView.animate(withDuration: 0.2) {
            if(self.searchTextField.alpha==0){
                self.searchTextField.alpha = 1
                self.searchTextField.becomeFirstResponder()
                self.searchButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            }
            else{
                self.searchTextField.alpha = 0
                self.searchTextField.resignFirstResponder()
                self.searchButton.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
            }
        }
    }
    private func addSearchTextField(){
        searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
        self.searchTextField.clearsOnBeginEditing = true
    }
}

extension CurrentWeatherViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        showOrHideSearchTextField()
        searchCity(cityName: textField.text)
        return false
    }
    func searchCity(cityName: String?) {
        guard let cityName = cityName else {return}
        viewModel.loadCurrentWeather(cityName: cityName)
    }
}


extension CurrentWeatherViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dailyWeatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DailyWeatherCollectionViewCell
        cell.setData(presentation: dailyWeatherList[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.collectionView.frame.size.width/5, height: self.collectionView.frame.size.height)
    }
    
    func addCollectionView(){
        collectionView.delegate=self
        collectionView.dataSource=self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.12),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.view.addSubview(dailyWeatherListErrorView)
               NSLayoutConstraint.activate([
                   dailyWeatherListErrorView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
                   dailyWeatherListErrorView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.12),
                   dailyWeatherListErrorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                   dailyWeatherListErrorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
               ])
    }
}

extension CurrentWeatherViewController: CurrentWeatherViewModelDelegate{
    func notifyViewController(_ output: CurrentWeatherViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                self.showOrHideActivityIndicator(isLoading: isLoading)
            }
        case .showCurrentWeather(let currentWeatherPresentation, let cityName):
            self.currentWeatherPresentation = currentWeatherPresentation
            self.viewModel.loadDailyWeather(cityName: cityName)
            DispatchQueue.main.async {
                self.setCurrentWeatherData()
            }
            
        case .showDailyWeather(let dailyList):
            DispatchQueue.main.async {
                if(dailyList.count>0){
                    self.dailyWeatherListErrorView.isHidden = true
                    self.dailyWeatherList = dailyList
                    self.collectionView.reloadData()
                }
            }
        case .errorCurrentWeather:
            DispatchQueue.main.async {
                self.showErrorCurrentWeather()
            }
        case .errorDailyWeather:
            DispatchQueue.main.async {
                self.showErrorDailyWeatherList()
            }
        }
    }
    private func showErrorCurrentWeather(){
        let alertController = UIAlertController(title: "Error", message: "Data was not found.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
            self.emptyValueView()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    private func showErrorDailyWeatherList(){
        dailyWeatherListErrorView.isHidden = false
    }
    private func showOrHideActivityIndicator(isLoading: Bool){
        if isLoading {
            LoaderView.loaderView.startActivityIndicator(viewControllerView: self.view)
        }else{
            LoaderView.loaderView.stopActivityIndicator()
        }
    }
}

