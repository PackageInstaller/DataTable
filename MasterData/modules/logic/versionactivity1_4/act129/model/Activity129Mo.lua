-- chunkname: @modules/logic/versionactivity1_4/act129/model/Activity129Mo.lua

module("modules.logic.versionactivity1_4.act129.model.Activity129Mo", package.seeall)

local Activity129Mo = class("Activity129Mo")

function Activity129Mo:ctor(activityId)
	self.activityId = activityId
	self.id = activityId

	self:initCfg()
end

function Activity129Mo:initCfg()
	self.poolDict = {}

	local dict = Activity129Config.instance:getPoolDict(self.activityId)

	if dict then
		for k, v in pairs(dict) do
			self.poolDict[v.poolId] = Activity129PoolMo.New(v)
		end
	end
end

function Activity129Mo:init(info)
	for i = 1, #info.lotteryDetail do
		local lotteryInfo = info.lotteryDetail[i]
		local poolMo = self:getPoolMo(lotteryInfo.poolId)

		if poolMo then
			poolMo:init(lotteryInfo)
		else
			logError(string.format("cant find poolCfg，poolId:%s", lotteryInfo.poolId))
		end
	end
end

function Activity129Mo:onLotterySuccess(info)
	local poolMo = self:getPoolMo(info.poolId)

	if poolMo then
		poolMo:onLotterySuccess(info)
	else
		logError(string.format("cant find poolCfg，poolId:%s", info.poolId))
	end
end

function Activity129Mo:getPoolMo(poolId)
	return self.poolDict[poolId]
end

function Activity129Mo:checkPoolIsEmpty(poolId)
	local mo = self:getPoolMo(poolId)

	return mo and mo:checkPoolIsEmpty()
end

return Activity129Mo
