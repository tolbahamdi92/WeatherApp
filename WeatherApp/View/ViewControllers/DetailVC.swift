//
//  DetailVC.swift
//  WeatherApp
//
//  Created by Tolba Hamdi on 2/16/23.
//

import UIKit
import Combine

class DetailVC: UIViewController {
    
    //MARK: - Properties
    var viewModel:DetailVM?
    private var cancellableSet: Set<AnyCancellable> = []
    private var numberOfRows: Int = 0
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var maxDegreeLabel: UILabel!
    @IBOutlet weak var minDegreeLabel: UILabel!
    @IBOutlet weak var avgDegreeLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView! {
        didSet{
            backgroundView.layer.cornerRadius = 40
        }
    }
    @IBOutlet weak var backgroundCollectionView: UIView! {
        didSet{
            backgroundCollectionView.layer.cornerRadius = 40
        }
    }
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bind()
    }
    
}

//MARK: - Private Methods
extension DetailVC {
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Cells.hourCell, bundle: nil), forCellWithReuseIdentifier: Cells.hourCell)
    }
    
    private func bind() {
        guard let viewModel = viewModel else {return}
        cancellableSet = [
        viewModel.$imgUrl.sink { [weak self] url in
            guard let self else {return}
            self.conditionImageView.sd_setImage(with: URL(string: WebServiceConstants.http + url), placeholderImage: UIImage(systemName: Images.sun))
        },
        viewModel.$day.assign(to: \.text!, on: dayNameLabel),
        viewModel.$avgDegree.assign(to: \.text!, on: avgDegreeLabel),
        viewModel.$minDegree.assign(to: \.text!, on: minDegreeLabel),
        viewModel.$maxDegree.assign(to: \.text!, on: maxDegreeLabel),
        viewModel.collectionCellVM.$hours.sink { [weak self] hours in
            guard let self else {return}
            self.numberOfRows = hours.count
            self.collectionView.reloadData()
        }
        ]
    }
}

//MARK: - CollectionView Delegate & DataSource
extension DetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.hourCell, for: indexPath) as! HoursCollectionViewCell
        let hour = viewModel?.collectionCellVM.hours[indexPath.row]
        cell.configureCell(for: hour!)
        return cell
    }
}

//MARK: - CollectionViewDelegateFlowLayout
extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 75, height: 100)
        }
}
