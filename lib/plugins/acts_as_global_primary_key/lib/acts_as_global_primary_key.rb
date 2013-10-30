# -*- encoding : utf-8 -*-
require 'active_support/concern'
require 'active_record'
module ActsAsGlobalPrimaryKey
  class MissingPrimaryKeyPrefixError < StandardError;
  end

  MODEL_ID_MAPPING = {
      :user                   => 1,
      :blog                   => 2,
      :product                => 8
  }
  # {model_id}{model_shard}-{timestamp(since 20110101)}-{rand}
  # all numbers formatted as hex
  # eg. '0101-04687fc9b0-9995'
  GLOBAL_ID_FORMAT = '%02x%02x-%010x-%04x'

  module Core
    extend ActiveSupport::Concern
    GLOBAL_ID_FORMAT = '%02x%02x-%010x-%04x'

    MODEL_SHARD = 0

    included do
      before_create do
        self.generate_primary_key! if self.id.blank?
      end
    end

    module ClassMethods
      def primary_key_prefix primary_class=nil 
        primary_class ||= self
        model_id = MODEL_ID_MAPPING[primary_class.to_s.underscore.to_sym]
        if model_id.blank? && self.superclass != ActiveRecord::Base
          self.primary_key_prefix(self.superclass)
        else
          model_id
        end
      end

      # generate global id
      def generate_global_primary_key!
        model_id = self.primary_key_prefix
        raise "Model(#{self.to_s}) is not allowed to act as global id." if model_id.nil?
        GLOBAL_ID_FORMAT % [
            self.primary_key_prefix,
            MODEL_SHARD,
            ((Time.now - Time.utc(2013, 1, 1)) * 1000).to_i,
            rand(0xFFFF)
        ]
      end
    end

    def generate_primary_key!
      self.id or self.id = self.class.generate_global_primary_key!
    end
  end
end

module ActsAsGlobalPrimaryKey
  extend ActiveSupport::Concern
  module ClassMethods

    def acts_as_global_primary_key?
      self.included_modules.include?(ActsAsGlobalPrimaryKey::Core)
    end

    # {model_id}{model_shard}-{timestamp(since 20110101)}-{rand}
    # all numbers formatted as hex
    # eg. '0101-04687fc9b0-9995'
    def acts_as_global_primary_key
      return if acts_as_global_primary_key?
      include ActsAsGlobalPrimaryKey::Core
    end
  end
end

ActiveSupport.on_load(:active_record) {
  include ActsAsGlobalPrimaryKey
}

