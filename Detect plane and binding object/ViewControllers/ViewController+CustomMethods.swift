//
//  ViewController+CustomMethods.swift
//  Detect plane and binding object
//
//  Created by Viktor on 27/03/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import ARKit

// MARK: - ... Custom Methods
extension ViewController {
    
    func createFloor(for planeAnchor: ARPlaneAnchor) -> SCNNode {
        // Get the size of a definition plane
        let extent = planeAnchor.extent
        
        let node = SCNNode()
        node.name = "Plane"
        
        let plane = SCNPlane(width: CGFloat(extent.x), height: CGFloat(extent.z))
        plane.firstMaterial?.diffuse.contents = UIColor.blue
        node.geometry = plane
        
        node.eulerAngles.x = -.pi / 2
        node.opacity = 0.25
        
        return node
    }
    
    func createPerson(for planeAnchor: ARPlaneAnchor) -> SCNNode {
        guard let scene = SCNScene(named: "art.scnassets/minion.dae") else { return SCNNode()}
        let node = scene.rootNode
        
        node.position = SCNVector3(planeAnchor.center.x / 2, 0.13, planeAnchor.center.z / 2)
        node.scale = SCNVector3(0.1, 0.1, 0.1)
        
        node.eulerAngles.y = .pi
        
        return node
    }
}
