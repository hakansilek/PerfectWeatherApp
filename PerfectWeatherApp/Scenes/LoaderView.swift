//
//  LoaderView.swift
//  PerfectWeatherApp
//
//  Created by Hakan Silek on 30.12.2019.
//  Copyright © 2019 Hakan Silek. All rights reserved.
//

import UIKit

class LoaderView{
    
    static let loaderView = LoaderView()
    private init(){}
    
    private lazy var backgroundView:UIView={
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()
    
    func startActivityIndicator(viewControllerView: UIView) {
        viewControllerView.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: viewControllerView.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: viewControllerView.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 70),
            backgroundView.widthAnchor.constraint(equalToConstant: 70)
        ])
        activityIndicator.color = .systemGray6
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        backgroundView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
        ])
        activityIndicator.startAnimating()
    }
    func stopActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        backgroundView.removeFromSuperview()
    }
}


