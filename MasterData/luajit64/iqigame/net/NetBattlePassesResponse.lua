-- chunkname: @IQIGame\\Net\\NetBattlePassesResponse.lua

function net_battlePasses.getRewardsResult(code)
	PassCheckModule.ReqGetRewardResult()
end

function net_battlePasses.getLastSeasonRewardsResult(code)
	PassCheckModule.ReqGetLastSeasonRewardsResult()
end
