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

class ar_view : UIViewController, ARSCNViewDelegate {
    @IBOutlet weak var label: UILabel!
    
    var labeltext: String?
    
    @IBOutlet weak var arview: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labeltext!
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tower1_ar.addShipToSceneView(withGestureRecognizer:)))
        arview.addGestureRecognizer(tapGestureRecognizer)
    }
}

