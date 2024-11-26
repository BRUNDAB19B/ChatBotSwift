//
//  MainView.swift
//  Chatbot
//
//  Created by Brunda B on 15/11/24.
//

import SwiftUI
import SwiftData

public struct MainView: View {
  
  @Query(sort: \SessionDataModel.createdAt, order: .reverse) var thread: [SessionDataModel]
  @ObservedObject var viewModel: ChatViewModel
  @State private var newSessionId: String? = nil
  @State private var isNavigatingToNewSession: Bool = false
  @Environment(\.modelContext) var modelContext
  @Environment(\.dismiss) var dismiss
  
  var backgroundImage: UIImage?
  var emptyMessageColor: Color?
  var editButtonColor: Color?
  
  public init(backgroundImage: UIImage? = nil, emptyMessageColor: Color? = .white, editButtonColor: Color? = .blue, ctx: ModelContext) {
    self.backgroundImage = backgroundImage
    self.emptyMessageColor = emptyMessageColor
    self.editButtonColor = editButtonColor
    
    self.viewModel = ChatViewModel(context: ctx)
  }

  public var body: some View {
    NavigationView {
      ZStack {
        if let backgroundImage = SetUIComponents.shared.userAllChatBackgroundColor {
          Image(uiImage: backgroundImage)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
        } else {
          Color.white
            .edgesIgnoringSafeArea(.all)
        }

        VStack {
          headerView
          mainContentView
          Spacer()
          editButtonView
        }
        .padding(.top, 45)
        .navigationBarHidden(true)
      }
      .background(
        NavigationLink(
          destination: NewSessionView(session: newSessionId ?? "", viewModel: viewModel, backgroundImage: backgroundImage)
            .modelContext(modelContext),
          isActive: $isNavigatingToNewSession
        ) {
          EmptyView()
        }
      )
    }
  }
  
  // MARK: - Header View
   private var headerView: some View {
    
     HStack {
       Button(action: {
         dismiss()
       }) {
         HStack {
           Image(systemName: "chevron.left")
             .font(.title3)
             .foregroundColor(Color.blue)
           Text("Back")
             .foregroundStyle(Color.blue)
         }
         .padding(.leading, 5)
       }
       Text(SetUIComponents.shared.chatHistoryTitle ?? "Chat History")
         .foregroundColor(Color.black)
       Spacer()
     }
  }

  private var mainContentView: some View {
    Group {
      if thread.isEmpty {
        Text("No messages yet")
          .font(.title2)
          .fontWeight(.medium)
          .foregroundColor(emptyMessageColor)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
          .padding()
      } else {
        List {
          ForEach(thread) { thread in
            NavigationLink {
              NewSessionView(session: thread.sessionId, viewModel: viewModel, backgroundImage: backgroundImage)
                .modelContext(modelContext)
            } label: {
              MessageSubView(thread.title)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
              Button(role: .destructive) {
                QueueConfigRepo1.shared.deleteSession(sessionId: thread.sessionId)
              } label: {
                Label("Delete", systemImage: "trash")
              }
            }
          }
        }
        .listStyle(.plain)
        .padding(.top, 20)
      }
    }
  }

  // MARK: - Floating Edit Button
  private var editButtonView: some View {
    HStack {
      Spacer()
      
      Button(action: {
        viewModel.createSession()
        newSessionId = viewModel.vmssid
        isNavigatingToNewSession = true
      }) {
        
        //MARK: - Todo Support image
//        if let newChatButtonImage = SetUIComponents.shared.newChatButtonImage {
//          Image(newChatButtonImage)
//        } else {
          Image(systemName: "square.and.pencil")
            .font(.title2)
            .foregroundColor(.white)
            .padding()
            .background(editButtonColor)
            .clipShape(Circle())
            .shadow(radius: 10)
//        }
        
        if let newChatButtonText = SetUIComponents.shared.newChatButtonText {
          Text(newChatButtonText)
            .foregroundStyle(Color.black)
            .font(.title2)
        }
      }
      .padding(.bottom, 40)
      .padding(.trailing, 16)
    }
  }

  // MARK: - Message SubView
  func MessageSubView(_ title: String) -> some View {
    HStack {
      Text(title)
        .font(.headline)
        .foregroundColor(.primary)
        .lineLimit(1)
      Spacer()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
    )
  }
}

public struct SomeMainView: View {
  
  var backgroundImage: UIImage?
  var emptyMessageColor: Color?
  var editButtonColor: Color?
  var ctx: ModelContext
  
  public init(
    backgroundImage: UIImage? = nil,
    emptyMessageColor: Color? = .white,
    editButtonColor: Color? = .blue,
    ctx: ModelContext
  ) {
    self.backgroundImage = backgroundImage
    self.emptyMessageColor = emptyMessageColor
    self.editButtonColor = editButtonColor
    self.ctx = ctx
    
    QueueConfigRepo1.shared.modelContext = ctx
  }
  
  public var body: some View {
    MainView(backgroundImage: backgroundImage, emptyMessageColor: emptyMessageColor, editButtonColor: editButtonColor, ctx: ctx)
      .modelContext(ctx)
      .navigationBarHidden(true)
  }
}
