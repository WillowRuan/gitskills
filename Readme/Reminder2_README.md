## Reminder2 ： Using CoreData fixed the problem which can not save the input information from the project of Reminder

_The link to download the XCode/Swift_

https://swift.org/download/#releases

### Steps to install XCode (For macOS-Catalina version 10.15.4)

1. Download the latest version of XCode 11.4.1
   From: https://swift.org/download/#releases
   or from App Store
2. Follow the steps to install the XCode into application
3. Create a new folder
4. Open your terminal -> go the the folder
5. using command to clone the project: ```git clone git@github.com:jq5/MISL-SOC-20-Tingting.git```
6. After clone, open the folder name "ProjectDemo - MyProject"
7. Below explain how to run project "Reminder2"

### Steps to run XCode project

1. Open ***MyProject.xcworkspace*** as image below. XCode then will open the project.
![](../Screenshot/Diary/FolderDiary.png)

2.  On the top left corner, select ***iPhone 11 Pro Max***, then click the run button.
![](../Screenshot/Diary/RunDiary.png)

3. Wait until the simulator pop up, it might take few minutes, then you can see the homepage, click the Reminder button on the page.
![](../Screenshot/Reminder2/HomeReminder2.png)

4. There is a **search bar** at the top of the Reminder main page, and you can search according to the input.

5. There is an **Edit** icon in the lower left corner of the Reminder homepage, which allows you to make batch changes or select multiple items to delete.

6. In the upper right corner is the **+** button to add a new reminder. Click on it to enter the interface to add a new event.
![](../Screenshot/Reminder2/ButtonReminder2.png)

7. On the add event page, it has *title*, *notes* and *time* as image shown below, you can have a try to edit all of them.
![](../Screenshot/Reminder2/AddReminder2.png)

8. Back to the homepage, it shows all the events as image below. 
![](../Screenshot/Reminder2/DetailReminder2.png)

9. Swipe the events to the left and can choose to delete it, can also click the Edit button to delete.
![](../Screenshot/Reminder2/DeleteReminder2_1.png)
![](../Screenshot/Reminder2/DeleteReminder2_2.png)

10. Click the added events on the homepage to enter the interface to shown events details.

11. There is an **edit** icon in the upper right corner of the details page, click it to enter the interface to edit events.
![](../Screenshot/Reminder2/EditReminder2.png)

12. In the editing page can also has *title*, *notes* and *time*. Click **save** to jump back to the details page.
![](../Screenshot/Reminder2/DetailpageReminder2.png)

13. You can receive the notification at the time you set.
![](../Screenshot/Reminder2/NotificationReminder2.png)


### Future Work

1. Add the cancel and edit functions on the Reminder home page **(Solved)**
2. Advance notification function **(Solved)**
3. Update CoreData **(Solved)**
4. Update interface

### Reference

1. When making the Reminder, the edited content cannot be displayed in the details screen after editing. **(Solved)**

Solution: 

https://stackoverflow.com/questions/24038215/how-to-navigate-from-one-view-controller-to-another-using-swift
