/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A `Landmark` is the name and location of a point on a human body, including:
 - Left shoulder
 - Right eye
 - Nose
*/

import UIKit
import Vision

extension Pose {
    typealias JointName = VNHumanBodyPoseObservation.JointName

    /// The name and location of a point of interest on a human body.

    struct Landmark {
        /// The minimum `VNRecognizedPoint` confidence for a valid `Landmark`.
        private static let threshold: Float = 0.2

        /// The drawing radius of a landmark.
        private static let radius: CGFloat = 14.0

        let name: JointName
        let location: CGPoint

        init?(_ point: VNRecognizedPoint) {
            // Only create a landmark from a point that satisfies the minimum
            // confidence.
            guard point.confidence >= Pose.Landmark.threshold else {
                return nil
            }

            name = JointName(rawValue: point.identifier)
            location = point.location
        }

        /// Draws a circle at the landmark's location after transformation.
        func drawToContext(_ context: CGContext,
                           applying transform: CGAffineTransform? = nil,
                           at scale: CGFloat = 1.0) {

            context.setFillColor(UIColor.white.cgColor)
            context.setStrokeColor(UIColor.darkGray.cgColor)

            // Define the rectangle's origin by applying the transform to the
            // landmark's normalized location.
            let origin = location.applying(transform ?? .identity)

            // Define the size of the circle's rectangle with the radius.
            let radius = Landmark.radius * scale
            let diameter = radius * 2
            let rectangle = CGRect(x: origin.x - radius,
                                   y: origin.y - radius,
                                   width: diameter,
                                   height: diameter)

            context.addEllipse(in: rectangle)
            context.drawPath(using: CGPathDrawingMode.fillStroke)
        }
    }
}
