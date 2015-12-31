//
//  ViewController.swift
//  BlinkOCR-sample-Swift
//
//  Created by Dino on 15/12/15.
//  Copyright © 2015 Dino. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, PPScanDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var rawOcrParserId : String = "Raw ocr"
    var priceParserId : String = "Price"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /**
     * Method allocates and initializes the Scanning coordinator object.
     * Coordinator is initialized with settings for scanning
     *
     *  @param error Error object, if scanning isn't supported
     *
     *  @return initialized coordinator
     */
    func coordinatorWithError(error: NSErrorPointer) -> PPCoordinator? {

        /** 0. Check if scanning is supported */

        if (PPCoordinator.isScanningUnsupported(error)) {
            return nil;
        }


        /** 1. Initialize the Scanning settings */

         // Initialize the scanner settings object. This initialize settings with all default values.
        let settings: PPSettings = PPSettings()


        /** 2. Setup the license key */

        // Visit www.microblink.com to get the license key for your app
        settings.licenseSettings.licenseKey = "NFJGS7UK-OMTBE6ML-2436HH6W-CXO2GQTR-HRHRX3E4-URUWS2LJ-NFUWS2LJ-MH2ZS5LK"


        /**
         * 3. Set up what is being scanned. See detailed guides for specific use cases.
         * Here's an example for initializing raw OCR scanning.
         */

         // To specify we want to perform OCR recognition, initialize the OCR recognizer settings
        let ocrRecognizerSettings: PPOcrRecognizerSettings = PPOcrRecognizerSettings()

        // We want raw OCR parsing
        ocrRecognizerSettings.addOcrParser(PPRawOcrParserFactory(), name: self.rawOcrParserId)

        // We want to parse prices from raw OCR result as well
        ocrRecognizerSettings.addOcrParser(PPPriceOcrParserFactory(), name: self.priceParserId)

        // Add the recognizer setting to a list of used recognizer
        settings.scanSettings.addRecognizerSettings(ocrRecognizerSettings)


        /** 4. Initialize the Scanning Coordinator object */

        let coordinator: PPCoordinator = PPCoordinator(settings: settings)

        return coordinator
    }

    @IBAction func didTapScan(sender: AnyObject) {

        /** Instantiate the scanning coordinator */
        let error: NSErrorPointer=nil
        let coordinator:PPCoordinator?=self.coordinatorWithError(error)

        /** If scanning isn't supported, present an error */
        if coordinator == nil {
            let messageString: String = (error.memory?.localizedDescription) ?? ""
            UIAlertView(title: "Warning", message: messageString, delegate: nil, cancelButtonTitle: "Ok").show()
            return
        }

        /** Allocate and present the scanning view controller */
        let scanningViewController: UIViewController = coordinator!.cameraViewControllerWithDelegate(self)

        /** You can use other presentation methods as well */
        self.presentViewController(scanningViewController, animated: true, completion: nil)
    }

    func scanningViewControllerUnauthorizedCamera(scanningViewController: UIViewController!) {
        // Add any logic which handles UI when app user doesn't allow usage of the phone's camera
    }

    func scanningViewController(scanningViewController: UIViewController!, didFindError error: NSError!) {
        // Can be ignored. See description of the method
    }

    func scanningViewControllerDidClose(scanningViewController: UIViewController!) {
        // As scanning view controller is presented full screen and modally, dismiss it
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func scanningViewController(scanningViewController: UIViewController!, didOutputResults results: [AnyObject]!) {

        let scanConroller : PPScanningViewController = scanningViewController as! PPScanningViewController


        // Here you process scanning results. Scanning results are given in the array of PPRecognizerResult objects.

        // first, pause scanning until we process all the results
        scanConroller.pauseScanning()

        // Collect data from the result
        for result in results {

            if(result.isKindOfClass(PPOcrRecognizerResult)) {
                let ocrRecognizerResult : PPOcrRecognizerResult=result as! PPOcrRecognizerResult
                
                print("OCR results are:");
                print("Raw ocr: %@", ocrRecognizerResult.parsedResultForName(self.rawOcrParserId))
                print("Price: %@", ocrRecognizerResult.parsedResultForName(self.priceParserId))

                let ocrLayout : PPOcrLayout=ocrRecognizerResult.ocrLayout()
                print("Dimensions of ocrLayout are %@", NSStringFromCGRect(ocrLayout.box))
            }
        }

        // resume scanning while preserving internal recognizer state
        scanConroller.resumeScanningAndResetState(false);
    }

//    func scanningViewController<T: UIViewController where T:protocol<PPScanningViewController>>(val:T, didOutputResults results: [AnyObject]) {
//    }
    // dismiss the scanning view controller when user presses OK.

    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

