

import SwiftUI

struct ButtonName: Identifiable, Hashable{
    var id = UUID()
    let name: String
}

struct Stock: Identifiable, Hashable{
    var id = UUID()
    let ticker: String
}


struct ContentView: View {
    let listOfNavigations: [ButtonName] = [
        .init(name: "💖"),
        .init(name: "Timer"),
        .init(name: "Bubble Level"),
        .init(name: "Slider Bar"),
        .init(name: "Pictures")
    ]
    
    var body: some View {

        NavigationStack{
            List(listOfNavigations) {button in
                NavigationLink(button.name,
                               value:button)
            }
            .navigationDestination(for: ButtonName.self) {button in
                Text(button.name)
            }
        }
    }
    
    struct ContentView: View {
        @StateObject private var vm = ViewModel()
        private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        private let width: Double = 250
        
        var body: some View {
            VStack {
                Text("\(vm.time)")
                    .font(.system(size: 70, weight: .medium, design: .rounded))
                    .alert("Timer done!", isPresented: $vm.showingAlert) {
                        Button("Continue", role: .cancel) {
                            // Code
                        }
                    }
                    .padding()
                    .frame(width: width)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                
                Slider(value: $vm.minutes, in: 1...10, step: 1)
                    .padding()
                    .disabled(vm.isActive)
                    .animation(.easeInOut, value: vm.minutes)
                    .frame(width: width)

                HStack(spacing:50) {
                    Button("Start") {
                        vm.start(minutes: vm.minutes)
                    }
                    .disabled(vm.isActive)
                    
                    Button("Reset", action: vm.reset)
                        .tint(.red)
                }
                .frame(width: width)
            }
            .onReceive(timer) { _ in
                vm.updateCountdown()
            }
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
