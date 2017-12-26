//
//  GetFactorsVC.swift
//  GetFactors
//
//  Created by ev_mac6 on 23/12/17.
//  Copyright © 2017 ev_mac6. All rights reserved.
//

import UIKit

class GetFactorsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var numbTxtFld: UITextField!
    @IBOutlet weak var getResultBtn: UIButton!
    @IBOutlet weak var factorsCollection: UICollectionView!
    @IBOutlet weak var factorsResultLbl: UILabel!
    
    var factorsArr          = [Int]()
    var clickCount : Int!   = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        numbTxtFld.becomeFirstResponder()
        
        self .factorsCollection.register(UINib(nibName: "FactorsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FactorsCollectionCell")
        factorsCollection.isHidden = true
        factorsResultLbl.isHidden = true
        
        factorsCollection.layer.borderWidth = 1
        factorsCollection.layer.borderColor = UIColor.black.cgColor
        factorsCollection.layer.cornerRadius = 5
        factorsCollection.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - User Defined Methods
    
    func factors(ofNumber: Int) -> [Int]
    {
        return (1...ofNumber).filter { ofNumber % $0 == 0 }
    }
    
    func calculateWidthString(str : String,height: CGFloat) -> CGFloat
    {
        var sizeOfString = CGSize()
        let font = UIFont.systemFont(ofSize: 40)
        let attributes = [NSAttributedStringKey.font : font]
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        sizeOfString = str.size(withAttributes: attributes)
        return sizeOfString.width
    }

    
    @IBAction func getResultBtnAction(_ sender: UIButton)
    {
        if numbTxtFld.text != ""
        {
            if clickCount == 0
            {
                //calculate factors
                factorsArr = factors(ofNumber: Int(numbTxtFld.text!)!)
                
                //change UI
                if factorsArr.count > 0
                {
                    factorsCollection.isHidden = false
                    factorsResultLbl.isHidden = true
                    numbTxtFld.isUserInteractionEnabled = false
                    factorsCollection.reloadData()
                    clickCount = 1
                    
                    getResultBtn.setTitle("DISPLAY FACTORS", for: .normal)
                }
            }
            else if clickCount == 1
            {
                //change UI
                if factorsArr.count > 0
                {
                    factorsResultLbl.isHidden = false
                    factorsResultLbl.text = String(describing: factorsArr)
                    clickCount = 2
                    
                    getResultBtn.setTitle("CLEAR & TRY AGAIN", for: .normal)
                }
            }
            else
            {
                //change UI
                
                numbTxtFld.text = ""
                
                numbTxtFld.isUserInteractionEnabled = true
                factorsCollection.isHidden = true
                factorsArr.removeAll()
                
                factorsResultLbl.text = ""
                factorsResultLbl.isHidden = true
                
                clickCount = 0
                
                numbTxtFld.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Enter a number!", comment: ""), attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
                
                getResultBtn.setTitle("GET FACTORS", for: .normal)
            }
        }
        else
        {
            numbTxtFld.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Please enter a number!", comment: ""), attributes: [NSAttributedStringKey.foregroundColor: UIColor.red])
        }
    }
    
    //MARK: - UICollectionView Delegate Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.factorsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let valStr = String(factorsArr[indexPath.row])
        let strWidth = calculateWidthString(str: valStr, height: 50)
        print("strWidth",strWidth)
        if strWidth > 30
        {
            return CGSize(width: strWidth, height: 50)
        }
        else
        {
            return CGSize(width: 50, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let factorsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FactorsCollectionCell", for: indexPath) as! FactorsCollectionCell
        factorsCell.valueLbl.text = String(factorsArr[indexPath.row])
        return factorsCell
    }
}
