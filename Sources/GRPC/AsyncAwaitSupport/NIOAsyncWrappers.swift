/*
 * Copyright 2022, gRPC Authors All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#if compiler(>=5.6)
import NIOCore

/// Unchecked-sendable wrapper for ``NIOAsyncWriter/Sink``, to avoid getting sendability warnings.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
internal struct AsyncSink<Element: Sendable>: @unchecked Sendable {
  private let sink: NIOAsyncWriter<
    Element,
    GRPCAsyncWriterSinkDelegate<Element>
  >.Sink

  @inlinable
  init(wrapping sink: NIOAsyncWriter<
    Element,
    GRPCAsyncWriterSinkDelegate<Element>
  >.Sink) {
    self.sink = sink
  }

  @inlinable
  func setWritability(to writability: Bool) {
    self.sink.setWritability(to: writability)
  }

  @inlinable
  func finish(error: Error) {
    self.sink.finish(error: error)
  }

  @inlinable
  func finish() {
    self.sink.finish()
  }
}
#endif // compiler(>=5.6)
