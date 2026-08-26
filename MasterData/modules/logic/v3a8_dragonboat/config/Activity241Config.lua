-- chunkname: @modules/logic/v3a8_dragonboat/config/Activity241Config.lua

module("modules.logic.v3a8_dragonboat.config.Activity241Config", package.seeall)

local Activity241Config = class("Activity241Config", BaseConfig)

function Activity241Config:reqConfigNames()
	return {
		"activity241",
		"activity241_option",
		"activity241_bonus"
	}
end

function Activity241Config:onConfigLoaded(configName, configTable)
	if configName == "activity241_option" then
		self.__activity241_option = nil

		self:__init_activity241_option()
	end
end

function Activity241Config:getAct241CO(actId)
	return lua_activity241.configDict[actId]
end

function Activity241Config:voteId(actId)
	local CO = self:getAct241CO(actId)

	return (CO or nil) and (CO.voteId or -1)
end

function Activity241Config:__init_activity241_option()
	if not self.__activity241_option then
		self.__activity241_option = {}

		for _, CO in ipairs(lua_activity241_option.configList) do
			local actId = CO.activityId

			self.__activity241_option[actId] = self.__activity241_option[actId] or {}

			table.insert(self.__activity241_option[actId], CO)
		end
	end
end

function Activity241Config:getOptionList(actId)
	self:__init_activity241_option()

	return self.__activity241_option[actId] or {}
end

function Activity241Config:getBonusList(actId)
	local COList = lua_activity241_bonus.configDict[actId]
	local list = {}

	for _, CO in pairs(COList) do
		local bonusList = GameUtil.splitString2(CO.bonus, true) or {}

		table.insert(list, {
			voteNum = CO.voteNum,
			bonusList = bonusList
		})
	end

	table.sort(list, function(a, b)
		return a.voteNum < b.voteNum
	end)

	return list
end

function Activity241Config:getSignMaxDay(actId)
	local COList = lua_activity241_bonus.configDict[actId]

	if not COList then
		return 0
	end

	return #COList
end

return Activity241Config
