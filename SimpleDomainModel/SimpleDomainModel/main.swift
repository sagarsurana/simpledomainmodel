//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    var convertedAmount: Int = 0;
    if (self.currency == to) {
        return self
    }
    switch (currency, to) {
    case ("USD", "GBP"):
        convertedAmount = amount / 2
        print(convertedAmount)
    case ("USD", "EUR"):
        convertedAmount = (amount * 3) / 2
    case ("USD", "CAN"):
        convertedAmount = (amount * 5) / 4
    case ("GBP", "USD"):
        convertedAmount = amount * 2
    case ("GBP", "EUR"):
        convertedAmount = (amount * 2 * 3) / 2
    case ("GBP", "CAN"):
        convertedAmount = (amount * 2 * 5) / 4
    case ("EUR", "GBP"):
        convertedAmount = (amount * 2 ) / (3 * 2)
    case ("EUR", "USD"):
        convertedAmount = (amount * 2) / 3
    case ("EUR", "CAN"):
        convertedAmount = (amount * 2 * 5) / (3 * 4)
    case ("CAN", "GBP"):
        convertedAmount = (amount * 4) / (5 * 2)
    case ("CAN", "USD"):
        convertedAmount = (amount * 4) / 5
    case ("CAN", "EUR"):
        convertedAmount = (amount * 4 * 3) / (5 * 2)
    default:
        return Money(amount: 0, currency: "WRONG CURRENCY ABBREVIATION ENTERED")
    }
    
    return Money(amount: convertedAmount, currency: to)
  }
  
  public func add(_ to: Money) -> Money {
    let money = self.convert(to.currency)
    let newAmt = money.amount
    return Money(amount: newAmt + to.amount, currency: to.currency)
  }
    
  public func subtract(_ from: Money) -> Money {
    let money = self.convert(from.currency)
    let newAmt = money.amount
    return Money(amount: newAmt - from.amount, currency: from.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch type {
    case .Hourly(let hourly):
        
        return Int(hourly * Double(hours))
    case .Salary(let salary):
        return salary
    }
  }
  
  open func raise(_ amt : Double) {
    switch type {
    case .Hourly(let hourly):
        type = .Hourly(hourly + amt)
        
    case .Salary(let salary):
        type = .Salary(Int(Double(salary) + amt))
    }
  }
}

////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0
    
  fileprivate var _job : Job? = nil
  open var job : Job? {
    get { return _job }
    set(value) {
        if age > 15 {
            _job = value
        }
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return _spouse }
    set(value) {
        if age > 17 {
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    let response: String = "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(String(describing: _job)) spouse:\(String(describing: _spouse))]"
    return response
  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        members.append(spouse1)
        members.append(spouse2)
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    if members[0].age > 20 || members[1].age > 20 {
        members.append(child)
        return true
    } else {
        return false
    }
  }
  
  open func householdIncome() -> Int {
    var totalIncome: Int = 0
    for person in self.members {
        if person.job != nil {
            totalIncome = totalIncome + person.job!.calculateIncome(2000)
        }
    }
    print(totalIncome)
    return totalIncome
  }
}





