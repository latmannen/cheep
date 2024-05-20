# == Schema Information
#
# Table name: recommendations
#
#  id            :integer          not null, primary key
#  interests     :string
#  other_content :string
#  visit_type    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
class Recommendation < ApplicationRecord
  #belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"

  has_many  :messages, class_name: "Message", foreign_key: "rec_id", dependent: :destroy
end
