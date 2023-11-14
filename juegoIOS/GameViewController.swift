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
        order.shuffle()
        //timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(mostrarImagen), userInfo: nil, repeats: true)
        timer=Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { t in
            self.mostrarImagen()
        })
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
        if playerNums.count == 4{
            punt = compareArrays()
            performSegue(withIdentifier: "toScoreView", sender: nil)
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
       
        //print (i)
    }
     func compareArrays()-> Int{
         punt = 0
        for i in 0..<order.count {
            if order[i] == playerNums[i] {
                      punt += 2
                  }
            else {
                      punt -= 1
                  }
              }
         return punt
    }
    
    
}
    
