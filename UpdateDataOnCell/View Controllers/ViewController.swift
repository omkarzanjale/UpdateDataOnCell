//
//  ViewController.swift
//  UpdateDataOnCell
//
//  Created by Mac on 05/10/21.
//
/*
 Program - Display students info on tableview cell on button click on perticular cell navigate to second page with data and edit that data and also display edited data on that cell on home page
*/

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var students = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Students"
        addStudents()
    }
    
    private func addStudents(){
        let student1 = Student(rno: 1, name: "Omkar", mob: "9022285087")
        self.students.append(student1)
        let student2 = Student(rno: 2, name: "Divya", mob: "9552398087")
        self.students.append(student2)
        let student3 = Student(rno: 3, name: "Kalyani", mob: "9665870646")
        self.students.append(student3)
        let student4 = Student(rno: 4, name: "Umesh", mob: "8669168369")
        self.students.append(student4)
        let student5 = Student(rno: 5, name: "Akash", mob: "9881474534")
        self.students.append(student5)
    }
}
//
//MARK: UITableViewDataSource
//
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)as? CustomCell {
            let student = students[indexPath.row]
            cell.rnoLabel.text = String(student.rno)
            cell.nameLabel.text = student.name
            cell.mobileLabel.text = student.mob
            cell.iPath = indexPath
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
//
//MARK: UITableViewDelegate
//
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        320
    }
}
//
//MARK: CustomCellProtocol
//
extension ViewController: CustomCellProtocol{
    func btnAction(_ student: Student,_ indexPath: IndexPath) {
        if let vc2Obj = storyboard?.instantiateViewController(identifier: "SecondViewController")as? SecondViewController{
            vc2Obj.student = student
            vc2Obj.indexPath = indexPath
            vc2Obj.delegate = self
            self.navigationController?.pushViewController(vc2Obj, animated: true)
        } else {
            print("SecondViewController cannot find in storyboard!!!")
        }
    }
}
//
//MARK: BackDataProtocol
//
extension ViewController : BackDataProtocol{
    func backData(_ studentUpdated: Student,_ indexPath : IndexPath) {
        let student = students[indexPath.row]
        student.rno = Int(studentUpdated.rno)
        student.name = studentUpdated.name
        student.mob = studentUpdated.mob
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
