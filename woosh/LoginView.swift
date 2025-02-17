import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login Page")
                .font(.title)
            
            Button(action: {
                isLoggedIn = true
                dismiss()
            }) {
                Text("Tap to Login (Dummy)")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Login")
    }
}
