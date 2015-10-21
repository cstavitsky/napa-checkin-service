class RedemptionsApi < Grape::API
  
  desc 'Redeem points for a reward'
  params do
    optional :user_id, type: Integer, desc: 'The User checking in'
    optional :location_id, type: Integer, desc: 'The Location being checked into'
    optional :reward_id, type: Integer, desc: 'The Reward being redeemed'
  end

  post do
    reward = Reward.find(permitted_params[:reward_id])
    checkin = Checkin.redeem_points(reward, permitted_params[:user_id], permitted_params[:location_id])
    represent checkin, with: CheckinRepresenter
  end

end
