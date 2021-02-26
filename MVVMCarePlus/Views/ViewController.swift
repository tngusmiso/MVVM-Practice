//
//  ViewController.swift
//  MVVMCarePlus
//
//  Created by 임수현 on 2021/02/20.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    // MARK: lazy를 쓰는 것에 대한 고찰..
    // - view가 로드되자마자 어차피 사용될 친구인데, lazy를 쓰는 것이 좋을까???
    private lazy var backgroundImageView: UIImageView = UIImageView()
    private lazy var logoView: UIView = UIView()
    private lazy var logoLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        addGestureRecognizers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDefaultAnimationLayout()
        appearLogoAnimation(then: slideBackgroundImageAnimation)
    }
}

// MARK: - Layout
extension ViewController {
    // MARK: Snapkit 적용하는 우선순위도 정하면 좋을 것 같아요!
    // top, leading, trailing, bottom, centerX Y , width, height 등...
    private func setLayout() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.image = UIImage(named: "homeBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(logoView)
        logoView.backgroundColor = .pinkishRed
        logoView.layer.cornerRadius = 15
        logoView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-300)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        logoView.addSubview(logoLabel)
        logoLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        logoLabel.text = "Nintendo\nStore"
        logoLabel.numberOfLines = 0
        logoLabel.textColor = .white
        logoLabel.textAlignment = .center
        logoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setDefaultAnimationLayout() {
        backgroundImageView.snp.remakeConstraints { make in
            make.top.left.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        logoView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
    }
}

// MARK: - Animation
extension ViewController {
    private func appearLogoAnimation(then completion: @escaping () -> Void) {
        logoView.snp.updateConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(17)
        }
        
        UIView.animate(withDuration: 0.7, delay: 1, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: []) { [weak self] in
            self?.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    private func blinkLogoAnimation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse]) { [weak self] in
            self?.logoView.alpha = 0
        } completion: { [weak self] _ in
            self?.logoView.alpha = 1
        }
    }
    
    private func slideBackgroundImageAnimation() {
        backgroundImageView.snp.updateConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(-800)
        }
        
        UIView.animate(withDuration: 10, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse]) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

// MARK: - Action
extension ViewController {
    @IBAction private func didTapLogoView(_ sender: UITapGestureRecognizer) {
        blinkLogoAnimation()
    }
    
    private func addGestureRecognizers() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLogoView(_:)))
        logoView.addGestureRecognizer(tapGesture)
    }
}
