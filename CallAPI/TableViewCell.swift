//
//  TableViewCell.swift
//  CallAPI
//
//  Created by Nguyen Thi Huong on 8/31/20.
//  Copyright © 2020 Nguyen Thi Huong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAge: UILabel!
    
    @IBOutlet weak var imagePeople: UIImageView!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
      func setData(data: DataAttribute) {
        lblName.text = data.userName
        lblGender.text = data.gender
        lblAge.text = String(data.age)
        lblLocation.text = data.location
        URLSession.shared.dataTask(with: NSURL(string: data.image)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.imagePeople.image = image
            })
        }).resume()
    }
}
