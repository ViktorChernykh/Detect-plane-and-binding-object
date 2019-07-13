//
//  ViewController.swift
//  Detect plane and binding object
//
//  Created by Viktor Chernykh on 27/03/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

// minion by https://www.cgtrader.com/items/989540/download-page

import ARKit

class ViewController: UIViewController {
    
    var planeArray = [SCNNode]()
    var objectArray = [SCNNode]()
    var textArray = [SCNNode]()

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.autoenablesDefaultLighting = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.debugOptions = [.showFeaturePoints]
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Here you can select an object to define it
        // The delegate method is called when it is defined
        configuration.planeDetection = [.horizontal]

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}

