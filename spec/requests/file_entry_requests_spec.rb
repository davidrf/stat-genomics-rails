require "rails_helper"

RSpec.describe "File entry requests" do
  describe "POST /folders/:folder_id/files" do
    let(:file_entry) { build(:file_entry) }
    let(:user) { create :user }
    let(:user_home_directory_entry) { user.root_directory_entry }

    context "valid attributes" do
      let(:file_attributes) do
        {
          file: {
            name: file_entry.name,
            parent_id: user_home_directory_entry.id
          }
        }
      end

      it "returns a created response" do
        post(
          folder_files_url(user_home_directory_entry),
          headers: authorization_headers(:v1, user),
          params: file_attributes,
          as: :json
        )

        expect(response).to have_http_status :created
        new_file_entry = FileEntry.find_by(file_attributes[:file])
        expect(parsed_body).to match(
          "file" => expected_file_entry_hash(new_file_entry)
        )
      end
    end

    context "invalid attributes" do
      let(:file_attributes) do
        {
          file: {
            name: nil,
            parent_id: nil
          }
        }
      end

      it "returns an unprocessable entity response" do
        post(
          folder_files_url(user_home_directory_entry),
          headers: authorization_headers(:v1, user),
          params: file_attributes,
          as: :json
        )

        expect(response).to have_http_status :unprocessable_entity
        expect(parsed_body).to match(
          "name" => ["can't be blank"],
          "parent" => ["can't be blank"]
        )
      end
    end

    context "unauthenticated user" do
      let(:file_attributes) do
        {
          file: {
            name: file_entry.name,
            parent_id: user_home_directory_entry.id
          }
        }
      end

      it "returns an unauthorized response" do
        post(
          folder_files_url(user_home_directory_entry),
          headers: accept_header(:v1),
          params: file_attributes,
          as: :json
        )

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
