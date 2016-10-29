require "rails_helper"

RSpec.describe "Directory entry requests" do
  describe "GET /folders/:folder_id" do
    context "home directory of user" do
      let(:directory_entry) { create(:directory_entry) }
      let(:user) { directory_entry.user }

      it "returns an ok response" do
        get(
          folder_url(directory_entry),
          headers: authorization_headers(:v1, user)
        )

        expect(response).to have_http_status :ok
        expect(parsed_body).to match(
          "folder" => expected_directory_entry_hash(directory_entry)
        )
      end
    end

    context "home directory of user with folders and files" do
      let(:directory_entry) do
        create(:directory_entry, :with_folders, :with_files).reload
      end
      let(:user) { directory_entry.user }

      it "returns an ok response" do
        get(
          folder_url(directory_entry),
          headers: authorization_headers(:v1, user)
        )

        expect(response).to have_http_status :ok
        expect(parsed_body).to match(
          "folder" => expected_directory_entry_hash(directory_entry)
        )
      end
    end

    context "non-home directory of user with folders and files" do
      let(:home_directory) do
        create(:directory_entry, :with_folder_that_has_files).reload
      end
      let(:non_home_directory) { home_directory.children.first }
      let(:user) { home_directory.user }

      it "returns an ok response" do
        get(
          folder_url(non_home_directory),
          headers: authorization_headers(:v1, user)
        )

        expect(response).to have_http_status :ok
        expect(parsed_body).to match(
          "folder" => expected_directory_entry_hash(non_home_directory)
        )
      end
    end
  end

  describe "POST /folders" do
    let(:directory_entry) { build(:directory_entry) }
    let(:user) { create :user }
    let(:user_home_directory_entry) { user.root_directory_entry }

    context "valid attributes" do
      let(:folder_attributes) do
        {
          folder: {
            name: directory_entry.name,
            parent_id: user_home_directory_entry.id
          }
        }
      end

      it "returns a created response" do
        post(
          folders_url,
          headers: authorization_headers(:v1, user),
          params: folder_attributes,
          as: :json
        )

        expect(response).to have_http_status :created
        new_directory_entry = DirectoryEntry.find_by(folder_attributes[:folder])
        expect(parsed_body).to match(
          "folder" => expected_directory_entry_hash(new_directory_entry)
        )
      end
    end

    context "invalid attributes" do
      let(:folder_attributes) do
        {
          folder: {
            name: nil,
            parent: nil
          }
        }
      end

      it "returns an unprocessable entity response" do
        post(
          folders_url,
          headers: authorization_headers(:v1, user),
          params: folder_attributes,
          as: :json
        )

        expect(response).to have_http_status :unprocessable_entity
        expect(parsed_body).to match(
          "name" => ["can't be blank"]
        )
      end
    end

    context "unauthenticated user" do
      let(:folder_attributes) do
        {
          folder: {
            name: directory_entry.name,
            parent_id: user_home_directory_entry.id
          }
        }
      end

      it "returns an unauthorized response" do
        post(
          folders_url,
          headers: accept_header(:v1),
          params: folder_attributes,
          as: :json
        )

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
