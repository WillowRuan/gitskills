//
//  RDetailViewController.swift
//  Reminder2
//
//  Created by Tingting Xun on 13/05/2020.
//  Copyright © 2020 Tingting Xun. All rights reserved.
//  version 11.4.1
    
import UIKit

class RDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var dateTextField: UILabel!
    @IBOutlet weak var notesText: UITextView!
    
    
    @IBAction func editBtnAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let threeVC = ThreeViewController()
         let rEditViewController = storyboard.instantiateViewController(withIdentifier: "REditViewController_ID") as! REditViewController
        rEditViewController.reminderManagedObject = self.reminderManagedObject
        
           rEditViewController.bbchange={
               ( reminderObject:CDReminder) in
                //self.reminderManagedObject = reminderObject
            self.updateView(tempReminderManagedObject: reminderObject)
           }
        
           self.navigationController?.pushViewController(rEditViewController, animated: true)
        
    }
    var reminderManagedObject : CDReminder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        updateView(tempReminderManagedObject: reminderManagedObject)
    }
    
    func updateView(tempReminderManagedObject : CDReminder!){
        if reminderManagedObject != nil{
            titleTextField.text = reminderManagedObject.title
            let date = reminderManagedObject.date
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm dd,MMM,YYYY"
            dateTextField.text = formatter.string(from: date!)
            notesText.text = reminderManagedObject.notes
        }
    }
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editSegue"{
        // Get the new view controller using segue.destination.
        let destination = segue.destination as! REditViewController
        
        // pass the data to the destination view controller
        destination.reminderManagedObject = reminderManagedObject
        }
    }
        
    */

}
