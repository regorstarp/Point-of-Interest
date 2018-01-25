//
//  listWireframe.swift
//  TestPOI
//
//  Created by Design4 on 22/01/2018.
//  Copyright (c) 2018 Design4. All rights reserved.
//
//
import UIKit


// MARK: - Protocol to be defined at Wireframe

protocol listNavigationHandler: class
{
    // Include methods to present or dismiss
}

// MARK: - Wireframe Class must implement NavigationHandler Protocol to handle Presenter Navigation requests
class listWireframe: listNavigationHandler
{
    weak var viewController: listView?
    
}
