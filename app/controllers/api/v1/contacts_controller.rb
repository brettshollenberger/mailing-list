module Api
  module V1
    class ContactsController < ApplicationController
      skip_before_filter :verify_authenticity_token
      respond_to :json

      def index
        respond_with(Contact.where(build_query).limit(5))
      end

      def show
        respond_with(Contact.find(params[:id]))
      end

      def create
        @todo = Contact.new(contact_params)
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

      def queryable_keys
        [:first_name, :last_name, :email]
      end

      def queryable?(key)
        queryable_keys.include?(key.to_sym)
      end

      def build_query
        fuzzy? ? build_fuzzy_query : build_normal_query
      end

      def fuzzy?
        params[:fuzzy] != nil && params[:fuzzy].to_s != "false"
      end

      def build_normal_query
        Hash[params.map { |key, value| [key, value] if queryable?(key) }]
      end

      def add_fuzzy(query, key, value, or_statement=false)
        if query[0].length > 0
          query[0] += or_statement ? " OR " : " AND "
        end
        query[0] += "#{key} ILIKE ?"
        query.push("%#{value}%")
        query
      end

      def build_fuzzy_query
        query = [""]

        if params[:any]
          queryable_keys.each { |key| query = add_fuzzy(query, key, params[:any], or_statement=true) }
        else
          params.each do |key, value|
            if queryable?(key)
              query = add_fuzzy(query, key, value)
            end
          end
        end
        query
      end
    end
  end
end
