//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Alfredo Quintero Tlacuilo on 1/7/17.
//  Copyright © 2017 Alfredo Quintero Tlacuilo. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: UIButton){
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton){
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton){
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton){
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton){
        processOperation(operation: currentOperation)
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        if currentOperation != Operation.Empty {
            //In case a user selected two operators, but not selected a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                leftValStr = result
                outputLbl.text = result
            }
            currentOperation = operation
        }
        else {
            //First time an operator has been pressed
            if runningNumber != "" {
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = operation
            }
        }
    }
    
    
    @IBAction func onClearPressed(_ sender: UIButton) {
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        result = ""
        outputLbl.text = "0"
    }

}

