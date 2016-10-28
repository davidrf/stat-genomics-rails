require "rails_helper"

RSpec.describe "Directory entry requests" do
  describe "GET /folders/:folder_id" do
    context "home directory of user" do
      let(:directory_entry) { create(:directory_entry) }
      let(:user) { directory_entry.user }

      it "returns a no content response" do
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

      it "returns a no content response" do
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

      it "returns a no content response" do
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
end
