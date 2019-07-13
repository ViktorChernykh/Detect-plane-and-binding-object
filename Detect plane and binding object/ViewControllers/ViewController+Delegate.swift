//
//  ViewController+Delegate.swift
//  Detect plane and binding object
//
//  Created by Viktor Chernykh on 27/03/2019.
//  Copyright © 2019 Viktor Chernykh. All rights reserved.
//

import ARKit

extension ViewController: ARSCNViewDelegate {
    
    // MARK: - ARSCNViewDelegate
    // The delegate method is called after the object definition
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // Check the type of object. ARPlaneAnchor one of the child of ARAnchor
        guard let anchor = anchor as? ARPlaneAnchor else { return }
        
        let planeNode = createFloor(for: anchor)
        let objectNode = createPerson(for: anchor)
        
        planeArray.append(planeNode)
        objectArray.append(objectNode)
        
        node.addChildNode(planeNode)
        node.addChildNode(objectNode)
        
        if let index = planeArray.firstIndex(of: planeNode) {
            let textNode = createText(for: anchor, with: index)
            textArray.append(textNode)
            node.addChildNode(textNode)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let anchor = anchor as? ARPlaneAnchor else { return }
        guard let planeNode = node.childNodes.first else { return }
        guard let plane = planeNode.geometry as? SCNPlane else { return }
        guard planeNode.name == "Plane" else { return }
        
        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        let extent = anchor.extent
        plane.width = CGFloat(extent.x)
        plane.height = CGFloat(extent.z)
        guard let index = planeArray.firstIndex(of: planeNode) else { return }

        let objectNode = objectArray[index]
        objectNode.position = SCNVector3(anchor.center.x / 2, 0.13, anchor.center.z / 2)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let _ = anchor as? ARPlaneAnchor else { return }
        guard let planeNode = node.childNodes.first else { return }
        guard let _ = planeNode.geometry as? SCNPlane else { return }
        guard planeNode.name == "Plane" else { return }
        
        guard let index = planeArray.firstIndex(of: node) else { return }
        planeArray.remove(at: index)
        objectArray.remove(at: index)
        textArray.remove(at: index)
    }
    
}
