class LocationsApi < Grape::API
  desc 'Get a list of locations'
  params do
    optional :ids, type: Array, desc: 'Array of location ids'
  end
  get do
    locations = params[:ids] ? Location.where(id: params[:ids]) : Location.all
    represent locations, with: LocationRepresenter
  end

  desc 'Create an location'
  params do
  end

  post do
    location = Location.create!(permitted_params)
    represent location, with: LocationRepresenter
  end

  params do
    requires :id, desc: 'ID of the location'
  end
  route_param :id do
    desc 'Get an location'
    get do
      location = Location.find(params[:id])
      represent location, with: LocationRepresenter
    end

    desc 'Update an location'
    params do
    end
    put do
      # fetch location record and update attributes.  exceptions caught in app.rb
      location = Location.find(params[:id])
      location.update_attributes!(permitted_params)
      represent location, with: LocationRepresenter
    end
  end
end
