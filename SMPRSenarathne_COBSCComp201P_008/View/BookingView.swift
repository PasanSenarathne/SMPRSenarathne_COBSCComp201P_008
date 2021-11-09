//
//  BookingView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import SwiftUI

struct BookingView: View {
    @StateObject var bookingViewModel = BookingViewModel()
    @StateObject var bookingModel = BookingModel()
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
                         
                        }
                        Section(){
                            VStack(alignment: .leading){
                                Picker("Select A Parking Lot", selection: $bookingModel.selectedParkingLot){
                                    ForEach(bookingViewModel.avaliableParkingLots){ParkingLotsForPicker in
                                        Text(ParkingLotsForPicker.parkingLotCode)
                                    }
                                }
                            }
                        }
                    }
                    Section{
                        HStack{
                            Spacer()
                            Button(action: { bookingViewModel.Reservation(bookingInfo: bookingModel, memberID: $bookingViewModel.member.first?.id ?? "")}, label: {
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
                    self.bookingViewModel.GetAvailableParkingLots()
            }
        }
    }
}

struct BookingView_Previews: PreviewProvider {
    static var previews: some View {
        BookingView()
    }
}
