//
//  RxViewModel.swift
//  CounterApp
//
//  Created by 三浦　一真 on 2022/01/03.
//

import RxSwift
import RxCocoa

class RxViewModel: RxViewModelType {
    
    var outputs: RxViewModelOutput?
    private let countRelay = BehaviorRelay<Int>(value: 0)
    private let initialCount = 0
    private let disposeBag = DisposeBag()
    
    required init(input: RxViewModelInput) {
        self.outputs = self
        resetCount()
    
    input.countUpButton
        .subscribe(onNext: { [weak self] in
            self?.incrementCount()
        })
        .disposed(by: disposeBag)
    
    input.countDownButton
        .subscribe(onNext: { [weak self] in
            self?.decrementCount()
        })
        .disposed(by: disposeBag)
    
    input.countResetButton
        .subscribe(onNext: { [weak self] in
            self?.resetCount()
        })
        .disposed(by: disposeBag)
    }

    ///+1を押したときのメソッド
    private func incrementCount() {
        let count = countRelay.value + 1
        countRelay.accept(count)
    }
    
    ///-1を押したときのメソッド
    private func decrementCount() {
        let count = countRelay.value - 1
        countRelay.accept(count)
    }

    ///リセットを押したときのメソッド
    private func resetCount() {
        countRelay.accept(initialCount)
    }
    
}

extension RxViewModel: RxViewModelOutput {
    var counterText: SharedSequence<DriverSharingStrategy, String> {
        let counterText = countRelay
            .map {
                "Rxパターン:\($0)"
            }
            .asDriver(onErrorJustReturn: "")
        return counterText
    }
}
