//
//  ViewModel.swift
//  CounterApp
//
//  Created by 三浦　一真 on 2022/01/03.
//

import RxSwift
import RxCocoa

// ViewModel と同じクラスファイルに定義したほうが良いかも(好みやチームの規約による)

// ボタンの入力シーケンス

struct RxViewModelInput {
  let countUpButton: Observable<Void>
  let countDownButton: Observable<Void>
  let countResetButton: Observable<Void>
}

// ViewController に監視させる対象を定義
protocol RxViewModelOutput {
  var counterText: Driver<String> { get }
}

// ViewModel に継承させる protocol を定義
protocol RxViewModelType {
  var outputs: RxViewModelOutput? { get }
  init(input: RxViewModelInput)
}
