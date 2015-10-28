class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount UsersApi => '/users'
  mount CheckinsApi => '/checkins'
  mount LocationsApi => '/locations'
  mount RewardsApi => '/rewards'
  mount RedemptionsApi => '/redemptions'

  add_swagger_documentation
end
