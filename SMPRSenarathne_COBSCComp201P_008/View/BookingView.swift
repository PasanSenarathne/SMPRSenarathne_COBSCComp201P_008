//
//  BookingView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import SwiftUI

struct BookingView: View {
    @StateObject var bookingViewModel = BookingViewModel()
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    if let user = bookingViewModel.member.first{
                        Section(header: Text("Booking Information")){
                            VStack(alignment: .leading){
                                Text("Registration Number") .fontWeight(.regular)
                                    .foregroundColor(.black)
                                Spacer(minLength: 10)
                                Text(user.id)
                                    .foregroundColor(.gray)
                                    .fontWeight(.semibold)
                            }
                            VStack(alignment: .leading){
                                Text("Vehicle Number") .fontWeight(.regular)
                                    .foregroundColor(.black)
                                Spacer(minLength: 10)
                                Text(user.vehicleNo)
                                    .foregroundColor(.gray)
                                    .fontWeight(.semibold)
                            }
                            VStack(alignment: .leading){
                                Text("Parking Lot") .fontWeight(.regular)
                                    .foregroundColor(.black)
                                Spacer(minLength: 10)
                                Text(user.vehicleNo)
                                    .foregroundColor(.gray)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    Section{
                        HStack{
                            Spacer()
                            Button(action: {}, label: {
                                Text("Reserved")
                                .foregroundColor(Color.blue)
                                .fontWeight(.semibold)
                            })
                            Spacer()
                        }
                    }
                    Section{
                        HStack{
                            Spacer()
                            Button(action: {}, label: {
                                Text("Scan QR Code")
                                .foregroundColor(Color.green)
                                .fontWeight(.semibold)
                            })
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Booking")
            .onAppear(){
                        self.bookingViewModel.GetUserDeatils()
                }
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
