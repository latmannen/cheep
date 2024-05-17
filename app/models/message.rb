# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :string
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rec_id     :integer
#
class Message < ApplicationRecord
  belongs_to :rec_thread, required: true, class_name: "Recommendation", foreign_key: "rec_id"

end
