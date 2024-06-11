//
//  GameViewController.swift
//  EPIC RPS
//
//  Created by Мария Нестерова on 09.06.2024.
//

import UIKit

class GameViewController: UIViewController {
    
    private let gameView = GameView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        gameView.onChoiceMade = { [weak self] in self?.calculateWin($0, $1) }
        gameView.finishGame = { [weak self] in self?.showResult($0) }
        gameView.getRandomGesture = { [weak self] in
            if let gesture = self?.getRandomGesture() {
                return gesture
            } else {
                return .femaleHandRock
            }
        }
        view = gameView
    }
    
    private func showResult(_ result: Bool) {
        navigationController?.pushViewController(ResultViewController(), animated: true)
    }
    
    private func calculateWin(_ userImage: UIImage, _ pcImage: UIImage) -> Bool? {
        return Game().calculateWin(user: getGestureForImage(userImage), pc: getGestureForImage(pcImage))
    }
    
    private func getRandomGesture() -> UIImage {
        [.femaleHandRock, .femaleHandPaper, .femaleHandScissors][Int.random(in: 0..<3)]
    }
    
    private func getGestureForImage(_ image: UIImage) -> GameGesture {
        switch image {
        case .femaleHandRock:
            return .rock
        case .maleHandRock:
            return .rock
        case .femaleHandPaper:
            return .paper
        case .maleHandPaper:
            return .paper
        default:
            return .scissors
        }
    }

}
