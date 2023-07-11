# class User < ApplicationRecord
#     has_secure_password
  

#     validates :name,presence:true
#     validates :username,presence:true,uniqueness:true,
#     validates :email,presence:true,uniqueness:true
#     validates :password,presence:true,length: { minimum: 6 }
    
#     validates :type, inclusion: { in: ["Instructor", "Student"] }
  
#     def Student?
#       self.type == "Student"
#     end
  
#     def Instructor?
#       self.type == "Instructor"
#     end
#   end
  
class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true , format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :password, presence: true, length: { minimum: 6 }
  
  validates :type, inclusion: { in: ["Instructor", "Student"] }

  def Student?
    self.type == "Student"
  end

  def Instructor?
    self.type == "Instructor"
  end
end
  