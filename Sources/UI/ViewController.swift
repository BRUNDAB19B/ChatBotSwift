//
//  ViewController.swift
//  ChatBotAiPackage
//
//  Created by Brunda B on 21/11/24.
//

import UIKit
import SwiftUI
import SwiftData

public class ViewController: UIViewController {
  
  var chatBotView: SomeMainView!
  
  // Custom initializer to accept the optional UIImage for background
  public init(
    backgroundImage: UIImage? = nil,
    emptyMessageColor: Color? = nil,
    editButtonColor: Color? = nil,
    ctx: ModelContext
  ) {
    super.init(nibName: nil, bundle: nil)
    
    // Pass the background image to SomeMainView
      chatBotView = SomeMainView(
      backgroundImage: backgroundImage,
      emptyMessageColor: emptyMessageColor,
      editButtonColor: editButtonColor,
      ctx: ctx
    )
  }

    // Required initializer for ViewController without storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the UIHostingController
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Create a UIHostingController with the configured SomeMainView
        let uiHostingViewController = UIHostingController(rootView: chatBotView)
        
        // Add the UIHostingController to the view controller hierarchy
        addChild(uiHostingViewController)
        view.addSubview(uiHostingViewController.view)
        
        // Set up constraints for the UIHostingController's view
        uiHostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            uiHostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            uiHostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            uiHostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiHostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
