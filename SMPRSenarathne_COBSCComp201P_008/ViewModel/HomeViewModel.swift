//
//  HomeViewModel.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import Foundation
import FirebaseFirestore

class HomeViewModel : ObservableObject{
    var db = Firestore.firestore()
    @Published var avaliableSlots = [ParkingLotModel]()
    @Published var reservedSlots = [ParkingLotModel]()
    
    func GetAvaliableSlots(){
        avaliableSlots.removeAll()
        db.collection("ParkingLots").whereField("Status", isEqualTo: "Available").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.avaliableSlots = documents.map { (queryDocumentSnapshot) -> ParkingLotModel in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let parkingLotCode = data["ParkingLotCode"] as? String ?? ""
                let parkingLotType = data["ParkingLotType"] as? String ?? ""
                let vehicleNo = data["VehicleNo"] as? String ?? ""
                let reservationCanceledTime = data["ReservationCanceledTime"] as? String ?? ""
                let status = data["Status"] as? String ?? ""
                return ParkingLotModel(id: id, parkingLotCode: parkingLotCode, parkingLotType: parkingLotType, vehicleNo: vehicleNo,reservationCanceledTime:reservationCanceledTime, status: status)
            }
        }
    }
    
    func GetReservedSlots(){
        reservedSlots.removeAll()
        db.collection("ParkingLots").whereField("Status", isEqualTo: "Reserved").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.reservedSlots = documents.map { (queryDocumentSnapshot) -> ParkingLotModel in
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let parkingLotCode = data["ParkingLotCode"] as? String ?? ""
                let parkingLotType = data["ParkingLotType"] as? String ?? ""
                let vehicleNo = data["VehicleNo"] as? String ?? ""
                let reservationCanceledTime = data["ReservationCanceledTime"] as? String ?? ""
                let status = data["Status"] as? String ?? ""
                return ParkingLotModel(id: id, parkingLotCode: parkingLotCode, parkingLotType: parkingLotType, vehicleNo: vehicleNo,reservationCanceledTime:reservationCanceledTime, status: status)
            }
        }
    }
    
}
