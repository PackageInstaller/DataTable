-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wheellotterypool/config/WheelLotteryPoolConfig.lua

module("logic.extensions.wheellotterypool.config.WheelLotteryPoolConfig", package.seeall)

local WheelLotteryPoolConfig = class("WheelLotteryPoolConfig", BaseConfig)

function WheelLotteryPoolConfig:onInit()
	WheelLotteryPoolConfig.super.onInit(self)
end

function WheelLotteryPoolConfig:getNames()
	return {
		"wheel_lottery_pool",
		"wheel_lottery_tier_plan",
		"wheel_lottery_prize_plan",
		"wheel_lottery_pool_common"
	}
end

function WheelLotteryPoolConfig:handleConfig(name, content)
	if name == "wheel_lottery_pool" then
		self.wheel_lottery_pool = content
	elseif name == "wheel_lottery_tier_plan" then
		self.wheel_lottery_tier_plan = content
	elseif name == "wheel_lottery_prize_plan" then
		self.wheel_lottery_prize_plan = content
	elseif name == "wheel_lottery_pool_common" then
		self.wheel_lottery_pool_common = content
	end
end

function WheelLotteryPoolConfig:getWheelLotteryPoolData(activityId)
	return self.wheel_lottery_pool[activityId]
end

function WheelLotteryPoolConfig:getWheelLotteryTierPlanData(tierPlanId)
	return self.wheel_lottery_tier_plan[tierPlanId]
end

function WheelLotteryPoolConfig:getWheelLotteryPrizePlanData(prizePlanId)
	return self.wheel_lottery_prize_plan[prizePlanId]
end

function WheelLotteryPoolConfig:getCommonData(activityId)
	if not self.wheel_lottery_pool[activityId].comPlanId then
		return self.wheel_lottery_pool_common[self.wheel_lottery_pool[activityId].comPlanId]
	end
end

function WheelLotteryPoolConfig:getPrizePlanId(activityId, poolId, tierId)
	if self.wheel_lottery_pool[activityId][poolId] then
		local tierPlanId = self.wheel_lottery_pool[activityId][poolId].tierPlanId

		if self.wheel_lottery_tier_plan[tierPlanId] then
			return self.wheel_lottery_tier_plan[tierPlanId][tierId].prizePlanId or -1
		end
	end

	return -1
end

function WheelLotteryPoolConfig:getTierNum(activityId, poolId)
	if self.wheel_lottery_pool[activityId][poolId] then
		local tierPlanId = self.wheel_lottery_pool[activityId][poolId].tierPlanId

		if self.wheel_lottery_tier_plan[tierPlanId] then
			return #self.wheel_lottery_tier_plan[tierPlanId]
		end
	end

	return -1
end

function WheelLotteryPoolConfig:isGainAllId(activityId, poolId, tierId, gainPrizeId)
	local tierPlanId = self.wheel_lottery_pool[activityId][poolId].tierPlanId
	local prizePlanId = self.wheel_lottery_tier_plan[tierPlanId][tierId].prizePlanId

	return self.wheel_lottery_prize_plan[prizePlanId][gainPrizeId].gainAll
end

function WheelLotteryPoolConfig:isInfinitePool(activityId, poolId)
	return self.wheel_lottery_pool[activityId][poolId].infinite
end

function WheelLotteryPoolConfig:getPoolName(activityId, poolId)
	if self.wheel_lottery_pool[activityId][poolId] then
		return self.wheel_lottery_pool[activityId][poolId].poolName or ""
	end
end

WheelLotteryPoolConfig.instance = WheelLotteryPoolConfig.New()

return WheelLotteryPoolConfig
