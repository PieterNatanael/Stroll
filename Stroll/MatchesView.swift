//
//  MatchesView.swift
//  Stroll
//
//  Created by Pieter Yoshua Natanael on 19/06/25.
//

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

// MARK: - Header Section

/// Displays the "Your Turn" title with a count, profile image with gradient border, and message below.
struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                // Left: Title and counter
                HStack {
                    Text("Your Turn")
                        .font(.title2.bold())
                        .foregroundColor(.white)

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

                // Right: Profile image with top gradient border and score
                VStack(spacing: 4) {
                    ZStack {
                        // Outer gradient stroke
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

                        // Inner profile image
                        Image("andrew")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 52, height: 52)
                            .clipShape(Circle())
                    }

                    // Score below profile
                    Text("90")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.white)
                }
            }

            // Subheading
            Text("Make your move. They are waiting")
                .font(.subheadline.bold())
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(.horizontal)
    }
}

// MARK: - Horizontal Cards ("Your Turn")

/// Scrollable horizontal cards for unanswered prompts.
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
                // Add more cards as needed
            }
            .padding(.horizontal)
        }
    }
}

/// A card displaying a prompt and user name with a custom gradient background.
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

// MARK: - Chats Section

/// Vertical list of chats, showing messages and status.
struct ChatsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Section headers
            HStack {
                VStack(spacing: 4) {
                    Text("Chats")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    // Underline
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

            // Subheading
            Text("The ice is broken. Time to hit it off")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))

            // Chat rows
            ForEach(chatData) { chat in
                ChatRow(chat: chat)
            }
        }
    }
}

/// A single chat row with name, message, time, and unread count badge.
struct ChatRow: View {
    var chat: Chat

    var body: some View {
        HStack {
            // Profile image
            Image(chat.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            VStack(alignment: .leading) {
                // Name and status
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

                // Message text, faded if read (e.g. Sila)
                Text(chat.message)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(chat.name == "Sila" ? 0.6 : 1.0))
            }

            Spacer()

            // Time and unread badge
            VStack {
                Text(chat.time)
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.7))

                if chat.unreadCount > 0 {
                    Circle()
                        .fill(Color(#colorLiteral(red: 0.832, green: 0.646, blue: 1, alpha: 1)))
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

// MARK: - Chat Data Model & Dummy Data

/// Chat data model.
struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let message: String
    let time: String
    let imageName: String
    let status: String?
    let unreadCount: Int
}

/// Sample data to populate UI.
let chatData = [
    Chat(name: "Jessica", message: "🔈 00.58", time: "6:21 pm", imageName: "jessica", status: "· New chat", unreadCount: 0),
    Chat(name: "Amanda", message: "Lol I love house music too", time: "6:21 pm", imageName: "amanda", status: "Your move", unreadCount: 0),
    Chat(name: "Sila", message: "You: I love the people there tbh, have you been?", time: "Wed", imageName: "sila", status: nil, unreadCount: 0),
    Chat(name: "Marie", message: "Hahaha that’s interesting...", time: "6:21 pm", imageName: "marie", status: "Your move", unreadCount: 4)
]

// MARK: - Preview

#Preview {
    MainAppView()
}
