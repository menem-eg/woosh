//
//  WatchCommunicationManager.swift
//  woosh
//
//  Created by Abdelmonem Shaker on 14/02/2025.
//
import WatchConnectivity
import Foundation

class WatchCommunicationManager: NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    static let shared = WatchCommunicationManager()
    private let apiURL = URL(string: "https://your-api-endpoint.com/shake-event")!
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if message["event"] as? String == "shake_detected",
           let timestamp = message["timestamp"] as? TimeInterval {
            sendShakeEventToAPI(timestamp: timestamp)
        }
    }
    
    private func sendShakeEventToAPI(timestamp: TimeInterval) {
        let payload: [String: Any] = [
            "event": "shake_detected",
            "timestamp": timestamp
        ]
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("⚠️ API Error: \(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                      let data = data,
                      let apiResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let message = apiResponse["message"] as? String {
                // Show toast with API response
                DispatchQueue.main.async {
                    self.showToast(message: message)
                }
            }
        }.resume()
    }
    
    private func showToast(message: String) {
        // Implement toast UI (e.g., SwiftUI or UIKit)
        print("✅ Toast: \(message)")
    }
    
    // Required delegate methods below...
}
