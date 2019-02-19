//
//  CreateEventVC.swift
//  Eventboard
//
//  Created by Patrick Li on 2/18/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

//We can move these classes into sepearte files or into the insideEvent vc file later
class EventObject{
    //var event_id: String
    var event_creator_id: String
    var event_title: String
    var event_summary: String
    var geo_radius: Int
    var lat: Double
    var long: Double
    var date_created: NSDate
    var comments_enabled: Bool
    var post_id_list: [PostObject]
    
    init(event_creator_id: String, title: String, summary: String, geo_radius: Int, lat: Double, long: Double, post_id_list: [PostObject], date_created: NSDate, comments_enabled: Bool) {
        self.event_creator_id = event_creator_id
        self.event_title = title
        self.event_summary = summary
        self.geo_radius = geo_radius
        self.lat = lat
        self.long = long
        self.post_id_list = post_id_list
        self.date_created = date_created
        self.comments_enabled = comments_enabled
    }
}

class CreateEventVC: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation for location tracking from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

        /*
        //read firestore data for testing
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }*/
    }
    
    //get current location of device, will be useful when implementing location select through mapview
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    //this function is called when eventbutton is pressed and also handles creating a event inside firestore. Does not include calls to other functions in this vc other than firestore api.
    @IBAction func createEventButtonPressed(_ sender: Any) {
        
        var event_creator_id: String = "thisisadefaultid" //get from current user
        var event_title: String = "default title" //get from text field
        var event_summary: String = "default summary: blockchain with neural net capabilities are awesome and also we serve chocolates" //get from text field
        var geo_radius: Int = 100 //set as default for now (100 meters)
        var lat: Double = 37.262865 //get from selected point on a map view
        var long: Double = -122.033150
        var date_created: NSDate = NSDate() //leave as is
        var comments_enabled: Bool = false //set as false as default
        
        let docData: [String: Any] = [
            "event_creator_id": event_creator_id,
            "event_title": event_title,
            "event_summary": event_summary,
            "geo_radius": geo_radius,
            "lat": lat,
            "long": long,
            "date-created": date_created,
            "comments_enabled": comments_enabled
        ]
        
        db.collection("events").addDocument(data: docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
