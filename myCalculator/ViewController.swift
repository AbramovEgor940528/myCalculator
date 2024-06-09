//
//  ViewController.swift
//  myCalculator
//
//  Created by Егор Абрамов on 29.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: - Nested types
    private enum Operation {
        case divide
        case multiply
        case minus
        case plus
        case none
    }
    
    // MARK: - Private UI properties
    @IBOutlet private var imputLine: UILabel!
    @IBOutlet private var buttons: [UIButton]!
    
    // MARK: - Private properties
    /// Массив ввденных чисел
    private var numbers: [Double] = []
    
    /// Массив введенных операторов
    private var operations: [Operation] = []
    
    /// Последний выбранный оператор
    private var lastSelectedOperation: Operation = .none

    /// Собирает число (т.к вводим по одной цифре)
    private var currentNumber: Double = .zero


    // MARK: - Life cycle
    override func viewDidLoad() {
       super.viewDidLoad()
        imputLine.text = "0"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupButtons()
    }
    //12 + 28 = 40
    
    // MARK: - Actions
    @IBAction private func didTapButton(_ sender: UIButton) {
        let tag = sender.tag // тэг нажатой кнопки (для идентификации кнопки)
        
        // Если приходит цифра, обновляем и отображаем currentNumber
        if tag > 0 && tag <= 10 {
            updateCurrentNumber(usingTag: tag)
        }
        
        if tag == 11 {
            print("точка")
            // TODO: - написать функцию для точки
        }

        if tag == 12 {
            clear()
        }
        
        if tag == 13 {
            print("Плюс минус")
            // TODO: - написать функцию для смены знака
        }

        if tag == 14 {
            print("Процент")
            // TODO: - написать функцию для взятия процента
        }
        
        if tag == 18 {
            plus()
        }
        if tag == 19{
            result()
        }
            
    }
    
    // MARK: - Private methods
    
    private func updateCurrentNumber(usingTag tag: Int) {
        currentNumber = currentNumber * 10 + Double(tag == 10 ? 0 : tag)
        imputLine.text = "\(currentNumber)"
        
        if lastSelectedOperation != .none {
            operations.append(lastSelectedOperation)
            lastSelectedOperation = .none
        }
    }
    
    private func clear() {
        imputLine.text = String(0)
        currentNumber = .zero
        numbers.removeAll()
        operations.removeAll()
    }
    
    private func plus() {
        lastSelectedOperation = .plus
        
//        если в списке operations пусто, то кладем currentNumber в numbers
        // если в списке operations есть operation, то достаем два последних числа из numbers и последний operation   (потом добавится приоритет)
        // считаем результат и кладем в numbers
        
        if operations.isEmpty {
            numbers.append(currentNumber)
            currentNumber = .zero
        } else {
            
            // берем два последних numbers, применяем к ним последнюю операцию из operations
            // и кладем в numbers
            
            //            numbers[numbers.count-2] (1)
            //            numbers[numbers.count-1] (2)
            //              operations[operations.count-1] (операция)
            //            numbers.removeLast(2)
            //            numbers.append((1) (операция) (2))
            
        }
    }
    // num[12 28] oper[.plus]
    private func result() {
        numbers.append(currentNumber)
        if operations.contains(.plus){
            let result = numbers[numbers.count-1] + numbers[numbers.count-2]
            numbers.append(result)
            numbers.removeFirst()
            imputLine.text = "\(result)"
        }
    }
    
    private func setupButtons() {
        for button in buttons {
            button.layer.cornerRadius = button.bounds.height / 2
        }
    }
}

/*
 {
     let tag = sender.tag
     
     if tag > 0 && tag <= 10 {
         currentNumber = currentNumber * 10 + Double(tag == 10 ? 0 : tag)
         imputLine.text = "\(currentNumber)"
         print(currentNumber)
         print("цифра \(tag)")
     }
     
     if tag == 11 {
         print("точка")
     }
     if tag == 12 {
         operation = .none
         imputLine.text = String(0)
         currentNumber = .zero
         numbers.removeAll()
         operations.removeAll()
         print("Очистить")
     }
     if tag == 13 {
         print("Плюс минус")
     }
     if tag == 14 {
         print("Процент")
     }
     if tag == 15 {
         operation = .divide
         numbers.append(currentNumber)
         operations.append(operation)
         currentNumber = .zero
         print("Деление")
     }
     if tag == 16 {
         operation = .multiply
         numbers.append(currentNumber)
         operations.append(operation)
         currentNumber = .zero
         print("Умножение")
     }
     if tag == 17 {
         operation = .minus
         numbers.append(currentNumber)
         operations.append(operation)
         currentNumber = .zero
         print("Минус")
     }
     // 5 + 7 + 9
     if tag == 18 {
         operation = .plus
         numbers.append(currentNumber)
         operations.append(operation)
         currentNumber = .zero
         print("Плюс")
         print(numbers)
         print(operations)
     }
     if tag == 19 {
         switch operation {
         case .divide:
             numbers.append(currentNumber)
         case .multiply:
             numbers.append(currentNumber)
         case .minus:
             numbers.append(currentNumber)
         case .plus:
             numbers.append(currentNumber)
             numbers.append(numbers[0] + numbers[1])
             imputLine.text = "\(numbers.last ?? numbers[1])"
             numbers.removeFirst(2)
             currentNumber = .zero
             print(numbers)
         case .none:
             break
         }
     }
     print("[DEBUG] number: \(numbers) operations: \(operations) currentNum: \(currentNumber)")
 }
 */

/*
 // 1
//    init(buttons: [UIButton]!, imputLine: UILabel!) {
//        self.buttons = buttons
//        self.imputLine = imputLine
//    }

 // 2
 override func loadView() {
     super.loadView()
     print("\(#function) - \(buttons.first?.bounds.size)")
 }
 
 override func viewDidLoad() {
     super.viewDidLoad()
     print("\(#function) - \(buttons.first?.bounds.size)")
 }
 
 override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     print("\(#function) - \(buttons.first?.bounds.size)")
 }
 
 override func viewWillLayoutSubviews() {
     super.viewWillLayoutSubviews()
     print("\(#function) - \(buttons.first?.bounds.size)")
 }
 
 override func viewDidLayoutSubviews() {
     super.viewDidLayoutSubviews()
     print("\(#function) - \(buttons.first?.bounds.size)")
 }
 */
