//
//  CreateNewUserView.swift
//  McKinley Rice Task
//
//  Created by AB020QU on 2023/07/19.
//

import SwiftUI

struct CreateNewUserView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var name: String
    @Binding var job: String
    @ObservedObject var vm: HomeViewModel
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "x.circle.fill")
                        .accentColor(.black)
                        .font(.largeTitle)
                        .padding()
                        .clipShape(Circle())
                        .offset(y: 12)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Please enter name", text: $name)
                    Text("Job")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("Please enter job", text: $job)
                }
                .padding()
            }
            
            Spacer()
            
            Button(action: {
                vm.createUser { flag in
                    if flag {
                        dismiss()
                        self.name = ""
                        self.job = ""
                    } else {
                        withAnimation {
                            self.showAlert = true
                        }
                    }
                }
            }) {
                Text("Create New User")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green, in: RoundedRectangle(cornerRadius: 12))
            }
            .disabled(self.name.isEmpty || self.job.isEmpty)
            .alert("Creation Error", isPresented: $showAlert) {
                Button("OK", role: .cancel, action: {
                    dismiss()
                })
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            print("Name and jon :\(self.name) \(self.job)")
        }
        .textFieldStyle(.roundedBorder)
    }
}

struct CreateNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewUserView(name: .constant("Pradeep"), job: .constant("Senior Software Engineer"), vm: .init())
    }
}
