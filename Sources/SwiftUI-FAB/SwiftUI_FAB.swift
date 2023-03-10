import SwiftUI

struct FloatingActionButtonModifier<ImageView: View>: ViewModifier {
    let color: Color // background color of the FAB
    let image: ImageView // image shown in the FAB
    let action: () -> Void
    var size: CGFloat = 60 // size of the FAB circle
    var insets: EdgeInsets
    @State private var isLoaded = false
    func body(content: Content) -> some View {
        ZStack {
            Color.clear // allows the ZStack to fill the entire screen
            content
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Spacer()
                    button()
                      .scaleEffect(isLoaded ? 1.0 : 0.2)
                      .offset(x: 0 - insets.trailing, y: isLoaded ? 0 - insets.bottom : 36)
                      .animation(.easeOut(duration: 0.5), value: isLoaded)
                }
            }
        }
        .onAppear {
            isLoaded = true
        }
    }
    
    @ViewBuilder private func button() -> some View {
        image
            .imageScale(.large)
            .frame(width: size, height: size)
            .background(Circle().fill(color))
            .shadow(color: .gray, radius: 2, x: 1, y: 1)
            .onTapGesture(perform: action)
    }
}

extension View {
    public func floatingActionButton<ImageView: View>(
      color: Color,
      image: ImageView,
      insets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 15),
      action: @escaping () -> Void) -> some View {
      self.modifier(FloatingActionButtonModifier(color: color, image: image, action: action, insets: insets))
    }
}
