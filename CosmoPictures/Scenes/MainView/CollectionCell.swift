
import UIKit
import SnapKit
import Kingfisher

final class MainCollectionCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static var defaultReuseIdentifier = "MainCollectionCell"
    
    // MARK: - UI
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    // MARK: - Public Methods
    
    func configure(with cellModel: CellModel) {
        coverImageView.kf.setImage(with: cellModel.imageUrl)
        titleLabel.text = cellModel.title
        copyrightLabel.text = cellModel.copyright
        dateLabel.text = cellModel.date
    }
}
    
    // MARK: - Private Methods
    
private extension MainCollectionCell {
    
    func setUp() {
        [coverImageView, titleLabel, copyrightLabel, dateLabel].forEach { view in
            contentView.addSubview(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImageView.snp.right).offset(10)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImageView.snp.right).offset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        copyrightLabel.snp.makeConstraints { make in
            make.left.equalTo(coverImageView.snp.right).offset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(10)
        }
    }
}
