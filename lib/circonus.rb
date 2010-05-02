#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2010 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'json'
require 'rest_client'

class Circonus
  VERSION = "0.0.1"

  attr_writer :email, :password, :account
  attr_reader :rest

  def initialize(email, password, account=nil)
    @email = email
    @password = password
    @account = account
    @format = "json"
    @rest = RestClient::Resource.new("https://circonus.com/api/#{@format}")
  end

  def options(args={})
    response = {
      :email => @email,
      :password => @password
    }
    response[:account] = @account if @account
  
    args.each do |key, value|
      response[key] = value
    end

    response
  end

  def deserialize(&block)
    value = block.call
    JSON.parse(value)
  end

  ###
  # Read Methods
  ###
  def list_accounts
    deserialize do
      @rest['list_accounts'].post(options)
    end
  end

  def list_agents
    deserialize do
      @rest['list_agents'].post(options)
    end
  end

  def list_checks(opts={})
    deserialize do
      @rest['list_checks'].post(options(opts))
    end
  end

  def list_metrics(opts={})
    deserialize do
      @rest['list_metrics'].post(options(opts))
    end
  end

  def list_rules(opts={})
    deserialize do
      @rest['list_rules'].post(options(opts))
    end
  end

  ###
  # Write Methods
  ###
  def add_check_bundle(opts={})
    deserialize do
      @rest['add_check_bundle'].post(options(opts))
    end
  end

  def edit_check_bundle(opts={})
    deserialize do
      @rest['edit_check_bundle'].post(options(opts))
    end
  end

  def enable_check_bundle(opts={})
    deserialize do
      @rest['enable_check_bundle'].post(options(opts))
    end
  end

  def disable_check_bundle(opts={})
    deserialize do
      @rest['disable_check_bundle'].post(options(opts))
    end
  end

  def enable_check(opts={})
    deserialize do
      @rest['enable_check'].post(options(opts))
    end
  end

  def disable_check(opts={})
    deserialize do
      @rest['disable_check'].post(options(opts))
    end
  end

  def add_metric_rule(opts={})
    deserialize do
      @rest['add_metric_rule'].post(options(opts))
    end
  end

  def remove_metric_rule(opts={})
    deserialize do
      @rest['remove_metric_rule'].post(options(opts))
    end
  end

end
