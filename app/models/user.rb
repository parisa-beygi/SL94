class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :nickname, presence: true , uniqueness: true
  validate :validate_date?

  def validate_date?

    if((Date.today.year * 12 + Date.today.month) - (self.birth_date.year * 12 + self.birth_date.month) < 12 * 8)
      errors.add(:age,   'شما مناسب این بازی نیست');
    end
  end

end
