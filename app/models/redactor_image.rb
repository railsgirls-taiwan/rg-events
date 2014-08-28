class RedactorImage < ActiveRecord::Base

  mount_uploader :image, RedactorImageUploader

end
