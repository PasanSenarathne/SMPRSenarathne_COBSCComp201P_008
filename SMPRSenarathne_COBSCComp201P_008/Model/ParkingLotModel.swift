//
//  ParkingLotModel.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import Foundation

struct ParkingLotModel: Identifiable{
    var id: String
    var parkingLotCode: String
    var parkingLotType: String
    var vehicleNo: String
    var reservationCanceledTime: String
    var status: String
}

struct ParkingLotsForPicker: Identifiable{
    var id: String
    var parkingLotCode: String
    var parkingLotType: String
}
