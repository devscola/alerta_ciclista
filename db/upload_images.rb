require 'cloudinary'

File.open("images.txt", "r") do |f|
  f.each_line do |line|
    l = line.gsub("\n",'')
    result = Cloudinary::Uploader.upload(l)
    puts "uploaded #{l} as #{result['public_id']}"
  end
end
