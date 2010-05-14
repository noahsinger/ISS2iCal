class User < ActiveRecord::Base
  acts_as_authentic
  belongs_to :role
  
  def role_symbols  
    # roles.map do |role|  
    #   role.name.underscore.to_sym  
    # end  
    [role.name.underscore.to_sym]
  end
end
