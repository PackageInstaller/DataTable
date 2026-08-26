-- chunkname: @modules/logic/sp02/paomian/marcus/config/Sp02_MarcusConfig.lua

module("modules.logic.sp02.paomian.marcus.config.Sp02_MarcusConfig", package.seeall)

local Sp02_MarcusConfig = class("Sp02_MarcusConfig", BaseConfig)

function Sp02_MarcusConfig:reqConfigNames()
	return {
		"activity239"
	}
end

function Sp02_MarcusConfig:onConfigLoaded(configName, configTable)
	if configName == "activity239" then
		self:_initActivity239Config(configTable)
	end
end

function Sp02_MarcusConfig:_initActivity239Config(configTable)
	self._bonusList = {}
	self._rewardList = {}

	for _, activityCo in ipairs(configTable.configList) do
		local actId = activityCo.activityId
		local id = activityCo.id

		self._rewardList[actId] = self._rewardList[actId] or {}
		self._rewardList[actId][id] = GameUtil.splitString2(activityCo.bonus)

		self:_addBonusConfig2List(activityCo)
	end
end

function Sp02_MarcusConfig:_addBonusConfig2List(bonusCo)
	local actId = bonusCo and bonusCo.activityId

	self._bonusList[actId] = self._bonusList[actId] or {}

	if bonusCo then
		if not bonusCo.preId then
			local preId = 0

			if not preId or preId == 0 then
				table.insert(self._bonusList[actId], 1, bonusCo)

				return
			end

			for i, saveBonusCo in ipairs(self._bonusList[actId]) do
				if saveBonusCo.activityId == actId and saveBonusCo.preId == bonusCo.id then
					table.insert(self._bonusList[actId], i, bonusCo)

					return
				end
			end

			table.insert(self._bonusList[actId], bonusCo)
		end
	end
end

function Sp02_MarcusConfig:getBonusList(actId)
	return self._bonusList and self._bonusList[actId]
end

function Sp02_MarcusConfig:getBonusConfig(actId, id)
	local bonusList = self:getBonusList(actId)

	return bonusList and bonusList[id]
end

function Sp02_MarcusConfig:getRewardList(actId, id)
	if self._rewardList then
		return self._rewardList and self._rewardList[id]
	end
end

function Sp02_MarcusConfig:getPreBonusId(actId, id)
	local bonusCo = self:getBonusConfig(actId, id)

	return bonusCo and bonusCo.preId
end

function Sp02_MarcusConfig:getBonusOpenTime(actId, id)
	if not self._openTimeMap then
		self._openTimeMap = {}

		for _, activityCo in ipairs(lua_activity239.configList) do
			local actId = activityCo.activityId
			local index = activityCo.id

			self._openTimeMap[actId] = self._openTimeMap[actId] or {}
			self._openTimeMap[actId][index] = TimeUtil.stringToTimestamp(activityCo.openTime)
		end
	end

	if self._openTimeMap then
		local actOpenTimeMap = self._openTimeMap[actId]

		return (actOpenTimeMap or nil) and (actOpenTimeMap[id] or 0)
	end
end

Sp02_MarcusConfig.instance = Sp02_MarcusConfig.New()

return Sp02_MarcusConfig
