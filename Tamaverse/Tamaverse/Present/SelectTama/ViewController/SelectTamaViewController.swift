//
//  SelectTamaViewController.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import UIKit
import SnapKit

final class SelectTamaViewController: UIViewController {
    
    private lazy var tamaCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureNavigation() {
        navigationItem.title = StringLiterals.SelectTama.title
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .tamaBackground)
        
        tamaCollectionView.backgroundColor = UIColor(resource: .tamaBackground)
        tamaCollectionView.showsVerticalScrollIndicator = false
        tamaCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func configureHierarchy() {
        view.addSubviews(tamaCollectionView)
    }
    
    private func configureLayout() {
        tamaCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let cellCountOfRow = 3
        let insetSize: CGFloat = 20
        let minimumSpacing: CGFloat = 25
        let screenWidth: CGFloat = view.window?.windowScene?.screen.bounds.width ?? UIScreen.main.bounds.width
        let possibleCellLength: CGFloat = screenWidth - (insetSize * 2) - (minimumSpacing * (CGFloat(cellCountOfRow) - 1))
        let cellLength: CGFloat = possibleCellLength / CGFloat(cellCountOfRow)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = minimumSpacing
        layout.minimumLineSpacing = minimumSpacing
        layout.itemSize = CGSize(width: cellLength, height: cellLength + 30)
        layout.sectionInset = UIEdgeInsets(top: insetSize, left: insetSize, bottom: insetSize, right: insetSize)
        
        return layout
    }
}
