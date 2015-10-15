class CheckinRepresenter < Napa::Representer
  property :id, type: String
  property :location_id
  property :user_id
  property :points
end
