import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section(header: Text("Preferences")) {
                Text("Notification Settings")
                Text("Appearance")
            }
            
            Section(header: Text("About")) {
                Text("Version 1.0")
                Text("Privacy Policy")
            }
        }
        .navigationTitle("Settings")
    }
}
