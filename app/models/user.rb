# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address1               :string
#  address2               :string
#  address3               :string
#  bio                    :string
#  city                   :string
#  country                :string
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  password               :string
#  phone                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  state                  :string
#  username               :string
#  zip                    :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many(
        :ads,
        class_name:'Ad',
        foreign_key: 'user_id',
        inverse_of: :user,
        dependent: :destroy
    )

    has_many(
        :purchases,
        class_name: 'Purchase',
        foreign_key: 'user_id',
        inverse_of: :user,
        dependent: :destroy
    )

    has_many(
        :conversations,
        class_name: 'Conversation',
        foreign_key: 'user_id',
        inverse_of: :user,
        dependent: :destroy
    )

    has_one(
        :credit_cards,
        class_name: 'CreditCard',
        foreign_key: 'user_id',
        inverse_of: :user,
        dependent: :destroy
    )

    has_one_attached :image
    has_many :favorites
    has_many :favorite_ads, through: :favorites, source: :favorited, source_type: 'Ad'

    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    # validates :password, presence: true
    
    def name
        email.split('@')[0]
    end

end
