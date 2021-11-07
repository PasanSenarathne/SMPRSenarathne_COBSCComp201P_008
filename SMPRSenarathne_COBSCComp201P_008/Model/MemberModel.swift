//
//  MemberModel.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import Foundation

class MemberModel : ObservableObject{
    @Published var memberID = ""
    @Published var userID = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var nic = ""
    @Published var vehicleNo = ""
}

struct MemberDetails: Identifiable{
    var id: String
    var userID: String
    var firstName: String
    var lastName: String
    var nic: String
    var vehicleNo: String
}

