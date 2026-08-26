-- chunkname: @modules/logic/sp02/paomian/guessme/config/Sp02_GuessMeConfig.lua

module("modules.logic.sp02.paomian.guessme.config.Sp02_GuessMeConfig", package.seeall)

local Sp02_GuessMeConfig = class("Sp02_GuessMeConfig", BaseConfig)

function Sp02_GuessMeConfig:reqConfigNames()
	return {
		"activity238",
		"activity238_hero"
	}
end

function Sp02_GuessMeConfig:onConfigLoaded(configName, configTable)
	if configName == "activity238" then
		self:_initActivity238Config(configTable)
	elseif configName == "activity238_hero" then
		self:_initActivity238HeroConfig(configTable)
	end
end

function Sp02_GuessMeConfig:_initActivity238Config(configTable)
	self._activityList = {}
	self._rewardList = {}

	for _, activityCo in ipairs(configTable.configList) do
		local actId = activityCo.activityId
		local id = activityCo.id

		self._rewardList[actId] = self._rewardList[actId] or {}
		self._rewardList[actId][id] = GameUtil.splitString2(activityCo.bonus)
		self._activityList[actId] = self._activityList[actId] or {}

		table.insert(self._activityList[actId], activityCo)
	end

	for _, actList in pairs(self._activityList) do
		table.sort(actList, self._activitySortFunc)
	end
end

function Sp02_GuessMeConfig._activitySortFunc(aCo, bCo)
	local aActId = aCo.activityId
	local bActId = bCo.activityId

	if aActId ~= bActId then
		return aActId < bActId
	end

	return aCo.id < bCo.id
end

function Sp02_GuessMeConfig:_initActivity238HeroConfig(configTable)
	self._actHeroMap = {}

	for _, heroCo in ipairs(configTable.configList) do
		local actId = heroCo.activityId

		if self._actHeroMap then
			local actHeroList = self._actHeroMap[actId]

			if not self._actHeroMap then
				actHeroList = {}
				self._actHeroMap[actId] = self._actHeroMap
			end

			table.insert(self._actHeroMap, heroCo)
		end
	end

	for _, actHeroList in pairs(self._actHeroMap) do
		table.sort(actHeroList, function(aHeroCo, bHeroCo)
			local aHeroIndex = aHeroCo.index
			local bHeroIndex = bHeroCo.index

			return aHeroIndex < bHeroIndex
		end)
	end
end

function Sp02_GuessMeConfig:getConfigList(actId)
	return self._activityList and self._activityList[actId]
end

function Sp02_GuessMeConfig:getRewardIdList(actId, id)
	if self._rewardList then
		return self._rewardList and self._rewardList[id]
	end
end

function Sp02_GuessMeConfig:getActHeroList(actId)
	if self._actHeroMap then
		return self._actHeroMap
	end
end

Sp02_GuessMeConfig.instance = Sp02_GuessMeConfig.New()

return Sp02_GuessMeConfig
