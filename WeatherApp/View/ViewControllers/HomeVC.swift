//
//  HomeVC.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/14/23.
//

import UIKit
import Combine
import SDWebImage

class HomeVC: UIViewController {
    
    //MARK: - Properties
    private let viewModel = HomeVM()
    private var cancellableSet: Set<AnyCancellable> = []
    private var numberOfRows: Int = 0
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageCondition: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind()
    }
    
}

//MARK: - Private Methods
extension HomeVC {
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Cells.forcastCell, bundle: nil), forCellWithReuseIdentifier: Cells.forcastCell)
    }
    
    private func bind() {
        cancellableSet = [
            viewModel.$imgUrl.sink { [weak self] url in
                guard let self else {return}
                self.imageCondition.sd_setImage(with: URL(string: WebServiceConstants.http + url), placeholderImage: UIImage(systemName: Images.sun))
            },
            viewModel.collectionCellVM.$forecastDays.sink { [weak self] days in
                guard let self else {return}
                self.numberOfRows = days.count
                self.collectionView.reloadData()
            },
            viewModel.$day.assign(to: \.text!, on: dayNameLabel),
            viewModel.$city.sink { [weak self] title in
                guard let self else {return}
                self.title = title
            },
            viewModel.$degree.assign(to: \.text!, on: degreeLabel),
            viewModel.$condition.assign(to: \.text!, on: conditionLabel),
            viewModel.$humidity.assign(to: \.text!, on: humidityLabel)
        ]
    }
}

//MARK: - CollectionView Delegate & DataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.forcastCell, for: indexPath) as! ForeCastCollectionViewCell
        let day = viewModel.collectionCellVM.forecastDays[indexPath.row]
        cell.configureCell(for: day)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: Storyboards.main, bundle: nil).instantiateViewController(withIdentifier: ViewControllers.detailVC) as! DetailVC
        detailVC.viewModel = DetailVM(forecastDay: viewModel.collectionCellVM.forecastDays[indexPath.row])
        self.present(detailVC, animated: true)
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 180)
    }
}

//MARK: - UISearchBarDelegate
extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if (searchBar.text?.count ?? 0) >= 3 {
            viewModel.requestData(city: searchBar.text!)
        } else if (searchBar.text?.count ?? 0) == 0{
            self.showAlert(title: Alerts.sorryTitle, message: Alerts.noSearchData)
        } else {
            self.showAlert(title: Alerts.sorryTitle, message: Alerts.moreCharacterSearch)
        }
    }
}
