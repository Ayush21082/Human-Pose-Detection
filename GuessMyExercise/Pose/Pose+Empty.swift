/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Defines an "empty" pose multiarray with same dimensions as an array from
 Vision's human body pose observation.
 The project uses this as a default when a real pose array isn't available.
*/

import CoreML

extension Pose {

    static let emptyPoseMultiArray = zeroedMultiArrayWithShape([1, 3, 18])

    private static func zeroedMultiArrayWithShape(_ shape: [Int]) -> MLMultiArray {
        // Create the multiarray.
        guard let array = try? MLMultiArray(shape: shape as [NSNumber],
                                            dataType: .double) else {
            fatalError("Creating a multiarray with \(shape) shouldn't fail.")
        }

        guard let pointer = try? UnsafeMutableBufferPointer<Double>(array) else {
            fatalError("Unable to initialize multiarray with zeros.")
        }

        pointer.initialize(repeating: 0.0)
        return array
    }
}
