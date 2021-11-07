//
//  UserModel.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import Foundation

class UserModel : ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPass = ""
}
