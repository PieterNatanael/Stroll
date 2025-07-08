//
//  MatchesView.swift
//  Stroll
//
//  Created by Pieter Yoshua Natanael on 19/06/25.
//


/*
This SwiftUI file builds a "Matches" screen like you’d see in a dating or chat app. It includes:

A header
A horizontal list of cards (people waiting for your response)
A list of recent chat messages
Nice design elements like gradients, profile pictures, and unread message badges
 
 The matches view is mockup for job requirements

*/


import SwiftUI

// MARK: - Main Matches Screen

/// The main Matches screen containing header, "Your Turn" cards, and chat list.
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
        // Fullscreen black background to match dark UI
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

/*
 This is the main screen — like the homepage for the Matches feature.
 
 Contains:
 - HeaderView() – top section with title and profile image
 - YourTurnView() – horizontal swipeable prompt cards
 - ChatsView() – recent chat list
 
 Why VStack + ScrollView:
 VStack stacks vertically, ScrollView enables scrolling content.
 We use a black background to match dark theme aesthetics.
*/


// MARK: - Header Section

/// Displays the "Your Turn" title with a count, profile image with gradient border, and a message below.
struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                // Left: Title and counter
                HStack {
                    Text("Your Turn")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .bold()
                    Text("New Chat")
                        .font(.title2.bold())
                        .foregroundColor(.red)
                        .bold()

                    Circle()
                        .fill(Color(#colorLiteral(red: 0.832, green: 0.646, blue: 1, alpha: 1)))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Text("7")
                                .font(.caption2)
                                .foregroundColor(.black)
                        )
                }

                Spacer()

                // Right: Profile image with top gradient stroke
                VStack(spacing: 4) {
                    ZStack {
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

                        Image("andrew")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .clipShape(Circle())
                    }

                    ZStack {
                               // Stroke Layer (outlined text)
                               Text("90")
                                   .font(.system(size: 40))
                                   .bold()
                                   .foregroundColor(.black)
                                   .overlay(
                                       Text("90")
                                           .font(.system(size: 35))
                                           .bold()
                                           .foregroundColor(.clear)
                                           .overlay(
                                               LinearGradient(colors: [.black], startPoint: .top, endPoint: .bottom)
                                                   .mask(
                                                       Text("90")
                                                           .font(.system(size: 40))
                                                           .bold()
                                                   )
                                                   .blur(radius: 1)
                                           )
                                   )

                               // Fill Layer
                               Text("90")
                                   .font(.system(size: 35))
                                   .bold()
                                   .foregroundColor(.red)
                           }
                    
                
                }
            }

            // Subheading below title
            Text("Make your move. They are waiting")
                .font(.subheadline.bold())
                .foregroundColor(.white.opacity(0.7))
                .foregroundColor(.blue)
        }
        .padding(.horizontal)
    }
}

/*
 The header highlights the user's turn and shows engagement count.
 Profile picture uses a gradient stroke at the top to emphasize activity.
*/


// MARK: - Horizontal Cards ("Your Turn")

/// A horizontally scrollable list of interactive prompt cards.
struct YourTurnView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                YourTurnCardView(
                    gradient: LinearGradient(colors: [.green, .purple, .black], startPoint: .topLeading, endPoint: .bottomTrailing),
                    name: "Amanda, 22",
                    question: "What is your most favorite childhood memory?",
                    label: nil // No label for Amanda
                )
                YourTurnCardView(
                    gradient: LinearGradient(colors: [.brown, .black], startPoint: .topLeading, endPoint: .bottomTrailing),
                    name: "Malte, 31",
                    question: "The most important quality in friendships to you?",
                    label: "🗣️ They made a move" // Show this label only for Malte
                )
            }
            .padding(.horizontal)
        }
    }
}


/// A single card displaying the prompt and user identity with a gradient background.
struct YourTurnCardView: View {
    let gradient: LinearGradient
    let name: String
    let question: String
    let label: String?

    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(AnyShapeStyle(gradient))
            .frame(width: 200, height: 250)
            .overlay(
                VStack {
                    // Top label area – fixed height for alignment
                    ZStack {
                        if let label = label {
                            Text(label)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.black)
                                .clipShape(Capsule())
                        }
                    }
                    .frame(height: 24) // Match this height across all cards

                    Spacer()

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


/*
 We use gradient backgrounds to differentiate cards visually.
 Using AnyShapeStyle makes this component flexible to different fill styles.
*/


// MARK: - Chats Section

/// Displays the user's ongoing and pending chats.
struct ChatsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Section headers
            HStack {
                VStack(spacing: 4) {
                    Text("Chats")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 40, height: 2)
                        .cornerRadius(1)
                }

                VStack(spacing: 4) {
                    Text("Pending")
                        .font(.title2.bold())
                        .foregroundColor(.white.opacity(0.5))

                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 40, height: 2)
                        .cornerRadius(1)
                }
            }

            // Section subheading
            Text("The ice is broken. Time to hit it off")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))

            // Chat list
            ForEach(chatData) { chat in
                ChatRow(chat: chat)
            }
        }
    }
}

/*
 Uses visual stripe indicators to emphasize current tab.
 Dynamically displays chat rows using sample data.
*/


// MARK: - Chat Row Component

/// Represents one chat preview with profile, message, time, and unread indicator.
struct ChatRow: View {
    var chat: Chat

    var body: some View {
        HStack {
            // Profile picture
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

                    if let status = chat.status {
                        Text(status)
                            .font(.subheadline)
                            .padding(4)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                Text(chat.message)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(chat.name == "Sila" ? 0.6 : 1.0)) // Faded if read
            }

            Spacer()

            VStack {
                Text(chat.time)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))

                if chat.unreadCount > 0 {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.832, green: 0.646, blue: 1, alpha: 1)))
                        .frame(width: 20, height: 20)
                        .overlay(
                            Group {
                                if chat.name == "Jessica" {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 10))
                                        .foregroundColor(.black)
                                } else {
                                    Text("\(chat.unreadCount)")
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                }
                            }
                        )
                }

                
                
            }
        }
    }
}

/*
 The opacity change on message makes it visually clear which messages are read.
 Use of color literal ensures consistent styling for unread badges.
*/


// MARK: - Chat Model + Dummy Data

/// A model for chat previews used in the Matches view.
struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let time: String
    let imageName: String
    let status: String?
    let unreadCount: Int
}

/// Preview/test data for chat UI.
let chatData = [
    Chat(name: "Jessica", message: "🔈 00.58", time: "6:21 pm", imageName: "jessica", status: "· New chat", unreadCount: 1),
    Chat(name: "Amanda", message: "Lol I love house music too", time: "6:21 pm", imageName: "amanda", status: "Your move", unreadCount: 0),
    Chat(name: "Sila", message: "You: I love the people there tbh, have you been?", time: "Wed", imageName: "sila", status: nil, unreadCount: 0),
    Chat(name: "Marie", message: "Hahaha that’s interesting...", time: "6:21 pm", imageName: "marie", status: "Your move", unreadCount: 4)
]


// MARK: - Preview

#Preview {
    MainAppView()
}
