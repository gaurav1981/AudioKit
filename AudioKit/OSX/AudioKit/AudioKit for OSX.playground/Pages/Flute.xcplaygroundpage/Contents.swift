//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## Flute
//: ### Physical model of a Flute
import AudioKit
import XCPlayground

let playRate = 2.0

let flute = AKFlute()

let reverb = AKReverb(flute)

AudioKit.output = reverb
AudioKit.start()
let scale = [0, 2, 4, 5, 7, 9, 11, 12]

AKPlaygroundLoop(frequency: playRate) {
    var note = scale.randomElement()
    let octave = randomInt(2...5)  * 12
    if random(0, 10) < 1.0 { note += 1 }
    if !scale.contains(note % 12) { print("ACCIDENT!") }
    
    let frequency = (note+octave).midiNoteToFrequency()
    if random(0, 6) > 1.0 {
        flute.trigger(frequency: frequency)
    }
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
