
import UIKit
import SnapKit
import Kingfisher

final class DetailCollectionCell: UICollectionViewCell {
    
    // MARK: - Constants
    
    static var defaultReuseIdentifier = "DetailCollectionCell"
    
    // MARK: - UI
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
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
    
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 50
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
        explanationLabel.text = cellModel.explanation
    }
}
    
    // MARK: - Private Methods
    
private extension DetailCollectionCell {
    
    func setUp() {
        [coverImageView, titleLabel, copyrightLabel,
         dateLabel, explanationLabel].forEach { view in
            contentView.addSubview(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(coverImageView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(coverImageView.snp.bottom).offset(15)
            make.right.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        copyrightLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(copyrightLabel.snp.bottom).offset(10)
            make.right.equalToSuperview().inset(10)
        }
    }
}
