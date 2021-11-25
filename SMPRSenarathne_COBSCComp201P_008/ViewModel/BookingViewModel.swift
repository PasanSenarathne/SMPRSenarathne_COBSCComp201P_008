//
//  BookingViewModel.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
import SwiftUI
/*
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
*/
class BookingViewModel : ObservableObject{
    var db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @Published var member = [MemberDetails]()
    @Published var avaliableParkingLots = [ParkingLotsForPicker]()
    @Published var alert = ""
    @Published var alertTitle = ""
    @Published var isAlertPresent = false
    
 //   var locationManager = LocationManager();
    
    func GetUserDeatils(){
        member.removeAll()
        let userID = firebaseAuth.currentUser?.uid
        db.collection("Members").whereField("UserID", isEqualTo: userID ?? "").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.member = documents.map { (queryDocumentSnapshot) -> MemberDetails in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let userID = data["UserID"] as? String ?? ""
                let fName = data["FirstName"] as? String ?? ""
                let lName = data["LastName"] as? String ?? ""
                let nic = data["NIC"] as? String ?? ""
                let vehicleNo = data["VehicleNo"] as? String ?? ""
                print(data)
                return MemberDetails(id: id,userID: userID, firstName: fName, lastName: lName, nic: nic, vehicleNo: vehicleNo)
            }
        }
    }
    
    func GetAvailableParkingLots(){
        avaliableParkingLots.removeAll()
        db.collection("ParkingLots").whereField("Status", isEqualTo: "Available").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.avaliableParkingLots = documents.map { (queryDocumentSnapshot) -> ParkingLotsForPicker in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let parkingLotCode = data["ParkingLotCode"] as? String ?? ""
                let parkingLotType = data["ParkingLotType"] as? String ?? ""
                return ParkingLotsForPicker(id: id,parkingLotCode: parkingLotCode,parkingLotType: parkingLotType)
            }
        }
    }
    
    func Reservation(bookingInfo:BookingModel, memberID: String){
        if(bookingInfo.selectedParkingLot == ""){
            self.alert = "Please Select a Parking Lot"
            self.alertTitle = "Error"
            self.isAlertPresent = true
        }
        else if (GetDistance() > 1.00){
            self.alert = "Your reservation request could not be accepted."
            self.alertTitle = "Error"
            self.isAlertPresent = true
        }
        else{
            bookingInfo.memberID = memberID
            let object :[String: Any] = [
                "MemberID" : bookingInfo.memberID,
                "ParkingLotID" : bookingInfo.selectedParkingLot,
                "ResevationDate" : BookingDate(),
                "ResevationCanceled" : BookingCanceled(),
                "ReservationStatus" : "Pending" ]
            var ref: DocumentReference? = nil
          
            ref = self.db.collection("Reservations").addDocument(data: object){ err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Reservation Document successfully written!")
                    self.db.collection("ParkingLots").document(bookingInfo.selectedParkingLot).updateData(["Status" : "Reserved", "VehicleNo": self.member.first?.vehicleNo ?? "", "reservationCanceled":self.BookingCanceled()]){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            
                            bookingInfo.selectedParkingLot = ""
                            self.alert = "Your booking information has been successfully captured."
                            self.alertTitle = "Success"
                            self.isAlertPresent = true
                            print("Parking Lot Document successfully Updated!")
                           
                        }
                    }
                }
            }
        }
    }
    
    func BookingDate() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = dateFormater.string(from: Date() as Date)
        return date
    }
    
    func BookingCanceled() -> String {
        let timeFormater = DateFormatter()
        timeFormater.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let time = timeFormater.string(from: Date().addingTimeInterval(10*60) as Date)
        return time
    }
    
    func GetDistance() -> Double{
        let nibmLocation = CLLocation(latitude: 6.9065, longitude: 79.8707)
      
        //Arcade Independence Square
        let userLocationInRange = CLLocation(latitude: 6.9027, longitude: 79.8688)
        
        //Sen-Saal Jawatta
        let userLocationNotInRange = CLLocation(latitude: 6.8911, longitude: 79.8668)
        
//      locationManager.requestLocation()
//      let userLocation = CLLocation(latitude:Double(locationManager.location?.latitude ?? 0), longitude: Double(locationManager.location?.longitude ?? 0))
        
        let distance = nibmLocation.distance(from: userLocationInRange)/1000
        print(distance)
        return distance
    }
}

