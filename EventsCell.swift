//
//  EventsCell.swift
//  Bound MVP 2.1
//
//  Created by Ryan Cornel on 8/5/19.
//  Copyright © 2019 Ryan Cornel for Bound. All rights reserved.
//

import UIKit
import EventKit

class EventsCell: UITableViewCell {

    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var youreCheckedIn: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var berriesRewardAmount: UILabel!
    @IBOutlet weak var checkInStatus: UILabel!
    
    let randomizedTokenAmount = Int.random(in: 10...100)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkInButtonPressed() {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    let str = formatter.string(from: Date())
    
    checkInButton.isHidden = true
    youreCheckedIn.isHidden = false
    
    checkInStatus.text = str
    
    if checkInButton.isEnabled == true {
        
        checkInButton.isHidden = false
        youreCheckedIn.isHidden = true
        
        let tokenAmountString = String(randomizedTokenAmount)
        
        berriesRewardAmount.text = ("You earned \(tokenAmountString) tokens!")
        
        berriesRewardAmount.text = String(randomizedTokenAmount)
        
        }
    }
    
    
    /*
           /********************/
           // Calendars
           let calendar = Calendar.autoupdatingCurrent
           let eventStore = EKEventStore()
           
           // Ask for Calendar access
           func requestAccessToCalendar() {
           self.eventStore.requestAccess(to: EKEntityType.event, completion: {
                   (accessGranted: Bool, error: NSError?) in
           if accessGranted == true {
                       DispatchQueue.main.async(execute: {
           self.loadCalendars()
           self.refreshTableView()
                       })
                   } else {
                       DispatchQueue.main.async(execute: {
           self.showMessagePrompt("Permission Error", message: "Needs calendar permission.")
                       })
                   }
               } as! EKEventStoreRequestAccessCompletionHandler)
           }
           
           // Check calendar authorization status
           func checkCalendarAuthorizationStatus() {
           let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
           switch (status) {
           case EKAuthorizationStatus.notDetermined:
           // This happens on first-run
                   requestAccessToCalendar()
           case EKAuthorizationStatus.authorized: break
           // All good
               case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
           // We need to help them give us permission
                   self.showMessagePrompt("Permission Error", message: "Needs calendar permission.")
               }
           }
           
           // Get all events
           func getEvents() -> [EKEvent] {
           var allEvents: [EKEvent] = []
           // calendars
               let calendars = self.eventStore.calendars(for: .event)
           // iterate over all selected calendars
               for (_, calendar) in calendars.enumerated() where isCalendarSelected(calendar.calendarIdentifier) {
           // predicate for today (start to end)
                   let predicate = self.eventStore.predicateForEvents(withStart: self.initialDates.first!, end: self.initialDates.last!, calendars: [calendar])
           let matchingEvents = self.eventStore.events(matching: predicate)
           // iterate through events
                   for event in matchingEvents {
                       allEvents.append(event)
                   }
               }
           return allEvents
           } */
    

}
