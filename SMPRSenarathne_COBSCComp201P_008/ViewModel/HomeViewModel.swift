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
                let reservationCanceled = data["reservationCanceled"] as? String ?? ""
                let status = data["Status"] as? String ?? ""
                return ParkingLotModel(id: id, parkingLotCode: parkingLotCode, parkingLotType: parkingLotType, vehicleNo: vehicleNo,reservationCanceled:reservationCanceled, status: status)
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
                let reservationCanceled = data["reservationCanceled"] as? String ?? ""
                let status = data["Status"] as? String ?? ""
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
                let rCanceled = formatter.date(from: reservationCanceled)
                let date = formatter.date(from: self.GetDate())
                
                let diff = Calendar.current.dateComponents([.second], from: date ?? Date(), to: rCanceled ?? Date())
                
                _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(Int(diff.second ?? 0)), repeats: true, block: { timer in
                    self.UpdateSlot(slotId: id, timer: timer)
                })
                return ParkingLotModel(id: id, parkingLotCode: parkingLotCode, parkingLotType: parkingLotType, vehicleNo: vehicleNo,reservationCanceled:reservationCanceled, status: status)
                
            }
            
        }
    }
    
    func UpdateSlot(slotId: String, timer : Timer){
        self.db.collection("ParkingLots").document(slotId).updateData([
            "Status" : "Available", "VehicalNo": "", "reservationCanceled": ""]){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Slot successfully Updated!")
                timer.invalidate()
            }
        }
    }
    
    func GetDate() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = dateFormater.string(from: Date() as Date)
        return date
    }
}
