//
//  BookingView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//

import SwiftUI
import CodeScanner

struct BookingView: View {
    @StateObject var bookingViewModel = BookingViewModel()
    @StateObject var bookingModel = BookingModel()
    @State var isPerentingScanner = false
    
    var scannerSheet: some View{
        CodeScannerView(codeTypes: [.qr], completion: {
            result in
            if case let .success(code) = result{
                self.bookingModel.selectedParkingLot = code
                self.isPerentingScanner = false
                bookingViewModel.Reservation(bookingInfo: bookingModel, memberID: $bookingViewModel.member.first?.id ?? "")
            }
        })
    }
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
                                        Text(ParkingLotsForPicker.parkingLotCode + " (" + ParkingLotsForPicker.parkingLotType + ")")
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
                                .alert(isPresented: $bookingViewModel.isAlertPresent) {
                                    Alert(title: Text(bookingViewModel.alertTitle), message: Text(bookingViewModel.alert))
                                }
                            Spacer()
                        }
                    }
                    Section{
                        HStack{
                            Spacer()
                            Button(action: {self.isPerentingScanner = true}, label: {
                                Text("Scan QR Code")
                                    .foregroundColor(Color.green)
                                    .fontWeight(.semibold)
                            })
                                .sheet(isPresented: $isPerentingScanner){
                                    self.scannerSheet
                                }
                                .alert(isPresented: $bookingViewModel.isAlertPresent) {
                                    Alert(title: Text(bookingViewModel.alertTitle), message: Text(bookingViewModel.alert))
                                }
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
