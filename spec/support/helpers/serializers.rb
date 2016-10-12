module Helpers
  module Serializers
    def expected_user_hash(user)
      {
        "created_at" => user.created_at.as_json,
        "email" => user.email,
        "id" => user.id,
        "updated_at" => user.updated_at.as_json
      }
    end

    def expected_authentication_hash(user)
      {
        "user" => expected_user_hash(user),
        "access_token" => an_instance_of(String)
      }
    end

    def serialize_model_to_json(model, options = {})
      serializable_resource = ActiveModelSerializers::SerializableResource.new(
        model,
        options
      )
      JSON.parse(serializable_resource.to_json)
    end
  end
end
