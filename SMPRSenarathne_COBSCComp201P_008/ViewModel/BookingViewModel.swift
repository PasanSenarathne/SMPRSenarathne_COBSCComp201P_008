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
    @Published var avaliableParkingLots = [ParkingLotModel]()
    
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
             self.avaliableParkingLots = documents.map { (queryDocumentSnapshot) -> ParkingLotModel in
                 let data = queryDocumentSnapshot.data()
                 let id = queryDocumentSnapshot.documentID
                 let parkingLotCode = data["ParkingLotCode"] as? String ?? ""
                 let parkingLotType = data["ParkingLotType"] as? String ?? ""
                 let status = data["Status"] as? String ?? ""
                 print(data)
                 return ParkingLotModel(id: id,parkingLotCode: parkingLotCode, parkingLotType: parkingLotType, status: status)
             }
        }
    }
    
}

