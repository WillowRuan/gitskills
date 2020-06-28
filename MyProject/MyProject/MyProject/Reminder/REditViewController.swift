//
//  REditViewController.swift
//  Reminder2
//
//  Created by Tingting Xun on 17/05/2020.
//  Copyright © 2020 Tingting Xun. All rights reserved.
//  version 11.4.1

import UIKit


class REditViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //(一)声明一个block方法：
     var bbchange:((_ reminderObject:CDReminder)->Void)?
//(二)返回上一个页面并传递参数：
       
    @IBAction func saveBtnAction(_ sender: UIButton) {
        save()
        bbchange?(reminderManagedObject)
        self.navigationController?.popViewController(animated: true)
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var reminderManagedObject : CDReminder!
    
    // save new managedObject
    func save(){
        
        // fill with data from textfields
        reminderManagedObject.title = titleTextField.text
        reminderManagedObject.notes = notesText.text
        reminderManagedObject.date = datePicker.date
        
        // save and exception
        do{
            try context.save()
        }catch{
            print("core data does not save")
        }
        
        // edit notification
        editNotification(title: reminderManagedObject.title!, body: reminderManagedObject.notes!, date: reminderManagedObject.date!, id : reminderManagedObject.notificationID!)
        
    }
    
    // edit notification
    func editNotification(title : String, body : String, date : Date, id : String){
        
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = reminderManagedObject.title
        notesText.text = reminderManagedObject.notes
        datePicker.date = reminderManagedObject.date!

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "editSegue"{
            // Get the new view controller using segue.destination.
            let destination = segue.destination as! RDetailViewController
            
            // pass the data to the destination view controller
            destination.reminderManagedObject = reminderManagedObject
            
        }
    }
 
    

}
