//
//  IndicatorTableViewCell.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/23.
//
import SnapKit
import UIKit

class IndicatorTableViewCell: UITableViewCell {
    // MARK: - Views
    private var indicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - 코드로 셀을 입력해주기 위한 부분
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 레이아웃을 설정해준다.
        setConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        self.contentView.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func animateIndicator() {
        indicator.startAnimating()
    }
}
