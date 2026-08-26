-- chunkname: @modules/logic/versionactivity1_2/trade/config/Activity117Config.lua

module("modules.logic.versionactivity1_2.trade.config.Activity117Config", package.seeall)

local Activity117Config = class("Activity117Config", BaseConfig)

function Activity117Config:ctor()
	self._actAllBonus = nil
	self._act117Bonus = nil
	self._act117Order = nil
	self._act117Talk = nil
end

function Activity117Config:reqConfigNames()
	return {
		"activity117_bonus",
		"activity117_order",
		"activity117_talk"
	}
end

function Activity117Config:onConfigLoaded(configName, configTable)
	if configName == "activity117_bonus" then
		self._act117Bonus = configTable
	elseif configName == "activity117_order" then
		self._act117Order = configTable
	elseif configName == "activity117_talk" then
		self._act117Talk = configTable
	end
end

function Activity117Config:getOrderConfig(actId, orderId)
	if self._act117Order.configDict[actId] then
		return self._act117Order.configDict[actId][orderId]
	end

	return nil
end

function Activity117Config:getAllBonusConfig(actId)
	self._actAllBonus = self._actAllBonus or {}

	if not self._actAllBonus[actId] then
		self._actAllBonus[actId] = {}

		local targetDict = self._act117Bonus.configDict[actId]

		for k, v in pairs(targetDict) do
			table.insert(self._actAllBonus[actId], v)
		end
	end

	return self._actAllBonus[actId]
end

function Activity117Config:getBonusConfig(actId, id)
	local targetDict = self._act117Bonus.configDict[actId]

	if not targetDict then
		return
	end

	return targetDict[id]
end

function Activity117Config:getTotalActivityDays(actId)
	local cfgList = self._act117Order.configDict[actId]
	local totalDay = 0

	for _, cfg in pairs(cfgList) do
		totalDay = math.max(cfg.openDay, totalDay)
	end

	return totalDay
end

function Activity117Config:getTalkCo(actId, talkId)
	if self._act117Talk.configDict[actId] then
		return self._act117Talk.configDict[actId][talkId]
	end

	return nil
end

Activity117Config.instance = Activity117Config.New()

return Activity117Config
