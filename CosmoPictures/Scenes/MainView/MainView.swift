
import UIKit
import SnapKit

protocol MainView: AnyObject, ErrorView, LoadingView {
    func displayCells(_ cellModels: [CellModel])
    func present(_ viewController: UIViewController)
}

class MainViewController: UIViewController {
    
    //MARK: - Private Properties

    private lazy var collectionWidth = collectionView.frame.width
    lazy var activityIndicator = UIActivityIndicatorView()

    private var cellModels: [CellModel] = []
    private let presenter: Presenter
    
    //MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.defaultReuseIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12
        button.setImage(UIImage(named: "reload"), for: .normal)
        button.addTarget(self,
                         action: #selector(reload),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initializers

    init(presenter: Presenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setUp()
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.defaultReuseIdentifier, for: indexPath) as? MainCollectionCell
        else { return UICollectionViewCell() }
        let cellModel = cellModels[indexPath.row]
        cell.configure(with: cellModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionWidth - 2 * MainLayoutConstants.insets.left,
                      height: MainLayoutConstants.cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return MainLayoutConstants.insets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return MainLayoutConstants.minimumInteritemSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return MainLayoutConstants.minimumLineSpacing
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openDetails(with: cellModels[indexPath.row])
    }
}

// MARK: - MainView

extension MainViewController: MainView {
    
    func displayCells(_ cellModels: [CellModel]) {
        self.cellModels = cellModels
        collectionView.reloadData()
    }
    
    func present(_ viewController: UIViewController) {
        present(viewController, animated: true)
    }
}

private extension MainViewController {
    
    @objc
    func reload() {
        presenter.viewDidLoad()
    }
    
    func setUp() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(reloadButton)
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        reloadButton.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}
