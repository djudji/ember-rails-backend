class ApplicationController < ActionController::API
  def relationship_params
    associations = {}
    params[:data][:relationships].each do |key, value|
      associations[key.to_sym] =
        if value[:data].is_a? Array
          # then this is a has_many
          value[:data].map { |data| find_related_object(data) }
        else
          # this is has_one
          find_related_object(value[:data])
        end
    end
    associations
  end

  private

  def find_related_object(data)
    data[:type].titlecase.singularize.constantize.find(data[:id])
  end
end
