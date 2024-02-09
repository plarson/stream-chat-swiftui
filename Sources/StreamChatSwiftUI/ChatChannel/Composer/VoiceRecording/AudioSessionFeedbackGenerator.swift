//
// Copyright © 2024 Stream.io Inc. All rights reserved.
//

import Foundation
import UIKit.UIImpactFeedbackGenerator
import UIKit.UISelectionFeedbackGenerator

/// A protocol that defines the required methods for providing haptic feedback for different events in an audio session
public protocol AudioSessionFeedbackGenerator {
    /// Initialises an instance of the conforming type
    init()

    /// Provides feedback when playback starts
    func feedbackForPlay()

    /// Provides feedback when playback is paused
    func feedbackForPause()

    /// Provides feedback when playback is stopped
    func feedbackForStop()

    /// Provides feedback when the playback rate changes
    func feedbackForPlaybackRateChange()

    /// Provides feedback when seeking through the audio playback
    func feedbackForSeeking()

    /// Provides feedback when preparing to start a recording
    func feedbackForPreparingRecording()

    /// Provides feedback when starting a recording
    func feedbackForBeginRecording()

    /// Provides feedback when cancelling a recording
    func feedbackForCancelRecording()

    /// Provides feedback when stopping a recording
    func feedbackForStopRecording()

    /// Provides feedback when discarding a recording
    func feedbackForDiscardRecording()
}

/// A class that conforms to the AudioSessionFeedbackGenerator protocol
open class StreamAudioSessionFeedbackGenerator: AudioSessionFeedbackGenerator {
#if !os(visionOS)
    /// The following properties are instances of feedback generators
    private let lightImpactFeedbackGenerator: UIImpactFeedbackGenerator
    private let mediumImpactFeedbackGenerator: UIImpactFeedbackGenerator
    private let heavyImpactFeedbackGenerator: UIImpactFeedbackGenerator
    private let selectionFeedbackGenerator: UISelectionFeedbackGenerator
#endif
    /// A required initialiser for the AudioSessionFeedbackGenerator protocol
#if !os(visionOS)
    public required convenience init() {
        self.init(
            {
                UIImpactFeedbackGenerator(style: $0)
            },
            selectionFeedbackGeneratorProvider: { .init() }
        )
    }
#else
    public required init() {

    }
#endif

#if !os(visionOS)
    init(
        _ impactFeedbackGeneratorProvider: (UIImpactFeedbackGenerator.FeedbackStyle) -> UIImpactFeedbackGenerator,
        selectionFeedbackGeneratorProvider: () -> UISelectionFeedbackGenerator
    ) {
        lightImpactFeedbackGenerator = impactFeedbackGeneratorProvider(.light)
        mediumImpactFeedbackGenerator = impactFeedbackGeneratorProvider(.medium)
        heavyImpactFeedbackGenerator = impactFeedbackGeneratorProvider(.heavy)
        selectionFeedbackGenerator = selectionFeedbackGeneratorProvider()
    }
#endif

    /// Methods that play haptic feedback for different events

    open func feedbackForPlay() {
#if !os(visionOS)
        lightImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForPause() {
#if !os(visionOS)
        lightImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForStop() {
#if !os(visionOS)
        mediumImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForPlaybackRateChange() {
#if !os(visionOS)
        mediumImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForSeeking() {
#if !os(visionOS)
        selectionFeedbackGenerator.selectionChanged()
#endif
    }

    open func feedbackForPreparingRecording() {
#if !os(visionOS)
        lightImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForBeginRecording() {
#if !os(visionOS)
        mediumImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForCancelRecording() {
#if !os(visionOS)
        heavyImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForStopRecording() {
#if !os(visionOS)
        mediumImpactFeedbackGenerator.impactOccurred()
#endif
    }

    open func feedbackForDiscardRecording() {
#if !os(visionOS)
        heavyImpactFeedbackGenerator.impactOccurred()
#endif
    }
}
