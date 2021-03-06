# Copyright (C) 2014-2015 MongoDB, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module Mongo
  # Base error class for all Mongo related errors.
  #
  # @since 2.0.0
  class Error < StandardError

    # The error code field.
    #
    # @since 2.0.0
    CODE = 'code'.freeze

    # An error field, MongoDB < 2.6
    #
    # @since 2.0.0
    ERR = '$err'.freeze

    # An error field, MongoDB < 2.4
    #
    # @since 2.0.0
    ERROR = 'err'.freeze

    # The standard error message field, MongoDB 3.0+
    #
    # @since 2.0.0
    ERRMSG = 'errmsg'.freeze

    # The constant for the writeErrors array.
    #
    # @sicne 2.0.0
    WRITE_ERRORS = 'writeErrors'.freeze

    # The constant for write concern errors.
    #
    # @since 2.0.0
    WRITE_CONCERN_ERROR = 'writeConcernError'.freeze

    # Constant for an unknown error.
    #
    # @since 2.0.0
    UNKNOWN_ERROR = 8.freeze

    # Constant for a bad value error.
    #
    # @since 2.0.0
    BAD_VALUE = 2.freeze
  end
end

require 'mongo/error/parser'
require 'mongo/error/bulk_write_failure'
require 'mongo/error/operation_failure'
require 'mongo/error/empty_batch'
require 'mongo/error/invalid_bulk_operation'
require 'mongo/error/invalid_collection_name'
require 'mongo/error/invalid_database_name'
require 'mongo/error/invalid_document'
require 'mongo/error/invalid_file'
require 'mongo/error/invalid_nonce'
require 'mongo/error/invalid_replacement_document'
require 'mongo/error/invalid_signature'
require 'mongo/error/invalid_update_document'
require 'mongo/error/max_bson_size'
require 'mongo/error/max_message_size'
require 'mongo/error/need_primary_server'
require 'mongo/error/socket_error'
require 'mongo/error/socket_timeout_error'
require 'mongo/error/unsupported_features'
