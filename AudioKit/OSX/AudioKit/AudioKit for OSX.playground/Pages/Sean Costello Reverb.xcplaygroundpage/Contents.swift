//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## Sean Costello Reverb
//: ### This is a great sounding reverb that we just love.
import XCPlayground
import AudioKit

let file = try AKAudioFile(readFileName: "drumloop.wav", baseDir: .Resources)

let player = try AKAudioPlayer(file: file)
player.looping = true
var reverb = AKCostelloReverb(player)

//: Set the parameters of the reverb here
reverb.cutoffFrequency = 9900 // Hz
reverb.feedback = 0.92

AudioKit.output = reverb
AudioKit.start()

player.play()

//: User Interface Set up

class PlaygroundView: AKPlaygroundView {
    
    var cutoffFrequencyLabel: Label?
    var feedbackLabel: Label?
    var cutoffFrequencySlider: Slider?
    var feedbackSlider: Slider?
    
    override func setup() {
        addTitle("Sean Costello Reverb")
        
        addLabel("Audio Playback")
        addButton("Drums", action: #selector(startDrumLoop))
        addButton("Bass", action: #selector(startBassLoop))
        addButton("Guitar", action: #selector(startGuitarLoop))
        addButton("Lead", action: #selector(startLeadLoop))
        addButton("Mix", action: #selector(startMixLoop))
        addButton("Stop", action: #selector(stop))
        
        cutoffFrequencyLabel = addLabel("Cutoff Frequency: \(reverb.cutoffFrequency)")
        addSlider(#selector(setCutoffFrequency), value: reverb.cutoffFrequency, minimum: 0, maximum: 5000)
        
        feedbackLabel = addLabel("Feedback: \(reverb.feedback)")
        addSlider(#selector(setFeedback), value: reverb.feedback, minimum: 0, maximum: 0.99)
        
        addButton("Short Tail", action: #selector(presetShortTail))
        addButton("Low Ringing Tail", action: #selector(presetLowRingingTail))
    }
    
    func startLoop(part: String) {
        player.stop()
        let file = try? AKAudioFile(readFileName: "\(part)loop.wav", baseDir: .Resources)
        try? player.replaceFile(file!)
        player.play()
    }
    
    func startDrumLoop() {
        startLoop("drum")
    }
    
    func startBassLoop() {
        startLoop("bass")
    }
    
    func startGuitarLoop() {
        startLoop("guitar")
    }
    
    func startLeadLoop() {
        startLoop("lead")
    }
    
    func startMixLoop() {
        startLoop("mix")
    }
    
    func stop() {
        player.stop()
    }
    
    func setCutoffFrequency(slider: Slider) {
        reverb.cutoffFrequency = Double(slider.value)
        cutoffFrequencyLabel!.text = "Cutoff Frequency: \(String(format: "%0.0f", reverb.cutoffFrequency))"
        printCode()
    }
    
    func setFeedback(slider: Slider) {
        reverb.feedback = Double(slider.value)
        feedbackLabel!.text = "Feedback: \(String(format: "%0.3f", reverb.feedback))"
        printCode()
    }
    
    //: Audition Presets
    
    func presetShortTail() {
        reverb.presetShortTailCostelloReverb()
        updateUI()
    }
    
    func presetLowRingingTail() {
        reverb.presetLowRingingLongTailCostelloReverb()
        updateUI()
    }
    
    func updateUI() {
        updateTextFields()
        updateSliders()
        printCode()
    }
    
    func updateSliders() {
        cutoffFrequencySlider?.value = Float(reverb.cutoffFrequency)
        feedbackSlider?.value = Float(reverb.feedback)
    }
    
    func updateTextFields() {
        let cutoffFrequency = String(format: "%0.3f", reverb.cutoffFrequency)
        cutoffFrequencyLabel!.text = "Cutoff Frequency: \(cutoffFrequency)"
        
        let feedback = String(format: "%0.3f", reverb.feedback)
        feedbackLabel!.text = "Feedback: \(feedback)"
    }
    
    func printCode() {
        // Here we're just printing out the preset so it can be copy and pasted into code
        
        Swift.print("public func presetXXXXXX() {")
        Swift.print("    cutoffFrequency = \(String(format: "%0.3f", reverb.cutoffFrequency))")
        Swift.print("    feedback = \(String(format: "%0.3f", reverb.feedback))")
        Swift.print("}\n")
    }
}

let view = PlaygroundView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
XCPlaygroundPage.currentPage.liveView = view

//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
