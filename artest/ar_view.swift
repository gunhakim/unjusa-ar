//
//  buddha4_ar.swift
//  artest
//
//  Created by 김건하 on 10/09/2019.
//  Copyright © 2019 김건하. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import ARKit

class ar_view : UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var labeltext: String?
    
    @IBOutlet weak var arview: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch labeltext! {
        case "tower_1":
            label.text = "삼층석탑"
        case "tower_4":
            label.text = "사층석탑"
        case "tower_6":
            label.text = "명당탑/원반형석탑"
        case "dtower_2":
            label.text = "석조불감앞칠승석탑"
        case "buddha_1":
            label.text = "석불군마구역"
        case "buddha_2":
            label.text = "석상"
        case "buddha_3":
            label.text = "석상"
        case "buddha_4":
            label.text = "광배석불좌상"
        default:
            label.text = "구조물"
        }
        
        addTapGestureToSceneView()
        
        configureLighting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arview.session.pause()
    }
    
    func setUpSceneView() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        arview.session.run(configuration)
        
        arview.delegate = self
        arview.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    func configureLighting() {
        arview.autoenablesDefaultLighting = true
        arview.automaticallyUpdatesLighting = true
    }
    
    @objc func addShipToSceneView(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: arview)
        let hitTestResults = arview.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        
        guard let hitTestResult = hitTestResults.first else { return }
        let translation = hitTestResult.worldTransform.translation
        let x = translation.x
        let y = translation.y
        let z = translation.z
        
        
        guard let shipScene = SCNScene(named: "art.scnassets/"+labeltext!+".scn") else {return}
        guard let shipNode = shipScene.rootNode.childNode(withName: labeltext!, recursively: false)
            else { return }
        
        shipNode.position = SCNVector3(x,y,z)
        arview.scene.rootNode.addChildNode(shipNode)
        
        
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ar_view.addShipToSceneView(withGestureRecognizer:)))
        arview.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension ar_view: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        let plane = SCNPlane(width: width, height: height)
        
        // 3
        plane.materials.first?.diffuse.contents = UIColor.transparentLightBlue
        
        // 4
        let planeNode = SCNNode(geometry: plane)
        
        // 5
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x,y,z)
        planeNode.eulerAngles.x = -.pi / 2
        
        // 6
        node.addChildNode(planeNode)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
            let planeNode = node.childNodes.first,
            let plane = planeNode.geometry as? SCNPlane
            else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
}

