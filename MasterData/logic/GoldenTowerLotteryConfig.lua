-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldentowerlottery/config/GoldenTowerLotteryConfig.lua

module("logic.extensions.goldentowerlottery.config.GoldenTowerLotteryConfig", package.seeall)

local GoldenTowerLotteryConfig = class("GoldenTowerLotteryConfig", BaseConfig)

function GoldenTowerLotteryConfig:getNames()
	return {
		"golden_tower_lottery_pool",
		"golden_tower_lottery_tier_plan",
		"golden_tower_lottery_prize_plan",
		"golden_tower_lottery_common"
	}
end

function GoldenTowerLotteryConfig:handleConfig(name, content)
	if name == "golden_tower_lottery_pool" then
		self._golden_tower_lottery_pool = content
	elseif name == "golden_tower_lottery_tier_plan" then
		self._golden_tower_lottery_tier_plan = content
	elseif name == "golden_tower_lottery_prize_plan" then
		self._golden_tower_lottery_prize_plan = content
	elseif name == "golden_tower_lottery_common" then
		self._golden_tower_lottery_common = content
	end
end

function GoldenTowerLotteryConfig:getPoolCfgs(activityId)
	return self._golden_tower_lottery_pool[activityId]
end

function GoldenTowerLotteryConfig:getPoolCfg(activityId, poolId)
	return self._golden_tower_lottery_pool[activityId] and self._golden_tower_lottery_pool[activityId][poolId]
end

function GoldenTowerLotteryConfig:getTierPlanCfgs(tierPlanId)
	return self._golden_tower_lottery_tier_plan[tierPlanId]
end

function GoldenTowerLotteryConfig:getTierPlanCfg(tierPlanId, tier)
	return self._golden_tower_lottery_tier_plan[tierPlanId] and self._golden_tower_lottery_tier_plan[tierPlanId][tier]
end

function GoldenTowerLotteryConfig:getPrizePlanCfgs(prizePlanId)
	return self._golden_tower_lottery_prize_plan[prizePlanId]
end

function GoldenTowerLotteryConfig:getPrizePlanCfg(prizePlanId, prizeId)
	return self._golden_tower_lottery_prize_plan[prizePlanId] and self._golden_tower_lottery_prize_plan[prizePlanId][prizeId]
end

function GoldenTowerLotteryConfig:getCommonCfg(activityId)
	return self._golden_tower_lottery_common[activityId]
end

GoldenTowerLotteryConfig.instance = GoldenTowerLotteryConfig.New()

return GoldenTowerLotteryConfig
