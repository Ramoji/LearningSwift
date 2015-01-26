import UIKit

/*
//  Natural Numbers
//
//  Suggested Reading:
//  http://www.fewbutripe.com/swift/math/2015/01/20/natural-numbers.html
/===================================*/



/*------------------------------------/
//  As an Enum
/------------------------------------*/
enum Nat {
  case Zero
  case Succ(@autoclosure () -> Nat)
}


// A few examples
let zero: Nat = .Zero
let one: Nat = .Succ(.Zero)
let two: Nat = .Succ(one)
let three: Nat = .Succ(two)
let four: Nat = .Succ(.Succ(.Succ(.Succ(.Zero))))


/*------------------------------------/
//  Equality ==
//
//  Note: a-1 == b-1
/------------------------------------*/
extension Nat : Equatable {}
func == (a: Nat, b: Nat) -> Bool {
  switch (a, b) {
  case (.Zero, .Zero):
    return true
  case (.Zero, .Succ), (.Succ, .Zero):
    return false
  case let (.Succ(pred_a), .Succ(pred_b)):
    return pred_a() == pred_b()
  }
}


// Equality examples:
zero == zero
one == one
one == two
four == .Succ(.Succ(.Succ(.Succ(.Zero))))


/*------------------------------------/
//  Addition +
//
//  Note: a+b = (a-1)+(b+1)
/------------------------------------*/
func add (a: Nat, b: Nat) -> Nat {
  switch (a, b) {
  case (_, .Zero):
    return a
  case (.Zero, _):
    return b
  case let (.Succ(pred_a), _):
    return add(pred_a(), .Succ(b))
  }
}

func + (a: Nat, b: Nat) -> Nat {
  return add(a, b)
}


// Addition examples:
let five = two + three
let ten = five + five
ten == two + five + three
(one + three) == (two + two)


/*------------------------------------/
//  Multiplication *
//
//  Note: a*b = (a-1) * b + b
/------------------------------------*/
func * (a: Nat, b: Nat) -> Nat {
  switch (a, b) {
  case (_, .Zero), (.Zero, _):
    return .Zero
  case let (.Succ(pred_a), _):
    return pred_a() * b + b
  }
}


// Multiplication examples:
one * four == four
two * two == four
four * three == two + two * five
two * three == five


/*------------------------------------/
//  Power ^
//
//  Note: a^b = (a^(b-1)) * a)
/------------------------------------*/
infix operator ^ {}
func ^ (a: Nat, b: Nat) -> Nat {
  switch (a, b) {
  case (.Zero, _):
    return .Zero
  case (_, .Zero):
    return one
  case let (_, .Succ(pred_b)):
    return (a ^ pred_b()) * a
  }
}


// Power examples:
(zero ^ zero) == zero
(zero ^ one) == zero
(zero ^ two) == zero
(one ^ zero) == one
(two ^ zero) == one
(two ^ two) == four


/*------------------------------------/
//  Comparable < <= >= >
//
//  Note: a-1 < b-1
/------------------------------------*/
extension Nat : Comparable {}
func <(a: Nat, b: Nat) -> Bool {
  switch (a, b) {
  case (.Zero, .Zero):
    return false
  case (.Succ, .Zero):
    return false
  case (.Zero, .Succ):
    return true
  case let (.Succ(pred_a), .Succ(pred_b)):
    return pred_a() < pred_b()
  }
}

// Comparison examples:
one < two
two < one
one <= one
two <= one
one > zero
zero > one
two > one
three >= three
three >= two
two >= three


/*------------------------------------/
//  Subtraction -
//
//  Warning: This only handles positive
//  results. (i.e. where a > b)
//
//  Note: a-b = (a-1)-(b-1)
/------------------------------------*/
func subtract (a: Nat, b: Nat) -> Nat {
  switch (a, b) {
  case (.Zero, .Zero):
    return .Zero
  case (_, .Zero):
    return a
  case (.Zero, .Succ):
    assertionFailure("Only handles Natural numbers! (a-b) where (b>a)")
  case let (.Succ(pred_a), .Succ(pred_b)):
    return subtract(pred_a(), pred_b())
  }
}

func - (a: Nat, b: Nat) -> Nat {
  return subtract(a, b)
}


// Subtraction examples:
two - two == zero
two - one == one
three - one == two
three - two == one


/*------------------------------------/
//  Division /
//
//  Warning: Truncates return value, 
//  returning only Natural numbers.
//  Effectively rounds down.
//
//  Note: a/b =
//    | b == 0 = error!
//    | a < b  = 0
//    | a >= b = (a - b)/b + 1
/------------------------------------*/
func / (a: Nat, b: Nat) -> Nat {
  if b == zero {
    assertionFailure("Divide by zero error!")
  } else if a < b {
    return zero
  } else {
    return ((a - b) / b) + one
  }
}


// Division examples:
three / four == zero
four / three == one
four / four == one
four / two == two
one / four == zero







