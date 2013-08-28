require 'fog/core/collection'
require 'fog/rackspace/models/auto_scale/webhook'

module Fog
  module Rackspace
    class AutoScale
      class Webhooks < Fog::Collection

        model Fog::Rackspace::AutoScale::Webhook

        attr_accessor :group_id
        attr_accessor :policy_id

        def all
          data = service.list_webhooks(group_id, policy_id).body['webhooks']
          load(data)
        end

        def get(webhook_id)          
          data = service.get_webhook(group_id, policy_id, webhook_id).body['webhook']
          data['group_id'] = group_id
          data['policy_id'] = policy_id
          new(data)
        rescue Fog::Rackspace::AutoScale::NotFound
          nil
        end

        def create(attributes = {})
          attributes['group_id'] = group_id
          attributes['policy_id'] = policy_id
          super(attributes)
        end

      end
    end
  end
end