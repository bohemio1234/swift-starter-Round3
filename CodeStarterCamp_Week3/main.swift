//
//  main.swift
//  CodeStarterCamp_Week3
//
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

class Person {
    let name: String
    var money: Int
    
    init(name:String, money: Int) {
        self.name = name
        self.money = money
    }
    
    func order(_ coffee: Coffee, of coffeeshop: CoffeeShop, by name: String) {
        coffeeshop.make(coffee, for: name)
        if let coffeePrice: Int = coffeeshop.menuTable[coffee] {
            if money >= coffeePrice {
                money -= coffeePrice
            } else {
                print("잔액이 \(coffeePrice - money)만큼 부족합니다.")
            }
            coffeeshop.sales += coffeePrice
        }
    }
}

class CoffeeShop {
    var sales: Int = 0
    var menuTable: [Coffee: Int] = [
        .americano: 4500,
        .latte : 4500,
        .espresso : 4000,
        .cappuccino : 4500
    ]
    var pickUpTable: [String] = [] {
        didSet {
            if let newCoffee = pickUpTable.last, let customer = customer {
                print("\(customer) 님이 주문하신 \(newCoffee)(이/가) 준비되었습니다. 픽업대에서 가져가주세요.")
            }
        }
    }
    var barista: Person?
    var customer: String?
    
    func make(_ coffee: Coffee, for name: String) {
        customer = name
        pickUpTable.append(coffee.rawValue)
    }
}

enum Coffee: String {
    case americano = "아메리카노", latte = "라떼", espresso = "에스프레소", cappuccino = "카푸치노"
}

let misterLee: Person = Person(name: "misterLee", money: 0)
let missKim: Person = Person(name: "missKim", money: 3500)
let yagombucks: CoffeeShop = CoffeeShop()
yagombucks.barista = misterLee

missKim.order(.americano, of: yagombucks, by: missKim.name)
