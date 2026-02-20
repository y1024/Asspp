//
//  ViewBackports.swift
//  Asspp
//
//  Created by luca on 19.09.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func mediumAndLargeDetents() -> some View {
        #if os(iOS)
            presentationDetents([.medium, .large])
        #else
            self
        #endif
    }

    @ViewBuilder
    func neverMinimizeTab() -> some View {
        #if os(iOS)
            if #available(iOS 26.0, *) {
                tabBarMinimizeBehavior(.never)
            } else {
                self
            }
        #else
            self
        #endif
    }

    @ViewBuilder
    func activateSearchWhenSearchTabSelected() -> some View {
        #if os(iOS)
            if #available(iOS 26.0, *) {
                tabViewSearchActivation(.searchTabSelection)
            } else {
                self
            }
        #else
            self
        #endif
    }

    @ViewBuilder
    func sidebarAdaptableTabView() -> some View {
        #if os(iOS)
            if #available(iOS 26.0, *) {
                tabViewStyle(.sidebarAdaptable)
            } else {
                self
            }
        #else
            self
        #endif
    }

    @ViewBuilder
    func hide() -> some View {}
}

public extension ToolbarContent {
    @ToolbarContentBuilder
    @available(iOS 16.0, macOS 13.0, *)
    nonisolated func hideSharedBackground() -> some ToolbarContent {
        if #available(iOS 26.0, macOS 26.0, *) {
            sharedBackgroundVisibility(.hidden)
        } else {
            self
        }
    }
}

struct FormOnTahoeList<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        #if os(macOS) && compiler(>=6.2)
            if #available(macOS 26.0, *) {
                Form {
                    content
                }
                .formStyle(.grouped)
            } else {
                List {
                    content
                }
                // footers on Sequoia looks weird ...
            }
        #else
            List {
                content
            }
        #endif
    }
}
