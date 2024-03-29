//
//  HomeView.swift
//  SMPRSenarathne_COBSCComp201P_008
//
//  Created by Dewmina Jayasinghe on 2021-11-06.
//


import SwiftUI

struct HomeView: View {
    @State var index = 0
    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var authViewModel :AuthViewModel
    var body: some View {
        NavigationView{
            VStack{
                //Tab View
                HStack(spacing: 0){
                    
                    Text("Available")
                        .foregroundColor(self.index == 0 ? .white : Color(.blue).opacity(0.7))
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .padding(.horizontal,35)
                        .background(Color(.blue).opacity(self.index == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture{
                            withAnimation(.default){
                                self.index = 0
                            }
                        }
                    
                    Spacer(minLength: 0)
                    
                    Text("Reserved")
                        .foregroundColor(self.index == 1 ? .white : Color(.blue).opacity(0.7))
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .padding(.horizontal,35)
                        .background(Color(.blue).opacity(self.index == 1 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture{
                            withAnimation(.default){
                                self.index = 1
                            }
                        }
                }
                .background(Color.black.opacity(0.06))
                .clipShape(Capsule())
                .padding(.horizontal)
                .padding(.top,25)
                
                //Dashboard Data
                TabView(selection: self.$index){
                    ParkingLotsGridView(Data: homeViewModel.avaliableSlots , tabIndex: 0)
                        .tag(0)
                    ParkingLotsGridView(Data: homeViewModel.reservedSlots, tabIndex: 1)
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                Spacer(minLength: 0)
            }
            .padding(.top)
            .navigationTitle(authViewModel.isSignedIn ? "Welcome Back" : "Home")
            .onAppear(){
                self.homeViewModel.GetAvaliableSlots()
                self.homeViewModel.GetReservedSlots()
            }
        }
    }
}

struct ParkingLotsGridView : View {
    @StateObject var homeViewModel = HomeViewModel()
    var Data : [ParkingLotModel]
    var tabIndex : Int
    var columns = Array(repeating: GridItem(.flexible(), spacing:20), count: 2)
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: columns, spacing: 30){
                ForEach(Data){ParkingLotModel in
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                        VStack(alignment: .leading, spacing: 20){
                            Text(ParkingLotModel.parkingLotCode)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title)
                            Text(ParkingLotModel.parkingLotType)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.top,10)
                            if(self.tabIndex == 1){
                                Text(ParkingLotModel.vehicleNo)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top,10)
                            }
                        }
                        .padding()
                        .background(Color(.lightGray))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius:5, x: 0, y: 5)
                    }
                    
                }
            }
            .padding(.horizontal)
            .padding(.top,25)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
