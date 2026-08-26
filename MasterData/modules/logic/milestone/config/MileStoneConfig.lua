-- chunkname: @modules/logic/milestone/config/MileStoneConfig.lua

module("modules.logic.milestone.config.MileStoneConfig", package.seeall)

local MileStoneConfig = class("MileStoneConfig", BaseConfig)

function MileStoneConfig:ctor()
	self._MileStoneConfig = nil
end

function MileStoneConfig:reqConfigNames()
	return {
		"milestone",
		"milestone_bonus"
	}
end

function MileStoneConfig:onConfigLoaded(configName, configTable)
	if configName == "milestone" then
		self._mileStoneConfig = configTable
	elseif configName == "milestone_bonus" then
		self._mileStoneBonusConfig = configTable
	end
end

function MileStoneConfig:getMileStoneConfig(id)
	return self._mileStoneConfig.configDict[id]
end

function MileStoneConfig:getMileStoneConfigByActId(actId)
	for _, config in pairs(self._mileStoneConfig.configList) do
		if config.activityId == actId then
			return config
		end
	end

	return nil
end

function MileStoneConfig:getMileStoneConfigByType(type)
	for _, config in pairs(self._mileStoneConfig.configList) do
		if config.type == type then
			return config
		end
	end

	return nil
end

function MileStoneConfig:getBonusList(id)
	self._bonusList = self._bonusList or {}

	if not self._bonusList[id] then
		self._bonusList[id] = {}

		for _, config in pairs(self._mileStoneBonusConfig.configList) do
			if config.milestoneId == id then
				local mo = MileStoneListMO.New()

				mo:init(config.bonusId, config)
				table.insert(self._bonusList[id], mo)
			end
		end

		table.sort(self._bonusList[id], SortUtil.keyLower("id"))
	end

	return self._bonusList[id]
end

function MileStoneConfig:getBonusConfig(mileStoneId, bonusId)
	local dict = self._mileStoneBonusConfig.configDict[mileStoneId]

	return dict and dict[bonusId]
end

MileStoneConfig.instance = MileStoneConfig.New()

return MileStoneConfig
