import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("How to Use")
                    .font(.title)
                
                Text("1. Ensure your Apple Watch is paired\n2. Enable shake detection in settings\n3. Shake to trigger events")
                    .padding(.bottom)
                
                Text("Troubleshooting")
                    .font(.title2)
                Text("• Check Bluetooth connection\n• Restart both devices if issues persist")
            }
            .padding()
        }
        .navigationTitle("Instructions")
    }
}
