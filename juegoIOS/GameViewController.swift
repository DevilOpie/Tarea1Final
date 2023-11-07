//
//  File.swift
//  juegoIOS
//
//  Created by Javier González on 7/11/23.
//

import Foundation
import UIKit

public class GameViewController: UIViewController {
    var playerNums: [Int] = []
    var timer:Timer = Timer()
    var order:[Int] = [0,1,2,3]
    var i = 0
    let imageArray: [UIImage]=[UIImage(named: "king")!,UIImage(named: "queen")!,UIImage(named: "pawn")!,UIImage(named: "knight")!]
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mostrarImagen), userInfo: nil, repeats: true)
        order.shuffle()
        print(order)
    }
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var mainImg: UIImageView!
    
    @IBAction func pressedButton(_ sender:UIButton!) {
        for i in 0..<buttons.count {
            if sender==buttons[i]{
                playerNums.append(i)
                print(playerNums)
            }
        }
    }
    
    @objc func mostrarImagen(){
       
        if i==imageArray.count{
            timer.invalidate()
        }
        else{
            mainImg.image=imageArray[order[i]]
            i += 1
        }
        if playerNums.count == 4{
            var score = compareArrays()
            performSegue(withIdentifier: "toScoreView", sender: score)
        }
        print (i)
    }
     func compareArrays()-> Int{
        var score = 0
        for i in 0..<order.count {
               if order[i] == playerNums[i] {
                   score += 1
               }
           }
         return score
    }
    
    
}
    
