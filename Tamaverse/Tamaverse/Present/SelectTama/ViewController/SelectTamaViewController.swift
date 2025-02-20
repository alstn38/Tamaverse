//
//  SelectTamaViewController.swift
//  Tamaverse
//
//  Created by 강민수 on 2/20/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class SelectTamaViewController: UIViewController {
    
    private let viewModel: SelectTamaViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var tamaCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: configureFlowLayout()
    )
    
    init(viewModel: SelectTamaViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureBind()
        configureNavigation()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureBind() {
        let input = SelectTamaViewModel.Input(
            tamagotchiDidSelect: tamaCollectionView.rx.modelSelected(Tamagotchi.self).asObservable()
        )
        
        let output = viewModel.transform(from: input)
        
        output.tamagotchiInfo
            .drive(tamaCollectionView.rx.items(
                cellIdentifier: TamaCollectionViewCell.identifier,
                cellType: TamaCollectionViewCell.self
            )) { (row, element, cell) in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
        
        output.moveToAlertView
            .drive(with: self) { owner, tamagotchi in
                let viewModel = TamaSelectAlertViewModel(tamagotchi: tamagotchi)
                let viewController = TamaSelectAlertViewController(viewModel: viewModel)
                viewController.modalPresentationStyle = .overFullScreen
                owner.present(viewController, animated: false)
            }
            .disposed(by: disposeBag)

    }
    
    private func configureNavigation() {
        navigationItem.title = StringLiterals.SelectTama.title
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(resource: .tamaBackground)
        
        tamaCollectionView.backgroundColor = UIColor(resource: .tamaBackground)
        tamaCollectionView.showsVerticalScrollIndicator = false
        tamaCollectionView.showsHorizontalScrollIndicator = false
        tamaCollectionView.register(
            TamaCollectionViewCell.self,
            forCellWithReuseIdentifier: TamaCollectionViewCell.identifier
        )
    }
    
    private func configureHierarchy() {
        view.addSubviews(tamaCollectionView)
    }
    
    private func configureLayout() {
        tamaCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
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
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = minimumSpacing
        layout.minimumLineSpacing = minimumSpacing
        layout.itemSize = CGSize(width: cellLength, height: cellLength + 30)
        layout.sectionInset = UIEdgeInsets(top: insetSize, left: insetSize, bottom: insetSize, right: insetSize)
        
        return layout
    }
}
