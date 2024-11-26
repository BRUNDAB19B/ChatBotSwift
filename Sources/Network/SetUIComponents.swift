//
//  File.swift
//  ChatBotAiPackage
//
//  Created by Brunda B on 26/11/24.
//

import Foundation
import SwiftUI

@MainActor
public class SetUIComponents {
  
  public var userBackGroundColor: Color?
  public var userAllChatBackgroundColor: UIImage?
  public var usertextColor: Color?
  public var botBackGroundColor: Color?
  public var botTextColor: Color?
  public var chatIcon: UIImage?
  public var userIcon: String?
  public var chatHistoryTitle: String?
  public var chatTitle: String?
  public var newChatButtonText: String?
  public var newChatButtonImage: UIImage?
  public static let shared = SetUIComponents()

  private init() {}
  
}