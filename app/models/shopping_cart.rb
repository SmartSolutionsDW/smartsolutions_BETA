# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  status     :string
#  ip         :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


class ShoppingCart < ActiveRecord::Base
	include AASM
	has_many :products, through: :in_shopping_carts
	has_many :in_shopping_carts
	has_many :my_payments
	
	aasm column: "status" do
		state :created, initial: true
		state :payed
		state :failed

		event :pay do
			transitions from: :created, to: :payed
		end
	end

	def payment
		begin
			my_payments.payed.first
		rescue Exception => e
			return nil
		end
	end

	def items
		self.products.map{|product| product.paypal_form  }
	end

	def total
		products.sum(:pricing)
	end
end
