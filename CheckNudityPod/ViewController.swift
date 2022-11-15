//
//  ViewController.swift
//  CheckNudityPod
//
//  Created by iMac on 14/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NudityModel.checkLocalVideoUrlNudity(with: "file:///Users/imac/Library/Developer/CoreSimulator/Devices/156F2A02-F3F6-403B-AAA7-CFD133A96243/data/Containers/Data/PluginKitPlugin/DF8AEDEC-2E25-4E7C-B65F-3E34CAE38C84/tmp/trim.7DB125E7-EA6E-48B3-BB57-7C5373744DAB.MOV", securityLevel: .low) { nsfwValue, sfwValue in
            print("nsfwValue: ", nsfwValue)
            print("sfwValue: ", sfwValue)
        }
    }


}

