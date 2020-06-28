//
//  RAddViewController.swift
//  Reminder2
//
//  Created by Tingting Xun on 13/05/2020.
//  Copyright © 2020 Tingting Xun. All rights reserved.
//  version 11.4.1

import UIKit
import CoreData

class RAddViewController: UIViewController {
    
    // outlets and action
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func saveAction(_ sender: Any) {
        save()
        
        // force navigation back to table view controller
        navigationController?.popViewController(animated: true)
        
    }
    
    // core data objects context, entity, managedObject, frc(fetch result controller)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entity : NSEntityDescription! = nil
    var reminderManagedObject : CDReminder! = nil
    
    // save new managedObject
    func save(){
        
        // make a new managedObject
        reminderManagedObject = CDReminder(context: context)
        
        // fill with data from textfields
        reminderManagedObject.title = titleTextField.text
        reminderManagedObject.notes = notesText.text
        reminderManagedObject.date = datePicker.date
        // using the initial name as notification ID
        reminderManagedObject.notificationID = titleTextField.text
        
        // save and exception
        do{
            try context.save()
        }catch{
            print("core data does not save")
        }
        
        // add notification
        addNotification(title: reminderManagedObject.title!, body: reminderManagedObject.notes!, date: reminderManagedObject.date!, id : reminderManagedObject.notificationID!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "add new reminder"
        
        // Do any additional setup after loading the view.
    }
    
    // add new notification
    func addNotification(title : String, body : String, date : Date, id : String){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = body
        
        let targetDate = date
        // particular date, notification repeat
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print("went wrong")
            }
        })
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
