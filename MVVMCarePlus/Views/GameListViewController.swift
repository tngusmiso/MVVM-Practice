//
//  GameListViewController.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/20.
//
import SnapKit
import UIKit

class GameListViewController: UIViewController {
    // MARK: - ViewModel
    private let viewModel: GameListViewModel = GameListViewModel()
    
    // MARK: - Views
    private lazy var gameListTableView: UITableView = UITableView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 레이아웃 설정을 해준다.
        setConstraints()
        
        // TableViewCell을 코드로 넣기 위함
        gameListTableView.register(GameItemCell.self, forCellReuseIdentifier: "GameItemCell")
        gameListTableView.register(IndicatorTableViewCell.self, forCellReuseIdentifier: "IndicatorTableViewCell")
        
        // bind를 해준다! (주의, 뷰모델에 optional 값이 있으면 난감해~)
        bind(viewModel: viewModel)
        
        // 통신
        viewModel.loadGameList()
    }
}

// MARK: - Layout Constraints (private)
extension GameListViewController {
    private func setConstraints() {
        self.view.addSubview(gameListTableView)
        gameListTableView.delegate = self
        gameListTableView.dataSource = self
        gameListTableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - ViewModel Observer
// viewmodel이 변경되면 view는 다음과 같은 클로저들을 호출하게 된다.
extension GameListViewController: GameListViewModelObserver {
    func bind(viewModel: GameListViewModel) {
        bindGameList(viewModel: viewModel)
    }
    // 통신으로 받아온 데이터가 변경되면
    func bindGameList(viewModel: GameListViewModel) {
        viewModel.gameResponse.didSetValue { [weak self] _ in
            self?.gameListTableView.reloadData()
        }
    }
}

// MARK: - TableView
extension GameListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let gameDetailViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "GameDetailViewController") as? GameDetailViewController else { return }
//        let data: GameContents = viewModel.getCellData(indexPath)
//        gameDetailViewController.updateData(data) = data
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.isIndicatorCell(indexPath) {
            viewModel.loadNextList()
        }
    }
}

extension GameListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableViewItemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isIndicatorCell(indexPath) {
                guard let indicatorCell: IndicatorTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IndicatorTableViewCell", for: indexPath) as? IndicatorTableViewCell else {
                    return UITableViewCell()
                }
                indicatorCell.animateIndicator()
                return indicatorCell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameItemCell", for: indexPath) as? GameItemCell else { return UITableViewCell() }
        let data: GameContents = viewModel.getCellData(indexPath)
        cell.updateData(data)
        return cell
    }
}
