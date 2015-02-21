require 'image_manager.rb'

class SuggestionBuilder
  
  def initialize
    @imageManager = ImageManager.new
    @suggestion_hash = {}
  end
  
  def create (suggestion_params, img1, img2)    
    @suggestion_attr = suggestion_params
    uploadImagesToCloudinary(img1, img2)
    @suggestion = Suggestion.new(@suggestion_attr)
    @suggestion_hash[:save] = @suggestion.save
    if @suggestion_hash[:save]
      if in_whiteList?
        @suggestion.update(visible: true)
        @suggestion_hash[:msg] = 'Suggestion was successfully published.'
      else
        @suggestion.update(token_validation: create_token)
        send_validation_email
        @suggestion_hash[:msg] = 'In a few moments you will receive an email to confirm the suggestion.'
      end
    end
    @suggestion_hash[:suggestion] = @suggestion
    return @suggestion_hash
  end
  
  def in_whiteList?
    !WhiteListEmail.find_by(email: @suggestion_attr[:email]).nil?
  end
  
  def create_token
    Digest::MD5.hexdigest(@suggestion.id.to_s + @suggestion.email)
  end
  
  def send_validation_email
    SuggestionMailer.suggestion_validation_email(@suggestion).deliver_later
  end
  
  def uploadImagesToCloudinary(img1, img2)
    unless img1.nil?
      image_hash = @imageManager.upload_image(img1)
      @suggestion_attr[:image1_id] = image_hash['public_id']
    end
    unless img2.nil?
      image_hash = @imageManager.upload_image(img2)
      @suggestion_attr[:image2_id] = image_hash[':public_id']
    end
  end
  
end