# Copyright (C) 2015 MongoDB, Inc.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#  http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Mongo
  class Server

    # This provides common behaviour for connection objects.
    #
    # @since 2.0.0
    module Connectable
      include Loggable

      # The default time in seconds to timeout a connection attempt.
      #
      # @since 2.0.0
      TIMEOUT = 5.freeze

      # @return [ Mongo::Address ] address The address to connect to.
      attr_reader :address

      # @return [ Hash ] options The passed in options.
      attr_reader :options

      # Dispatch the provided messages to the connection. If the last message
      # requires a response a reply will be returned.
      #
      # @example Dispatch the messages.
      #   connection.dispatch([ insert, command ])
      #
      # @note This method is named dispatch since 'send' is a core Ruby method on
      #   all objects.
      #
      # @param [ Array<Message> ] messages The messages to dispatch.
      #
      # @return [ Protocol::Reply ] The reply if needed.
      #
      # @since 2.0.0
      def dispatch(messages)
        log_debug(messages) do |msgs|
          write(msgs)
          msgs.last.replyable? ? read : nil
        end
      end

      # Get the connection timeout.
      #
      # @example Get the connection timeout.
      #   connection.timeout
      #
      # @return [ Float ] The connection timeout in seconds.
      #
      # @since 2.0.0
      def timeout
        @timeout ||= options[:socket_timeout] || TIMEOUT
      end

      private

      attr_reader :socket, :ssl_options

      def ensure_connected
        connect! if socket.nil? || !socket.alive?
        yield socket
      end

      def read
        ensure_connected{ |socket| Protocol::Reply.deserialize(socket) }
      end
    end
  end
end
