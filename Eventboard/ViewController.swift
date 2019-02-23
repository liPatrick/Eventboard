//
//  ViewController.swift
//  Eventboard
//
//  Created by Patrick Li on 2/9/19.
//  Copyright © 2019 Patrick Li. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation
import Firebase

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 188/255, green: 156/255, blue: 255/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 139/255, green: 164/255, blue: 249/255, alpha: 1).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}

extension UIViewController {
    // convinience showAlert function
    func showAlert(title: String = "Notice", message: String, okButtonTitle: String = "Ok") -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addEventButton: UIButton!
    
    let db = Firestore.firestore()
    let locationManager = CLLocationManager()
    var data : [EventObject] = []
    var selectedEvent: EventObject!
    
    // read events
    func readEvents() {
        db.collection("events").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let creator_id = data["event_creator_id"] as! String
                    let event_title = data["event_title"] as! String
                    let event_summary = data["event_summary"] as! String
                    let geo_radius = data["geo_radius"] as! Int
                    let latitude = data["lat"] as! Double
                    let longitude = data["long"] as! Double
                    let comments = data["comments_enabled"] as! Bool
                    // date formatting
                    //let date_formatter = DateFormatter()
                    //let date = date_formatter.date(from: data["date"] as! String)
                    //date_formatter.dateFormat = .full
                    
                    let object = EventObject(event_creator_id: creator_id, title: event_title, summary: event_summary, geo_radius: Int(geo_radius), lat: latitude, long: longitude, post_id_list: [], date_created: "", comments_enabled: comments)
                    let loc = CLLocation(latitude: CLLocationDegrees(exactly: latitude)!, longitude: CLLocationDegrees(exactly: longitude)!)
                    if(self.dataIsValid(coord: loc, geo_radius: geo_radius)) {
                        self.data.append(object)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // get posts based on event id
    func getPosts(event_id: String) {
        
    }
    
    //check if event is in range of current location
    func dataIsValid(coord: CLLocation, geo_radius: Int) -> Bool {
        // get current location
        var curr_loc : CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            curr_loc = self.locationManager.location
            let distance = curr_loc.distance(from: coord)
            print("Distance = " + String(distance))
            if(distance <= Double(geo_radius)) {
                return true
            }
        }
        else{
            showAlert(message: "Please enable location services in settings")
        }
        return false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup colors
        
        let colors = Colors()

        // set background color
        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        
        //setup circular button
        self.addEventButton.layer.cornerRadius = 0.5 * self.addEventButton.bounds.size.width
        self.addEventButton.clipsToBounds = false
        
        // setup collection view
        // change this later to a UIPageController to have the three white dots
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        // init custom cells
        self.collectionView.register(UINib.init(nibName: "CardView", bundle: nil), forCellWithReuseIdentifier: "CardCell")
        
        //setup geolocation
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 1. status is not determined
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.locationManager.requestAlwaysAuthorization()
        }
            // 2. authorization were denied
        else if CLLocationManager.authorizationStatus() == .denied {
            showAlert(message: "Location services were previously denied. Please enable location services for this app in Settings.")
        }
            // 3. we do have authorization
        else if CLLocationManager.authorizationStatus() == .authorizedAlways {
            print("HERE")
            self.locationManager.startUpdatingLocation()
        }
        
        // download events from firebase
        // no filtering for distance yet
        print("About to read events")
        self.readEvents()
    }
    
    // replace later with real data loaded from firebase
    /*let data : [CardModel] = [(CardModel(image: UIImage(named: "coffee")!, summaryDescription: "Presenting on the effects of early childhood dementia, utilizing blockchain technologies and neural networks.")),
                              (CardModel(image: UIImage(named: "coffee")!, summaryDescription: "Presenting on the effects of simple convoluntional neural networks, using MATLab and Python.")),
                              (CardModel(image: UIImage(named: "coffee")!, summaryDescription: "Presenting on the effects of simple convoluntional neural networks, using MATLab and Python."))]*/
    //let data : [EventObject] = [(EventObject(event_creator_id: "1", title: "TEDx Saratoga High", summary: "We hit the quan like none other. This is a deep learning excercise for only the sickest people.", geo_radius: 100, lat: 37.280560, long: -121.978741, post_id_list: [], date_created: NSDate(), comments_enabled: false))]
   
    //perform segue when clicking on event
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedEvent = data[indexPath.row]
        self.performSegue(withIdentifier: "goToDetailEvent", sender: self)
    }
    
    //prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailPage = segue.destination as? InsideEventVC {
            detailPage.eventObject = selectedEvent
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardViewCell
        cell.configure(with: data[indexPath.row])
        //cell.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    // set min spacing between items
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        // leave just enough of the card so that it shows up
        // fix later with real #s based on screen size
        return ((self.view.frame.width / 2) + 50 - 137.5)
    }
    
    // set default size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // hardcoded for iphone xr
        return CGSize(width: 275, height: 375)
    }
    
    // set spacing on left
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // center item in screen, and leave a tiny bit of space for next element
        //let inset = UIEdgeInsets(top: 0, left: ((self.view.frame.width) / 2) - 162.5, bottom: 0, right: 70)
        // if single item, then center the element
        let insetSingleItem = UIEdgeInsets(top: 0, left: ((self.view.frame.width) / 2) - 137.5, bottom: 0, right: 70)
        
        // replace the hardcoded #s (162.5, 137.5) with screen.size.width stuff later
        // replace 70 with the size from minimumLineSpacing
        
        //return (self.collectionView.numberOfItems(inSection: 0) > 1 ? inset : insetSingleItem)
        
        return insetSingleItem
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255 ,
                  green: CGFloat(green)/255,
                  blue: CGFloat(blue)/255,
                  alpha: 1.0)
    }
}
