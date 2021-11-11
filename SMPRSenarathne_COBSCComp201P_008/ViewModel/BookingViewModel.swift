//
//  BookingViewModel.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class BookingViewModel : ObservableObject{
    var db = Firestore.firestore()
    let firebaseAuth = Auth.auth()
    @Published var member = [MemberDetails]()
    @Published var avaliableParkingLots = [ParkingLotsForPicker]()
    
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
                 return ParkingLotsForPicker(id: id,parkingLotCode: parkingLotCode)
             }
        }
    }
    
    func Reservation(bookingInfo:BookingModel, memberID: String){
        bookingInfo.memberID = memberID
        let object :[String: Any] = [
            "MemberID" : bookingInfo.memberID,
            "ParkingLotID" : bookingInfo.selectedParkingLot,
            "ResevationDate" : Data(),
            "ResevationTime" : Time(),
            "ReservationStatus" : "Pending" ]
        var ref: DocumentReference? = nil
        ref = self.db.collection("Reservations").addDocument(data: object){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Reservation Document successfully written!")
                self.db.collection("ParkingLots").document(bookingInfo.selectedParkingLot).updateData(["Status" : "Reserved"]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Parking Lot Document successfully Updated!")
                     
                    }
                }
            }
        }
    }
    
    func Data() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let date = dateFormater.string(from: Date() as Date)
        return date
    }
    
    func Time() -> String {
        let timeFormater = DateFormatter()
        timeFormater.dateFormat = "HH:mm"
        let time = timeFormater.string(from: Date() as Date)
        return time
    }
}

