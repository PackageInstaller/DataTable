-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/config/Activity201MaLiAnNaConfig.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.config.Activity201MaLiAnNaConfig", package.seeall)

local Activity201MaLiAnNaConfig = class("Activity201MaLiAnNaConfig", BaseConfig)

Activity201MaLiAnNaConfig._ActivityDataName = "T_lua_MaLiAnNa_ActivityData"

function Activity201MaLiAnNaConfig:reqConfigNames()
	return {
		"activity203_const",
		"activity203_episode",
		"activity203_task",
		"activity203_game",
		"activity203_base",
		"activity203_soldier",
		"activity203_skill",
		"activity203_passiveskill",
		"activity203_dialog",
		"activity203_ai"
	}
end

function Activity201MaLiAnNaConfig:onInit()
	self.triggerList = {}
	self._taskDict = {}
end

function Activity201MaLiAnNaConfig:onConfigLoaded(configName, configTable)
	return
end

function Activity201MaLiAnNaConfig:_initMaLiAnNaLevelData()
	self._maLiAnNaLevelData = {}

	if _G[self._ActivityDataName] == nil then
		return
	end

	for i = 1, #T_lua_MaLiAnNa_ActivityData do
		local data = _G[self._ActivityDataName][i]
		local levelDataMo = MaLiAnNaLaLevelMo.New()

		levelDataMo:init(data)

		self._maLiAnNaLevelData[data.id] = levelDataMo
	end
end

function Activity201MaLiAnNaConfig:getMaLiAnNaLevelData()
	if self._maLiAnNaLevelData == nil then
		self:_initMaLiAnNaLevelData()
	end

	return self._maLiAnNaLevelData
end

function Activity201MaLiAnNaConfig:getMaLiAnNaLevelDataByLevelId(id)
	if self._maLiAnNaLevelData == nil then
		self:_initMaLiAnNaLevelData()
	end

	return self._maLiAnNaLevelData[id]
end

function Activity201MaLiAnNaConfig:getSlotConfigById(id)
	local slotConfig = lua_activity203_base.configDict[id]

	if slotConfig == nil then
		logError("activity203_base 没有找到对应的配置 id = " .. id)
	end

	return slotConfig
end

function Activity201MaLiAnNaConfig:getGameConfigById(id)
	local gameConfig = lua_activity203_game.configDict[id]

	if gameConfig == nil then
		logError("activity203_game 没有找到对应的配置 id = " .. id)
	end

	return gameConfig
end

function Activity201MaLiAnNaConfig:getWinConditionById(id)
	local gameConfig = self:getGameConfigById(id)
	local winConditions = {}

	if gameConfig ~= nil then
		local loseTargetStr = gameConfig.gameTarget

		if not string.nilorempty(loseTargetStr) then
			local allCondition = string.split(loseTargetStr, "|")

			for i = 1, #allCondition do
				local condition = string.splitToNumber(allCondition[i], "#")

				table.insert(winConditions, condition)
			end
		end
	end

	return winConditions
end

function Activity201MaLiAnNaConfig:getLoseConditionById(id)
	local gameConfig = self:getGameConfigById(id)
	local loseConditions = {}

	if gameConfig ~= nil then
		local loseTargetStr = gameConfig.loseTarget

		if not string.nilorempty(loseTargetStr) then
			local allCondition = string.split(loseTargetStr, "|")

			for i = 1, #allCondition do
				local condition = string.splitToNumber(allCondition[i], "#")

				table.insert(loseConditions, condition)
			end
		end
	end

	return loseConditions
end

function Activity201MaLiAnNaConfig:getSoldierById(id)
	local soliderConfig = lua_activity203_soldier.configDict[id]

	if soliderConfig == nil then
		logError("activity203_soldier 没有找到对应的配置 id = " .. id)
	end

	return soliderConfig
end

function Activity201MaLiAnNaConfig:getConstValueNumber(id)
	local activityId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local activityConstConfig = lua_activity203_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity203_const 没有找到对应的配置 activityId = " .. activityId)

		return nil
	end

	local constConfig = activityConstConfig[id]

	if constConfig == nil then
		logError("activity203_const 没有找到对应的配置 id = " .. id)

		return nil
	end

	return tonumber(constConfig.value)
end

function Activity201MaLiAnNaConfig:getConstValue(id)
	local activityId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	local activityConstConfig = lua_activity203_const.configDict[activityId]

	if activityConstConfig == nil then
		logError("activity203_const 没有找到对应的配置 id = " .. id)
	end

	local constConfig = activityConstConfig[id]

	return constConfig.value, constConfig.value2
