-- chunkname: @modules/logic/versionactivity2_8/act197/config/Activity197Config.lua

module("modules.logic.versionactivity2_8.act197.config.Activity197Config", package.seeall)

local Activity197Config = class("Activity197Config", BaseConfig)

function Activity197Config:reqConfigNames()
	return {
		"activity197",
		"activity197_pool",
		"actvity197_stage"
	}
end

function Activity197Config:onInit()
	self._poolList = {}
	self._poolDict = {}
	self._stageConfig = {}
	self._rummageConsume = 1
	self._exploreConsume = 1
end

function Activity197Config:onConfigLoaded(configName, configTable)
	if configName == "activity197_pool" then
		for _, poolCo in ipairs(configTable.configList) do
			self._poolDict[poolCo.poolId] = self._poolDict[poolCo.poolId] or {}

			table.insert(self._poolDict[poolCo.poolId], poolCo)
		end

		for key, value in pairs(self._poolDict) do
			table.insert(self._poolList, key)
		end
	elseif configName == "activity197" then
		local co = configTable.configList[1]
		local rummageConsume = string.split(co.rummageConsume, "#")
		local exploreConsume = string.split(co.exploreConsume, "#")
		local exploreGetCount = string.split(co.exploreItem, "#")

		self._rummageConsume = rummageConsume[3]
		self._exploreConsume = exploreConsume[3]
		self._exploreGetCount = exploreGetCount[3]
	elseif configName == "actvity197_stage" then
		self._stageConfig = configTable
	end
end

function Activity197Config:getPoolList()
	return self._poolList
end

function Activity197Config:getPoolCount()
	return #self._poolList
end

function Activity197Config:getPoolConfigById(poolId)
	return self._poolDict[poolId]
end

function Activity197Config:getPoolRewardCount(poolId)
	return #self._poolDict[poolId]
end

function Activity197Config:getRummageConsume()
	return self._rummageConsume
end

function Activity197Config:getExploreConsume()
	return self._exploreConsume
end

function Activity197Config:getExploreGetCount()
	return self._exploreGetCount
end

function Activity197Config:getStageConfig(actId, stage)
	local dict = self._stageConfig.configDict[actId]

	return dict and dict[stage]
end

Activity197Config.instance = Activity197Config.New()

return Activity197Config
