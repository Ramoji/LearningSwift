import UIKit



// Optionals

let scores = ["kyle": 111, "newton": 80]
let kylesScore : Int? = scores["kyle"]

if kylesScore != nil {
    // Must use `!` to force unwrap to a non-optional type:
    println("Kyle's score is \(kylesScore!)")
}


// Optional Binding...
if let score = scores["newton"] {
    // So, `!` is not required:
    println("Newton's score is \(score)")
} else {
    println("Score not found.")
}


// SIDENOTE: ??
let maybeInt : Int? = nil
let aNumber = maybeInt ?? 10
println("Number is \(aNumber).")


let defaultName : () -> String = {
    println("Expensive Computation")
    return "Default Name"
}
let maybeName : String? = nil
let aName = maybeName ?? defaultName()
println("Number is \(aName).")
defaultName()


// Optional Chaining
struct Address {
    let state: String?
}
struct Person {
    let address: Address?
}
struct Order {
    let person: Person?
}
var order = Order(person: Person(address: Address(state: "CA")))
let state = order.person?.address?.state?
if state != nil {
    println("Order is from \(state!).")
}
if let orderState = order.person?.address?.state? {
    println("Order is from \(orderState).")
}