end

function Activity201MaLiAnNaConfig:getAllHeroConfig()
	local heroConfig = {}

	for i = 1, #lua_activity203_soldier.configList do
		local data = lua_activity203_soldier.configList[i]

		if data.type == Activity201MaLiAnNaEnum.SoldierType.hero then
			table.insert(heroConfig, data)
		end
	end

	return heroConfig
end

function Activity201MaLiAnNaConfig:getAllSlot()
	return lua_activity203_base.configList
end

function Activity201MaLiAnNaConfig:getActiveSkillConfig(configId)
	return lua_activity203_skill.configDict[configId]
end

function Activity201MaLiAnNaConfig:getPassiveSkillConfig(configId)
	return lua_activity203_passiveskill.configDict[configId]
end

function Activity201MaLiAnNaConfig:_initSlotConstValue()
	if self._slotConstList == nil then
		self._slotConstList = {}
	end

	local startIndex = 3
	local endIndex = 10

	for i = startIndex, endIndex do
		local _, str = self:getConstValue(i)

		if not string.nilorempty(str) then
			local constValue = string.split(str, "|")
			local key = constValue[1]
			local value = constValue[2]
			local allValueList = string.splitToNumber(value, "#")

			if #allValueList == 4 then
				self._slotConstList[key] = allValueList
			end
		end
	end
end

function Activity201MaLiAnNaConfig:getSlotConstValue(slotConfigId)
	if self._slotConstList == nil then
		self:_initSlotConstValue()
	end

	local slotConfig = self:getSlotConfigById(slotConfigId)

	if slotConfig == nil then
		logError("activity203_base 没有找到对应的配置 id = " .. slotConfigId)

		return 0, 0, 0, 0
	end

	local key = slotConfig.picture
	local value = self._slotConstList[key]
	local dragSureRange = Activity201MaLiAnNaEnum.defaultDragRange
	local hideRange = Activity201MaLiAnNaEnum.defaultHideRange
	local offsetX = Activity201MaLiAnNaEnum.defaultOffsetX
	local offsetY = Activity201MaLiAnNaEnum.defaultOffsetY

	if value ~= nil then
		dragSureRange = value[1] or Activity201MaLiAnNaEnum.defaultDragRange
		hideRange = value[2] or Activity201MaLiAnNaEnum.defaultHideRange
		offsetX = value[3] or Activity201MaLiAnNaEnum.defaultOffsetX
		offsetY = value[4] or Activity201MaLiAnNaEnum.defaultOffsetY
	end

	return dragSureRange, hideRange, offsetX, offsetY
end

function Activity201MaLiAnNaConfig:getEpisodeCoList(activityId)
	if not self._episodeDict then
		self._episodeDict = {}

		for _, v in ipairs(lua_activity203_episode.configList) do
			self._episodeDict[v.activityId] = self._episodeDict[v.activityId] or {}

			table.insert(self._episodeDict[v.activityId], v)
		end
	end

	return self._episodeDict[activityId] or {}
end

function Activity201MaLiAnNaConfig:getLevelDialogConfig(gameId)
	local levelDialog = lua_activity203_dialog.configDict[gameId]

	if levelDialog == nil then
		levelDialog = {}
	end

	return levelDialog
end

function Activity201MaLiAnNaConfig:getTriggerList(trigger)
	if self.triggerList == nil then
		self.triggerList = {}
	end

	if trigger then
		self.triggerList[trigger] = self.triggerList[trigger] or string.splitToNumber(trigger, "#")

		return self.triggerList[trigger]
	end

	return nil
end

function Activity201MaLiAnNaConfig:getEpisodeCo(activityId, episodeId)
	local episodeCos = self:getEpisodeCoList(activityId)

	for _, v in pairs(episodeCos) do
		if v.episodeId == episodeId then
			return v
		end
	end
end

function Activity201MaLiAnNaConfig:getTaskByActId(activityId)
	local list = self._taskDict[activityId]

	if not list then
		list = {}

		for _, co in ipairs(lua_activity203_task.configList) do
			if co.activityId == activityId then
				table.insert(list, co)
			end
		end

		self._taskDict[activityId] = list
	end

	return list
end

function Activity201MaLiAnNaConfig:getStoryBefore(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyBefore
end

function Activity201MaLiAnNaConfig:getStoryClear(actId, episodeId)
	local cfg = self:getEpisodeCo(actId, episodeId)

	return cfg and cfg.storyClear
end

Activity201MaLiAnNaConfig.instance = Activity201MaLiAnNaConfig.New()

return Activity201MaLiAnNaConfig
