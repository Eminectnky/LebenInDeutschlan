//
//  CategoryView.swift
//  LebenInDeutschlan
//
//  Created by Emine CETINKAYA on 16.04.2024.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Text("Leben In Deutschlan")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .frame(width: 400, height: 50)
                        .padding(.trailing, 50)
                }
                .background(Color.gray)
                
               
                ZStack{
                    ScrollView{
                        NavigationLink(destination:  AllQuestions()) {
                            Text("All Questions")
                                .multilineTextAlignment(.leading)
                                .frame(width: 370, height: 50, alignment: .center)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                      
                        NavigationLink(destination: FederalState(stateKey: "be")) {
                            Text("Federal State")
                                .multilineTextAlignment(.leading)
                                .frame(width: 370, height: 50, alignment: .center)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }

                        
                        Text("Main Category")
                            .font(.title)
                            .fontWeight(.bold)
                        
                            .padding()
                        
                        NavigationLink(destination:  PolitikInDerDemokratie()) {
                            Text("Politik in der Demokratie")
                                .multilineTextAlignment(.leading)
                                .frame(width: 370, height: 50, alignment: .center)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        NavigationLink(destination:   GeschichteUndVerantwortung()) {
                            Text("Geschichte und Verantwortung")
                                .multilineTextAlignment(.leading)
                                .frame(width: 370, height: 50, alignment: .center)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        NavigationLink(destination:    MenschUndGesellschaft()) {
                            Text("Mensch und Gesellschaft")
                                .multilineTextAlignment(.leading)
                                .frame(width: 370, height: 50, alignment: .center)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        
                        Text("Sub Category")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()
                        
                        
                        
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)

        }
      
    }
}

#Preview {
    CategoryView()
}
