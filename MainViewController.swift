//
//  MainViewController.swift
//  Bound MVP 2.1
//
//  Created by Ryan Cornel on 8/1/19.
//  Copyright © 2019 Ryan Cornel for Bound. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import CloudKit
import MapKit


class MainViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    
    @IBOutlet weak var TableView: UITableView!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        
        TableView.delegate = self
        TableView.dataSource = self
        
        TableView.register(UINib(nibName: "EventsCell", bundle: nil), forCellReuseIdentifier: "EventsCell")
        
        configureTableView()
        
        getEvents()

        
        //detailsLabel.text = user?.debugDescription ?? ""
        
    }
    
    // Establishes Background Image.
    let backgroundImageView = UIImageView()
    
    // Sets Background Image.
    func setBackground() {
        
        view.addSubview(backgroundImageView)
        
    
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0   ).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        
        backgroundImageView.image = UIImage(named: "Bound Signin Resized")
        view.sendSubviewToBack(backgroundImageView)
        
    }
    
/// Functions / Methods for Table View
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
         return 10
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as! EventsCell
         /*
         let messageArray = [StringLiteralType].self
         
         //cell.eventLabel.text = messageArray[indexPath.row] */
         
         return cell
         
     }
     
     func configureTableView() {
         
         TableView.rowHeight = UITableView.automaticDimension
         TableView.estimatedRowHeight = 268.0
         
     }
    
     
    // Helper function for showing UIAlert prompts
    func showMessagePrompt(_ title: String, message: String) {
    let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }
    
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
    //self.loadCalendars()
    //self.refreshTableView()
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
    /*
    // iterate over all selected calendars
        for (_, calendar) in calendars.enumerated() where isCalendarSelected(calendar.calendarIdentifier) {
    // predicate for today (start to end)
            let predicate = self.eventStore.predicateForEvents(withStart: self.initialDates.first!, end: self.initialDates.last!, calendars: [calendar])
    let matchingEvents = self.eventStore.events(matching: predicate)
    // iterate through events
            for event in matchingEvents {
                allEvents.append(event)
            }
        } */
    return allEvents
    }
 

}
