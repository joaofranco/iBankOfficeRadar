import SwiftUI

struct BankOfficeDetailView: View {
    
    let place : Place
    
    var body: some View {
        VStack {
            VStack{
                Image("bank")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                
                Text(place.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(10)
            }
            VStack {
                Text("Endereço: ")
                    .fontWeight(.bold)
                Text(place.vicinity)
            }.padding(15)
            VStack {
                Text("Horário Funcionamento: ")
                    .fontWeight(.bold)
                if place.openingHours.openNow {
                    Text("Aberto")
                    .multilineTextAlignment(.leading)
                } else {
                    Text("Fechado")
                    .multilineTextAlignment(.leading)
                }
            }.padding(15)
            VStack {
                Text("Rating: ")
                    .fontWeight(.bold)
                HStack {
                    Text(place.ratingString)
                    Image(systemName: "heart.fill")
                }
            }.padding(15)
            Spacer()
            Text(place.scope)
                .multilineTextAlignment(.leading)
                .lineSpacing(10)
            Spacer()
        }
        .padding(20)
    }
}

struct BankOfficeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BankOfficeDetailView(place: testPlace)
    }
}

