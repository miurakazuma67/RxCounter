//
//  ViewController.swift
//  CounterApp
//
//  Created by 三浦　一真 on 2022/01/02.
//

import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var countUpButton: UIButton!
    @IBOutlet private weak var countDownButton: UIButton!
    @IBOutlet private weak var countResetButton: UIButton!

    private let disposeBag = DisposeBag()
    var viewModel: RxViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        
        let input = RxViewModelInput(countUpButton: countUpButton.rx.tap.asObservable(), countDownButton: countDownButton.rx.tap.asObservable(), countResetButton: countResetButton.rx.tap.asObservable()
        )
        viewModel = RxViewModel(input: input)
        
        viewModel.outputs?.counterText
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)
    }
    

}

