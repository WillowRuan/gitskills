//
//  ReminderTableViewController.swift
//  Reminder2
//
//  Created by Tingting Xun on 13/05/2020.
//  Copyright © 2020 Tingting Xun. All rights reserved.
//  version 11.4.1

/*
 Reference for ToolBar Items
// https://stackoverflow.com/questions/39496922/how-to-place-toolbar-above-or-below-scrolling-tableview
// https://stackoverflow.com/questions/25325218/how-to-align-uibarbuttonitem-in-uitoolbar-in-ios-universal-app
*/

import UIKit
import CoreData

// 1. schedulling notifications
// 2. authorizing permission from the user to sechdule their notification
import UserNotifications

class ReminderTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate {
    
    // variables for search function
    @IBOutlet weak var searchBar: UISearchBar!
    var searchBarText : String = ""
    
    // bool to control between single and multiple selections
    var ifMultipleSelection = false
    
    // core data objects context, entity, managedObject, frc(fetch result controller)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var entity : NSEntityDescription! = nil
    var reminderManagedObject : CDReminder! = nil
    var frc : NSFetchedResultsController<NSFetchRequestResult>! = nil
    
    
    // fetch data
    func makeRequest()-> NSFetchRequest<NSFetchRequestResult>{
        
        // make a request for entity CDReminder
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CDReminder")
        
        // describe how to sort and how to filter it
        // sort by title
        let sorter = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sorter]
        
        //let predicate = NSPredicate(format: "%K == %@", "title", "hello")//k is the attribute, @ is the value
        //request.predicate = predicate
        if (searchBarText != "") {
            // search by title name
            request.predicate = NSPredicate(format: "title contains[c] '\(searchBarText)'")
        }
        
        return request
    }
    
    /*
     Reference for buttons
     // https://stackoverflow.com/questions/26641571/how-to-change-button-text-in-swift-xcode-6/39165610
     */
    // set button's outlet in order to change title later
    @IBOutlet weak var varEditMultipleSelections: UIBarButtonItem!
    
    // set button's action
    @IBAction func editMultipleSelections(_ sender: Any) {
        // when clicking on Edit button
        if(ifMultipleSelection == false){
            enableMultipleEdit()
        }
        // when clicking on Cancel button
        else{
            disableMultipleEdit()
        }
    }
    
    @IBOutlet weak var varDeleteButton: UIBarButtonItem!
    
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        
        // https://www.hangge.com/blog/cache/detail_1320.html
        if let selectedItems = tableView!.indexPathsForSelectedRows {
            
            // https://blog.csdn.net/youshaoduo/article/details/53010395
            for indexPath in selectedItems.reversed() {
                //selectedIndexs.append(indexPath.row)
                deleteItem(indexPath: indexPath)
            }
            
        }
        // reload table view
        tableView.reloadData()
        
        disableMultipleEdit()
    }
    
    func enableMultipleEdit(){
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.setEditing(true, animated: false)
        ifMultipleSelection = true

        varEditMultipleSelections.title = "Cancel"
        //varEditMultipleSelections.isEnabled = false
        
        varDeleteButton.isEnabled = true
        varDeleteButton.title = "Delete"
    }
    
    func disableMultipleEdit(){
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.setEditing(false, animated: false)
        ifMultipleSelection = false
        varEditMultipleSelections.title = "Edit"
        
        varDeleteButton.isEnabled = false
        varDeleteButton.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // allow multiple selection
        tableView.allowsMultipleSelectionDuringEditing = true
        // disable Delete button
        varDeleteButton.isEnabled = false
        varDeleteButton.title = ""
        
        // make frc and fetch
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        searchBar.delegate = self
        
        do{try frc.performFetch()}
        catch{print("fetch does not work")}
        
        notificationF()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
    }

    // MARK: - Table view data source
    
    // when change data, reload the tableview
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return frc.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        
        // get from frc the object at indexPath
        reminderManagedObject = (frc.object(at: indexPath) as! CDReminder)
        
        // Configure the cell...
        cell.textLabel?.text = reminderManagedObject.title
        
        let date = reminderManagedObject.date
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm dd,MMM,YYYY"
        cell.detailTextLabel?.text = formatter.string(from: date!)
        
        //cell.detailTextLabel?.text = reminderManagedObject.date?.description
        return cell
    }
    
    
    // if using override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Please comment out this func
    // pass selected data to detail view controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (ifMultipleSelection == false) {
         
        let destination = storyboard!.instantiateViewController(withIdentifier: "RDetailViewControllerID") as! RDetailViewController
        
        // Pass the selected object to the new view controller.
        
        // fetch data from core data and put it into the new object
        reminderManagedObject = (frc.object(at: indexPath) as! CDReminder)
        
        // pass the data to the destination view controller
        destination.reminderManagedObject = reminderManagedObject
        
        // push the new view controll to stack
        self.navigationController?.pushViewController(destination, animated: true)
        
        }
        
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteItem(indexPath: indexPath)
            
            // reload tableview
            tableView.reloadData()
        }
    }
    
    // function to delete data in Coredata and reload the table view
    func deleteItem(indexPath: IndexPath){
        // get object remove and delete
        reminderManagedObject = (frc.object(at: indexPath) as! CDReminder)
        context.delete(reminderManagedObject)
        
        // remove notification
        removeNotification(notificationID: reminderManagedObject.notificationID!)
        
        // save the context
        do{try context.save()}
        catch{}
        
       
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // NOTIFICATION function
    // fire test notification
    // get the permission, first request the permission
    // handle the secheduling and request
    // shows reminder want to send you the notification, do you allow or not
    func notificationF(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in if success{
                // schedule test
                //self.scheduleTest()
        }else if error != nil {
                print("error occurred")
        }
            
        })
    }
    
    /*
    // notification test
    func scheduleTest(){
        //given the date in the future we want to get the notification
        let content = UNMutableNotificationContent()
        content.title = "Working"
        content.sound = .default
        content.body = "Im working"
        
        let targetDate = Date().addingTimeInterval(10)
        // particular date, notification repeat
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
            if error != nil {
                print("went wrong")
            }
        })
    }
    */
    
    func removeNotification(notificationID : String){
        let center = UNUserNotificationCenter.current()
        center.removeDeliveredNotifications(withIdentifiers: [notificationID])  // to remove delivered notifications with notification id
        center.removePendingNotificationRequests(withIdentifiers: [notificationID])  // to remove pending notifications  with notification id
        //UIApplication.shared.applicationIconBadgeNumber = 0 // to clear the icon notification badge
    }
    
    
    
    // SEARCHBAR function to search from table
    // display new result when search bar text changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarText = searchBar.text!
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        do{try frc.performFetch()}
        catch{print("FETCH DOES NOT WORK")}
        
        tableView.reloadData()
    }
    var ifSingleSelect = false
    // MARK: - Navigation
    
    
    // below is using segue to pass data to next view controller
    // need to link tableviewcontroller and next view controller in storyboard, set segue id "detailSegue"
    // cannot using it with
    // override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "detailSegue"{
            // Get the new view controller using segue.destination.
            let destination = segue.destination as! RDetailViewController
            
            // Pass the selected object to the new view controller.
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            // fetch data from core data and put it into the new object
            reminderManagedObject = (frc.object(at: indexPath!) as! CDReminder)
            
            // pass the data to the destination view controller
            destination.reminderManagedObject = reminderManagedObject
        }
    }
    */
    

}
