class RewardsApi < Grape::API
  desc 'Get a list of rewards'
  params do
    optional :ids, type: Array, desc: 'Array of reward ids'
  end
  get do
    rewards = params[:ids] ? Reward.where(id: params[:ids]) : Reward.all
    represent rewards, with: RewardRepresenter
  end

  desc 'Create an reward'
  params do
  end

  post do
    reward = Reward.create!(permitted_params)
    represent reward, with: RewardRepresenter
  end

  params do
    requires :id, desc: 'ID of the reward'
  end
  route_param :id do
    desc 'Get an reward'
    get do
      reward = Reward.find(params[:id])
      represent reward, with: RewardRepresenter
    end

    desc 'Update an reward'
    params do
    end
    put do
      # fetch reward record and update attributes.  exceptions caught in app.rb
      reward = Reward.find(params[:id])
      reward.update_attributes!(permitted_params)
      represent reward, with: RewardRepresenter
    end
  end
end
