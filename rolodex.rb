class Rolodex

	def initialize
		@contacts = []
		@id = 1000
	end

	def add_contact(contact)
		contact.id = @id
		@contacts << contact
		@id += 1
	end

	def find(contact_id)
		@contacts.find do |contact|
			contact.id == contact_id			
		end
	end	




	def modify_contact(contact_id)
		@contacts.find do |contact|
			contact.id == contact.id
			if modify_contact2 == 1
				first_name_changed = first_name.replace
			elsif modify_contact2 == 2
				last_name_
			end	
		end		
	end	

	def delete_contact(contact)
	@contacts.delete(contact)
	end

	def display_all
		@contacts.each do |contact|
			puts contact.to_s
		end
	end
end


