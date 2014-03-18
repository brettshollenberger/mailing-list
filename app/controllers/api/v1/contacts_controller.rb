module Api
  module V1
    class ContactsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        respond_with(Contact.all)
      end

      def show
        respond_with(Contact.find(params[:id]))
      end

      def create
        @todo = Contact.new(todo_params)
        if @todo.save
          respond_to do |format|
            format.json { render :json => @todo }
          end
        end
      end

      def update
        @todo = Contact.find(params[:id])
        if @todo.update(todo_params)
          respond_to do |format|
            format.json { render :json => @todo }
          end
        end
      end

      def destroy
        respond_with Contact.destroy(params[:id])
      end

    private
      def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email, :join_date, :last_contacted)
      end
    end
  end
end
