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

      def build_query
        query = [""]
        queryable_entity.each do |key, value|
          add_sql_statement(query, key, value) if queryable?(key)
        end
        query
      end

      def queryable_entity
        params[:any] ? queryable_keys : params
      end

      def add_sql_statement(query, key, value)
        compound_sql_statement(query)
        add_sql_condition(query, key)
        add_sql_predicate(query, value)
      end

      def queryable?(key)
        queryable_keys.include?(key.to_sym)
      end

      def compound_sql_statement(query)
        query[0] += (params[:any] ? " OR " : " AND ") if query[0].length > 0
      end

      def add_sql_condition(query, key)
        query[0] += (fuzzy? ? "#{key} ILIKE ?" : "#{key} = ?")
      end

      def add_sql_predicate(query, value)
        query.push(params[:any] ? build_search_term(params[:any]) : build_search_term(value))
      end

      def build_search_term(value)
        fuzzy? ? "%#{value}%" : value
      end

      def fuzzy?
        params[:fuzzy] != nil && params[:fuzzy].to_s != "false"
      end
    end
  end
end
