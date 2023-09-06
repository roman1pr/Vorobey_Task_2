//
//  ViewController.swift
//  Vorobey_Task_2
//
//  Created by Roman Priiskalov on 06.09.2023.
//

import UIKit

//+ Кнопки должны быть адаптивные, под разный текст - разная ширина. Отступ внутри кнопки от контента 10pt по вертикали и 14pt по горизонтали.
//+ По нажатию анимировано уменьшать кнопку. Когда отпускаешь - кнопка возвращается к оригинальному размеру. Анимация должна быть прерываемая, например, кнопка возвращается к своему размеру, а в процессе анимации снова нажать на кнопку - анимация пойдет из текущего размера, без скачков.
//+ Справа от текста поставить иконку. Использовать системный imageView в классе кнопки, создавать свою imageView нельзя. Расстояние между текстом и иконкой 8pt.
//- Когда показывается модальный контроллер, кнопка должны красится: фон в .systemGray2, а текст и иконка в .systemGray3. Нельзя привязываться к методам жизненного цикла контроллера.

class ViewController: UIViewController {
    
    lazy var button1 = createButton(title: "Button 1")
    lazy var button2 = createButton(title: "Button Big text 2")
    lazy var button3 = createButton(title: "Button")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
                
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        
        NSLayoutConstraint.activate([
            button1.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 16),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 16),
            
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // Назначение обработчиков нажатия кнопок
        button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func createButton(title: String) -> UIButton {
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 18)

        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(title, attributes: container)
        configuration.image = UIImage(systemName: "arrow.right.circle")
        
        // Отступ внутри кнопки от контента 10pt по вертикали и 14pt по горизонтали.
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        
        // Расстояние между текстом и иконкой 8pt.
        configuration.imagePadding = 8

        // Справа от текста ставим иконку
        configuration.imagePlacement = .trailing
//
//        let handler: UIButton.ConfigurationUpdateHandler = { button in // 1
//
//            if button == self.button3 {
//                switch button.state { // 2
//                case [.selected, .highlighted]:
//                    button.configuration?.title = "Highlighted Selected"
//                    print("Highlighted Selected")
//                case .selected:
//                    button.configuration?.title = "Selected"
//                    print("Selected")
//                case .highlighted:
//                    button.configuration?.title = "Highlighted"
//                    print("Highlighted")
//                case .disabled:
//                    button.configuration?.title = "Disabled"
//                    print("Disabled")
//                case .focused:
//                    button.configuration?.title = "focused"
//                    print("focused")
//                default:
//                    button.configuration?.title = "Normal"
//                    print("Normal")
//                }
//            }
//        }
//

        let button = TouchableButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.layer.cornerRadius = 8
//        button.configurationUpdateHandler = handler
        
        return button
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        if sender == button3 {
            // Показать модальный контроллер
            presentModalController()
        }
    }
    
    private func presentModalController() {
        let modalController = UIViewController()
        modalController.modalPresentationStyle = .popover
        modalController.view.backgroundColor = UIColor.white
        
        present(modalController, animated: true, completion: nil)
    }

}

