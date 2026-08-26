-- chunkname: @modules/logic/versionactivity1_4/act129/config/Activity129Config.lua

module("modules.logic.versionactivity1_4.act129.config.Activity129Config", package.seeall)

local Activity129Config = class("Activity129Config", BaseConfig)

function Activity129Config:ctor()
	self.poolDict = {}
	self.constDict = {}
	self.goodsDict = {}
end

function Activity129Config:reqConfigNames()
	return {
		"activity129_pool",
		"activity129_const",
		"activity129_goods"
	}
end

function Activity129Config:onConfigLoaded(configName, configTable)
	local funcName = string.format("on%sConfigLoaded", configName)
	local func = self[funcName]

	if func then
		func(self, configName, configTable)
	end
end

function Activity129Config:onactivity129_poolConfigLoaded(configName, configTable)
	self.poolDict = configTable.configDict
end

function Activity129Config:onactivity129_constConfigLoaded(configName, configTable)
	self.constDict = configTable.configDict
end

function Activity129Config:onactivity129_goodsConfigLoaded(configName, configTable)
	self.goodsDict = configTable.configDict
end

function Activity129Config:getConstValue1(activityId, constId)
	local dict = self.constDict[activityId]

	if dict then
		::label_7_0::

		local var_7_0 = dict[constId]

		if dict[constId] then
			local value1 = dict[constId].value1

			if not value1 then
				logError(string.format("can not find constvalue! activityId:%s constId:%s", activityId, constId))
			end

			return value1
		end
	end
end

function Activity129Config:getConstValue2(activityId, constId)
	local dict = self.constDict[activityId]

	if dict then
		::label_8_0::

		local var_8_0 = dict[constId]

		if dict[constId] then
			local value2 = dict[constId].value2

			if not value2 then
				logError(string.format("can not find constvalue! activityId:%s constId:%s", activityId, constId))
			end

			return value2
		end
	end
end

function Activity129Config:getPoolConfig(activityId, poolId)
	local actDict = self.poolDict[activityId]
	local poolCfg = actDict and actDict[poolId]

	if not poolCfg then
		logError(string.format("can not find pool config! activityId:%s poolId:%s", activityId, poolId))
	end

	return poolCfg
end

function Activity129Config:getPoolDict(activityId)
	return self.poolDict[activityId]
end

function Activity129Config:getGoodsDict(poolId)
	return self.goodsDict[poolId]
end

function Activity129Config:getRewardConfig(poolId, rare, rewardType, rewardId)
	if not self.rewardDict then
		self.rewardDict = {}

		for k_poolId, vx in pairs(self.goodsDict) do
			self.rewardDict[k_poolId] = {}

			for k_rare, vy in pairs(vx) do
				self.rewardDict[k_poolId][k_rare] = {}

				local rewards = GameUtil.splitString2(vy.goodsId, true)

				if rewards then
					for _, reward in ipairs(rewards) do
						self.rewardDict[k_poolId][k_rare][reward[1]] = self.rewardDict[k_poolId][k_rare][reward[1]] or {}
						self.rewardDict[k_poolId][k_rare][reward[1]][reward[2]] = reward
					end
				end
			end
		end
	end

	if not self.rewardDict[poolId] then
		return
	end

	if not self.rewardDict[poolId][rare] then
		return
	end

	if not self.rewardDict[poolId][rare][rewardType] then
		return
	end

	return self.rewardDict[poolId][rare][rewardType][rewardId]
end

Activity129Config.instance = Activity129Config.New()

return Activity129Config
