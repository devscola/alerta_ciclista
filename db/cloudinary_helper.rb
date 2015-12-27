require 'cloudinary'

def delete_all
  ids = Cloudinary::Api.resources(max_results: 100)["resources"].map { |el| el['public_id'] }
  Cloudinary::Api.delete_resources(ids)
end

def replace_all
  Suggestion.where('image1_id is not NULL').each { |s|
    r = Cloudinary::Uploader.upload(s.image1_id, auth)
    s.image1_id=r['public_id']
    s.save
  }
end
