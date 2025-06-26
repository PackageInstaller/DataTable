-- chunkname: @IQIGame\\Net\\NetActivityRechargeResponse.lua

function net_activityRecharge.getRewardsResult(code, activityCid, id, rewards)
	ActivityModule.OnGetActivityRechargeRewardsResult(activityCid, id, rewards)
end
