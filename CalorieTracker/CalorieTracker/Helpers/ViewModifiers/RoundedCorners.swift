//
//  RoundedCorners.swift
//  CalorieTracker
//
//  Created by Yauheni Karas on 20/02/2025.
//

import SwiftUI

struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let size = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: size)
        return Path(path.cgPath)
    }
}

struct TopRoundedCorners: ViewModifier {
    var radius: CGFloat
    func body(content: Content) -> some View {
        content
            .clipShape(
                RoundedCornerShape(
                    corners: [.topLeft, .topRight],
                    radius: radius
                )
            )
    }
}

struct BottomRoundedCorners: ViewModifier {
    var radius: CGFloat
    func body(content: Content) -> some View {
        content
            .clipShape(
                RoundedCornerShape(
                    corners: [.bottomLeft, .bottomRight],
                    radius: radius
                )
            )
    }
}

extension View {
    func topRoundedCorners(radius: CGFloat) -> some View {
        modifier(TopRoundedCorners(radius: radius))
    }

    func bottomRoundedCorners(radius: CGFloat) -> some View {
        modifier(BottomRoundedCorners(radius: radius))
    }
}
