//
//  CustomCell.swift
//  UpdateDataOnCell
//
//  Created by Mac on 05/10/21.
//

import UIKit

protocol CustomCellProtocol : AnyObject{
    func btnAction(_ student: Student, _ indexPath: IndexPath)
}

class CustomCell: UITableViewCell {
    weak var delegate : CustomCellProtocol?
    
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rnoLabel: UILabel!
    
    var iPath : IndexPath?
    @IBAction func editBtnAction(_ sender: Any) {
        guard let rno = rnoLabel.text else {
            return
        }
        let student = Student(rno: Int(rno) ?? 0, name: nameLabel.text ?? "", mob: mobileLabel.text ?? "")
        guard let iPath = iPath else {
            return
        }
        delegate?.btnAction(student,iPath)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

