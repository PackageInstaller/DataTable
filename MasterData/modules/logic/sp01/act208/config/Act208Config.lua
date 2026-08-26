-- chunkname: @modules/logic/sp01/act208/config/Act208Config.lua

module("modules.logic.sp01.act208.config.Act208Config", package.seeall)

local Act208Config = class("Act208Config", BaseConfig)

function Act208Config:reqConfigNames()
	return {
		"activity208_bonus"
	}
end

function Act208Config:onInit()
	self._bonusListDic = {}
end

function Act208Config:onConfigLoaded(configName, configTable)
	if configName == "activity208_bonus" then
		self._activityConfig = configTable
	end
end

function Act208Config:getBonusById(activityId, bonusType)
	if self._activityConfig == nil or self._activityConfig.configDict[activityId] == nil then
		return nil
	end

	return self._activityConfig.configDict[activityId][bonusType]
end

function Act208Config:getBonusListById(activityId)
	if not self._activityConfig.configDict[activityId] then
		return nil
	end

	if not self._bonusListDic[activityId] then
		local bonusDic = self._activityConfig.configDict[activityId]
		local list = {}

		for _, bonus in ipairs(bonusDic) do
			table.insert(list, bonus)
		end

		table.sort(list, self.sortBonus)

		self._bonusListDic[activityId] = list
	end

	return self._bonusListDic[activityId]
end

function Act208Config.sortBonus(a, b)
	return a.id >= b.id
end

Act208Config.instance = Act208Config.New()

return Act208Config
