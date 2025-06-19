//
//  MatchesView.swift
//  Stroll
//
//  Created by Pieter Yoshua Natanael on 19/06/25.
//


import SwiftUI



// MARK: - Matches View

struct MatchesView: View {
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    YourTurnView()
                    ChatsView()
                }
                .padding()
            }
       
     
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Header

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                HStack {
                    Text("Your Turn")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.8323512853, green: 0.6462482497, blue: 1, alpha: 1)))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Text("7")
                                .font(.caption2)
                                .foregroundColor(.black)
                        )
           
                    
                    
                }
                Spacer()
                VStack(spacing: 4) {
                    ZStack {
                        // Outer circle with top gradient green border
                        Circle()
                            .strokeBorder(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .green, location: 0.0),
                                        .init(color: .clear, location: 1.0)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 4
                            )
                            .frame(width: 60, height: 60)

                        // Inner image clipped to circle
                        Image("andrew")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .clipShape(Circle())
                    }

                    // Text below the image
                    Text("90")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                }

            }

            Text("Make your move. They are waiting")
                .font(.subheadline.bold())
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.horizontal)
    }
    
}

// MARK: - Your Turn Cards

struct YourTurnView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                YourTurnCardView(
                    gradient: LinearGradient(colors: [.green, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
                    name: "Amanda, 22",
                    question: "What is your most favorite childhood memory?"
                )
                YourTurnCardView(
                    gradient: LinearGradient(colors: [.brown, .black], startPoint: .topLeading, endPoint: .bottomTrailing),
                    name: "Malte, 31",
                    question: "The most important quality in friendships to you?"
                )
                // Add more cards if needed
            }
            .padding(.horizontal)
        }
    }
}


struct YourTurnCardView: View {
    let gradient: LinearGradient
    let name: String
    let question: String

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(AnyShapeStyle(gradient))
            .frame(width: 200, height: 250)
            .overlay(
                VStack {
                    Text("Tap to answer")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(question)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
            )
    }
}



// MARK: - Chats View

struct ChatsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack (spacing: 4) {
                    Text("Chats")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 2)      // Thickness of the stripe
                        .frame(width: 40)      // Width of the stripe
                        .cornerRadius(1)       // Rounded edges (optional)
                }
                
                
                VStack (spacing: 4)  {
                    Text("Pending")
                        .font(.title2.bold())
                        .foregroundColor(.white.opacity(0.5))
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: 2)      // Thickness of the stripe
                        .frame(width: 40)      // Width of the stripe
                        .cornerRadius(1)       // Rounded edges (optional)
                }
            }
            Text("The ice is broken. Time to hit it off")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))

            ForEach(chatData) { chat in
                ChatRow(chat: chat)
            }
        }
    }
}

struct ChatRow: View {
    var chat: Chat

    var body: some View {
        HStack {
            Image(chat.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                HStack {
                    Text(chat.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    if chat.status != nil {
                        Text(chat.status!)
                            .font(.subheadline)
                            .padding(4)
                            .foregroundColor(.white)
//                            .background(Color(#colorLiteral(red: 0.8323512853, green: 0.6462482497, blue: 1, alpha: 1)))
                            .cornerRadius(8)
                    }
                }
                Text(chat.message)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(chat.name == "Sila" ? 0.6 : 1.0))

            }
            Spacer()
            VStack {
                Text(chat.time)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))
                if chat.unreadCount > 0 {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.8323512853, green: 0.6462482497, blue: 1, alpha: 1)))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Text("\(chat.unreadCount)")
                                .font(.caption2)
                                .foregroundColor(.black)
                        )
                }
            }
        }
    }
}

// MARK: - Tab Bar


// MARK: - Dummy Data

struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let time: String
    let imageName: String
    let status: String?
    let unreadCount: Int
}

let chatData = [
    Chat(name: "Jessica", message: "🔈 00.58", time: "6:21 pm", imageName: "jessica", status: "· New chat", unreadCount: 0),
    Chat(name: "Amanda", message: "Lol I love house music too", time: "6:21 pm", imageName: "amanda", status: "Your move", unreadCount: 0),
    Chat(name: "Sila", message: "You: I love the people there tbh, have you been?", time: "Wed", imageName: "sila", status: nil, unreadCount: 0),
    Chat(name: "Marie", message: "Hahaha that’s interesting...", time: "6:21 pm", imageName: "marie", status: "Your move", unreadCount: 4)
]



#Preview{MainAppView()}
