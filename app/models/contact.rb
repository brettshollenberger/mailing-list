class Contact < ActiveRecord::Base
  before_validation :ensure_join_date

  validates_presence_of :first_name, :last_name, :email, :join_date

  def ensure_join_date
    self.join_date ||= Date.today
  end
end
