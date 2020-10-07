module Customers
  # Service to create customer and his address record, if email exists in DB data will be updated
  # params: [:firstname:, :lastname, :email, address: [:address1, :address2, :zip_code]]
  class CreateOrUpdateService < BaseService
    def initialize(params)
      @params = params
      @customer = nil
    end

    def call
      assign_objects
      @customer.save
      success(id: @customer.id)
    end

    def validate
      assign_objects
      if @customer.valid? && @customer.address.valid?
        success
      else
        failure(customer: errors_message)
      end
    end

    private

    def assign_objects
      return if @customer

      @customer = Customer.find_by(email: @params[:email]) || Customer.new
      @customer.assign_attributes(@params.except(:address))
      @customer.address ||= Address.new
      @customer.address.assign_attributes(@params[:address])
    end

    def errors_message
      @customer.errors.messages.merge(address: @customer.address.errors.messages)
    end
  end
end
