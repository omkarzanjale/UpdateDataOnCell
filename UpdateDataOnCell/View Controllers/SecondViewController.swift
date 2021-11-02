//
//  SecondViewController.swift
//  UpdateDataOnCell
//
//  Created by Mac on 05/10/21.
//

import UIKit

protocol BackDataProtocol: AnyObject {
    func backData(_ studentUpdated: Student,_ indexPath : IndexPath)
}

class SecondViewController: UIViewController {
    //
    //MARK: Outlets
    //
    @IBOutlet weak var mobTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var rnoTF: UITextField!
    
    weak var delegate :BackDataProtocol?
    var student: Student?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit details"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(updateBtnAction))
        guard let rno = student?.rno else {
            return
        }
        rnoTF.text = String(rno)
        nameTF.text = student?.name
        mobTF.text = student?.mob
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func validateInput() -> Student? {
        guard let rno = rnoTF.text else {
            return nil
        }
        guard let name = nameTF.text else {
            return nil
        }
        guard let contact = mobTF.text else {
            return nil
        }
        
        if rno.isEmpty==true||name.isEmpty==true||contact.isEmpty==true {
            showAlert(title: "Warning", message: "Enter all fields!!!")
            return nil
        }else{
            guard let rno = Int(rno) else {
                return nil
            }
            let student = Student(rno: rno, name: name, mob: contact)
            return student
        }
    }
    
    @objc func updateBtnAction(){
        if let student = validateInput() {
            guard let indexPath = indexPath else {
                return
            }
            delegate?.backData(student,indexPath)
            navigationController?.popViewController(animated: true)
        }else{
            print("Nil value obtained from textFields")
        }
    }
}
