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
end
