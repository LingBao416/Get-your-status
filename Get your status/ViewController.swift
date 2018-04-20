import UIKit
import CoreMotion

class ViewController: UIViewController {
    //display realtime info
    @IBOutlet weak var textView: UITextView!
    
    //motion manager object
    let motionActivityManager = CMMotionActivityManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get your status
        startActivityUpdates()
    }
    
    // get the data
    func startActivityUpdates() {
        //identify status
        guard CMMotionActivityManager.isActivityAvailable() else {
            self.textView.text = "\n当前设备不支持获取当前运动状态\n"
            return
        }
        let queue = OperationQueue.current
        self.motionActivityManager.startActivityUpdates(to: queue!, withHandler: {
            activity in
            //get all data
            var text = "---active data---\n"
            text += "Status: \(activity!.getDescription())\n"
            if (activity!.confidence == .low) {
                text += "accuracy: low\n"
            } else if (activity!.confidence == .medium) {
                text += "accuracy: medium\n"
            } else if (activity!.confidence == .high) {
                text += "accuracy: high\n"
            }
            self.textView.text = text
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CMMotionActivity {
    /// get description
    func getDescription() -> String {
        if self.stationary {
            return "Still"
        } else if self.walking {
            return "Walking"
        } else if self.running {
            return "Running"
        } else if self.automotive {
            return "Driving"
        }else if self.cycling {
            return "Cycling"
        }
        return "Unknown"
    }
}
