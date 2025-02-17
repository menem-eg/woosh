import SwiftUI
import WatchConnectivity

struct ContentView: View {
    // State for login status and watch pairing
    @State private var isLoggedIn = true // Assume logged in for now
    @StateObject private var watchPairingManager = WatchPairingManager()
    
    var body: some View {
        NavigationView {
            List {
                // Login Status Section
                Section {
                    NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn)) {
                        HStack {
                            Text("Account")
                            Spacer()
                            if isLoggedIn {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                
                // Device Status Section
                Section(header: Text("Device Status")) {
                    HStack {
                        Text("Apple Watch Status")
                        Spacer()
                        Text(watchPairingManager.isWatchPaired ? "Paired ✅" : "Not Paired ❌")
                            .foregroundColor(.gray)
                    }
                }
                
                // Navigation Links
                Section {
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                    }
                    
                    NavigationLink(destination: InstructionsView()) {
                        Text("Instructions")
                    }
                }
            }
            .navigationTitle("woosh")
            .listStyle(.insetGrouped)
        }
        .navigationViewStyle(.stack)
    }
}

// Watch Pairing Manager
class WatchPairingManager: NSObject, ObservableObject, WCSessionDelegate {
    @Published var isWatchPaired = false
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.isWatchPaired = (activationState == .activated) && session.isPaired
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
}
