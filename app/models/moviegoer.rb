class Moviegoer < ActiveRecord::Base
	 include ActiveModel::MassAssignmentSecurity
	 # attr_protected :uid, :provider, :name # see text for explanation
	 belongs_to :indentity
	 def self.create_with_omniauth(auth)
	 	  i = Identity.new
		  m =  Moviegoer.create!(
		     :provider => auth["provider"],
		     :uid => auth["uid"],
		     :name => auth["info"]["name"])
		  i.moviegoers << m 
		  i.save!
		  return m
	end
end
