//
//  DiaryViewController.swift
//  Reminder2
//
//  Created by Tingting Xun on 23/06/2020.
//  Copyright © 2020 Tingting Xun. All rights reserved.
//

import UIKit
import FSCalendar

class DiaryViewController: UIViewController,FSCalendarDataSource,FSCalendarDelegate {

    private weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar

    }
    
    /* change font and colour
    _calendar.appearance.autoAdjustTitleSize = NO;
    _calendar.appearance.titleFont = otherTitleFont;
    _calendar.appearance.subtitleFont = otherSubtitleFont;
     
     _calendar.appearance.todayColor = [UIColor clearColor];
     _calendar.appearance.titleTodayColor = _calendar.appearance.titleDefaultColor;
     _calendar.appearance.subtitleTodayColor = _calendar.appearance.subtitleDefaultColor;
    */
    
    // Add event for some day
    // FSCalendarDataSource
    //- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date
    //{
      //  return shouldShowEventDot;
    //}

    
    // Add image for some day
    // FSCalendarDataSource
    //- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
    //{
        //return anyImage;
    //}
    
    
    
    // DO SOMETHING WHEN A DATE IS SELECTED
    // FSCalendarDelegate
    //- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
    //{
        // Do something
    //}
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
