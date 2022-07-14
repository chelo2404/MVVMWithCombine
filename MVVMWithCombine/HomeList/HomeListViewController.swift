//
//  ViewController.swift
//  MVVMWithClosures
//
//  Created by Marcelo Fernandez on 26/06/2022.
//

import UIKit
import Combine

class HomeListViewController: UIViewController {

    let activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var bandTableView: UITableView!
    let homeListViewModel = HomeListViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "Home"
        
        bandTableView.dataSource = self
        bandTableView.delegate = self
        bandTableView.register(UINib(nibName: BandCell.identifier, bundle: nil), forCellReuseIdentifier: BandCell.identifier)
        
        bind()
        homeListViewModel.getBands()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setConstraints()
    }

    private func bind() {
        homeListViewModel.$dataArray.sink { [weak self] bands in
            DispatchQueue.main.async {
                self?.bandTableView.reloadData()
                self?.activityIndicator.stopAnimating()
            }
        }.store(in: &cancellables)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setConstraints() {
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension HomeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeListViewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BandCell.identifier, for: indexPath) as? BandCell
        
        guard let cell = cell else {
            fatalError()
        }
        let item = homeListViewModel.dataArray[indexPath.row]	
        let cellViewModel = BandCellViewModel(logo: item.logo, name: item.name)
        
        cell.configureCellWith(viewModel: cellViewModel)
        
        return cell
    }
}

extension HomeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsViewController = UIStoryboard(name: "DetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.bandId = indexPath.row
        detailsViewController.modalPresentationStyle = .fullScreen
        
        if let navController = self.navigationController {
            navController.pushViewController(detailsViewController, animated: true)
        } else {
            self.present(detailsViewController, animated: true , completion: nil)
        }
    }
}
