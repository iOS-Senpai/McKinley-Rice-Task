//
//  HomeView.swift
//  McKinley Rice Task
//
//  Created by Pradeep Kumar on 2023/07/18.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: Single Source Of Truth
    
    @State private var selectedState = 0
    @State private var showNewUserPage = false
    @State private var adjustedIndex: Int = 0
    @Namespace private var geometryEffect
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.users, id: \.id) { user in
                    HStack(spacing: 16) {
                        AsyncImage(url: URL(string: user.avatar), content: { image in
                            image
                                .resizable()
                                .frame(width: 120, height: 120)
                        }, placeholder: {
                            Rectangle()
                                .fill(Color.purple.opacity(0.4))
                                .frame(width: 120, height: 120)
                        })
                        .overlay {
                            Color
                                .purple.opacity(selectedState == user.id ? 0 : 0.4)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.firstName)
                                .font(.title3)
                            Text(user.lastName)
                                .font(.callout)
                                .foregroundColor(.gray)
                                .lineLimit(1)
                        }
                        
                        if selectedState == user.id {
                            HStack(spacing: 12) {
                                Image(systemName: SFSymbols.phone)
                                    .imageScale(.large)
                                Image(systemName: SFSymbols.chatBubble)
                                    .imageScale(.large)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .matchedGeometryEffect(id: "Fade", in: geometryEffect)
                        } else {
                            Circle()
                                .fill(user.id % 5 == 0 ? .red : .green)
                                .frame(width: 12, height: 12)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .shadow(color: .white, radius: 10, x: 2, y: 2)
                    .onTapGesture {
                        withAnimation {
                            guard user.id != 5 else { return }
                            self.selectedState = user.id
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .onAppear {
                vm.fetchUserDetail()
            }
            .listStyle(.insetGrouped)
            .navigationBarTitle(Text("Contacts"), displayMode: .inline)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Button(action: {
                        self.showNewUserPage = true
                    }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .background(Color.black.shadow(radius: 20, x: 10, y: 10))
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    }
                    .sheet(isPresented: $showNewUserPage) {
                        CreateNewUserView(name: $vm.name, job: $vm.job, vm: vm)
                            .presentationDetents([.height(264)])
                            .cornerRadius(24)
                    }
                }
                .padding()
            }
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "text.alignleft")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
