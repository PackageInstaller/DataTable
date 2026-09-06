-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/config/SuperGhostLotteryConfig.lua

module("logic.extensions.superghostlottery.config.SuperGhostLotteryConfig", package.seeall)

local SuperGhostLotteryConfig = class("SuperGhostLotteryConfig", BaseConfig)

function SuperGhostLotteryConfig:onInit()
	SuperGhostLotteryConfig.super.onInit(self)
end

function SuperGhostLotteryConfig:getNames()
	return {
		"super_ghost_lottery",
		"super_ghost_lottery_prize"
	}
end

function SuperGhostLotteryConfig:handleConfig(name, content)
	if name == "super_ghost_lottery" then
		self._super_ghost_lottery = content

		self:handleActivityConfig()
	elseif name == "super_ghost_lottery_prize" then
		self._super_ghost_lottery_prize = content

		self:handlePrizeConfig()
	end
end

function SuperGhostLotteryConfig:getActivityCfg(activityId)
	return self._super_ghost_lottery[activityId]
end

function SuperGhostLotteryConfig:getActivityShowList()
	return self._showActivieyCfgList
end

function SuperGhostLotteryConfig:getPrizeCfg(prizePlanId, prizeId)
	if self._super_ghost_lottery_prize[prizePlanId] then
		return self._super_ghost_lottery_prize[prizePlanId][prizeId]
	end

	return nil
end

function SuperGhostLotteryConfig:getPrizeCfgByRound(prizePlanId, round)
	if self._prizeCfg[prizePlanId] then
		return self._prizeCfg[prizePlanId][round]
	end

	return nil
end

function SuperGhostLotteryConfig:handleActivityConfig()
	self._showActivieyCfgList = {}

	for i, v in ipairs(self._super_ghost_lottery.dataList) do
		if v.isShow == true then
			table.insert(self._showActivieyCfgList, v)
		end
	end
end

function SuperGhostLotteryConfig:handlePrizeConfig()
	self._prizeCfg = {}

	for i, v in ipairs(self._super_ghost_lottery_prize.dataList) do
		self._prizeCfg[v.prizePlanId] = self._prizeCfg[v.prizePlanId] or {}
		self._prizeCfg[v.prizePlanId][v.round] = self._prizeCfg[v.prizePlanId][v.round] or {}
		self._prizeCfg[v.prizePlanId][v.round][v.prizeType] = self._prizeCfg[v.prizePlanId][v.round][v.prizeType] or {}

		table.insert(self._prizeCfg[v.prizePlanId][v.round][v.prizeType], v)
	end
end

function SuperGhostLotteryConfig:getMaxRound(planId)
	if self._prizeCfg[planId] then
		return #self._prizeCfg[planId]
	end

	return 0
end

SuperGhostLotteryConfig.instance = SuperGhostLotteryConfig.New()

return SuperGhostLotteryConfig
