Dir[File.expand_path '../interactors/**/*.rb', __FILE__].each do |filename|
  require filename
end
