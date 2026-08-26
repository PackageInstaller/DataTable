-- chunkname: @modules/logic/commandstation/config/CommandStationConfig.lua

module("modules.logic.commandstation.config.CommandStationConfig", package.seeall)

local CommandStationConfig = class("CommandStationConfig", BaseConfig)

function CommandStationConfig:reqConfigNames()
	return {
		"copost_character_event",
		"copost_version",
		"copost_time_axis",
		"copost_time_point",
		"copost_time_point_event",
		"copost_event",
		"copost_event_text",
		"copost_version_task",
		"copost_catch_task",
		"copost_bonus",
		"copost_npc",
		"copost_npc_text",
		"copost_password_paper",
		"copost_character",
		"copost_const",
		"copost_scene",
		"copost_decoration",
		"copost_decoration_coordinates",
		"copost_character_chain",
		"copost_character_state",
		"copost_plot_map",
		"copost_character_camp"
	}
end

function CommandStationConfig:onInit()
	return
end

function CommandStationConfig:onConfigLoaded(configName, configTable)
	if configName == "copost_version" then
		self:_initVersion()
	elseif configName == "copost_time_axis" then
		self:_initTimeAxis()
	elseif configName == "copost_time_point" then
		self:_initTimePoint()
	elseif configName == "copost_time_point_event" then
		self:_initTimePointEvent()
	elseif configName == "copost_event" then
		self:_initEvent()
	elseif configName == "copost_character_event" then
		self:_initCharacterEvent()
	elseif configName == "copost_event_text" then
		self:_initEventText()
	elseif configName == "copost_version_task" then
		self:_initVersionTask()
	elseif configName == "copost_catch_task" then
		self:_initCatchTask()
	elseif configName == "copost_bonus" then
		self:_initBonus()
	elseif configName == "copost_npc" then
		self:_initNpc()
	elseif configName == "copost_npc_text" then
		self:_initNpcText()
	elseif configName == "copost_password_paper" then
		self:_initPasswordPaper()
	elseif configName == "copost_character_chain" then
		self:_initCharacterChain()
	elseif configName == "copost_character_state" then
		self:_initCharacterState()
	elseif configName == "copost_character_camp" then
		self:_initCharacterCamp()
	end
end

function CommandStationConfig:_initCharacterCamp()
	self._campLocationMap = {}

	for i, v in ipairs(lua_copost_character_camp.configList) do
		if v.location > 0 then
			self._campLocationMap[v.location] = v.id
		end
	end
end

function CommandStationConfig:_initVersion()
	local len = #lua_copost_version.configList
	local config = lua_copost_version.configList[len]

	self._maxVersionId = config.versionId
end

function CommandStationConfig:_initTimeAxis()
	self:_initVersionTimeline()
	self:_initTimeGroup()
end

function CommandStationConfig:_initVersionTimeline()
	self._verionTimeline = {}
	self._timePointSceneMap = {}

	local allVersion = {}

	for i, v in ipairs(lua_copost_time_axis.configList) do
		self._verionTimeline[v.versionId] = self._verionTimeline[v.versionId] or {}

		table.insert(self._verionTimeline[v.versionId], v)

		allVersion[v.id] = allVersion[v.id] or {}

		local list = allVersion[v.id]

		for _, timeId in ipairs(v.timeId) do
			table.insert(list, timeId)

			self._timePointSceneMap[timeId] = v.sceneId
		end
	end

	local allVersionList = {}

	for k, v in pairs(allVersion) do
		table.insert(allVersionList, {
			id = k,
			timeId = v
		})
	end

	self._verionTimeline[CommandStationEnum.AllVersion] = allVersionList

	for k, v in pairs(self._verionTimeline) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end
end

function CommandStationConfig:_initTimeGroup()
	self._timeGroup = {}

	for i, v in ipairs(lua_copost_time_axis.configList) do
		for _, timeId in ipairs(v.timeId) do
			self._timeGroup[timeId] = v
		end
	end
end

function CommandStationConfig:_initTimePoint()
	return
end

function CommandStationConfig:_initTimePointEvent()
	self._timeIdUnlockEventMap = {}
	self._unlockEventToTimeIdMap = {}
	self._episodeIdTimeIdMap = {}
	self._characterEventTime = {}
	self._characterTimeGroup = {}
	self._normalEventTime = {}

	local characterTimeGroup = {}

	local function initTimeGroupByCharId(chaId, time_point_event)
		if chaId ~= 0 then
			characterTimeGroup[chaId] = characterTimeGroup[chaId] or {}

			local timeGroup = self._timeGroup[time_point_event.id]

			if timeGroup then
				local list = characterTimeGroup[chaId]

				if not tabletool.indexOf(list, timeGroup) then
					table.insert(list, timeGroup)
				end
			else
				logError(string.format("CommandStationConfig _initTimePointEvent timeId %d not exist in copost_time_axis", time_point_event.id))
			end
		end
	end

	for i, v in ipairs(lua_copost_time_point_event.configList) do
		self._episodeIdTimeIdMap[v.fightId] = self._episodeIdTimeIdMap[v.fightId] or v.id

		for _, eventId in ipairs(v.eventId) do
			self._normalEventTime[eventId] = v
		end

		for _, characterEventId in ipairs(v.chaEventId) do
			self._characterEventTime[characterEventId] = v

			local characterEventConfig = lua_copost_character_event.configDict[characterEventId]

			if characterEventConfig then
				initTimeGroupByCharId(characterEventConfig.chaId, v)

				for _, chaId in ipairs(characterEventConfig.chasId) do
					initTimeGroupByCharId(chaId, v)
				end

				if characterEventConfig.chaId ~= 0 and #characterEventConfig.chasId > 0 then
					logError(string.format("CommandStationConfig _initTimePointEvent error characterEventId %d chaId %d chasId %d", characterEventId, characterEventConfig.chaId, #characterEventConfig.chasId))
				end
			else
				logError(string.format("CommandStationConfig _initTimePointEvent characterEventId %d not exist", characterEventId))
			end
		end

		if #v.frontEventId > 0 then
			local frontEventIdList = v.frontEventId

			self._timeIdUnlockEventMap[v.id] = frontEventIdList

			for _, eventId in ipairs(frontEventIdList) do
				self._unlockEventToTimeIdMap[eventId] = v.id
			end
		end
	end

	for k, v in pairs(characterTimeGroup) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	for chaId, list in pairs(characterTimeGroup) do
		self._characterTimeGroup[chaId] = {}

		for i, v in pairs(list) do
			local timeIdList = {}

			for _, timeId in ipairs(v.timeId) do
				local characterEventList = self:getCharacterEventList(timeId)

				for _, characterEventId in ipairs(characterEventList) do
					if self:eventContainCharacterId(characterEventId, chaId) and not tabletool.indexOf(timeIdList, timeId) then
						table.insert(timeIdList, timeId)
					end
				end
			end

			self._characterTimeGroup[chaId][i] = {
				versionId = v.versionId,
				id = v.id,
				timeId = timeIdList
			}
		end
	end
end

function CommandStationConfig:_checkEventFrontDependency(t, configDict, id)
	if t[id] then
		logError("CommandStationConfig _checkEventFrontDependency 互相依赖了: ", tostring(id), tabletool.getDictJsonStr(t))

		return
	end

	t[id] = true

	local config = configDict[id]

	if not config then
		logError("CommandStationConfig _checkEventFrontDependency event config not found: ", tostring(id))

		return
	end

	for _, eventId in ipairs(config.frontEventId) do
		self:_checkEventFrontDependency(t, configDict, eventId)
	end
end

function CommandStationConfig:_initEvent()
	self._normalEventIdToUnlockEventMap = {}
	self._unlockEventToNormalEventIdMap = {}

	for i, v in ipairs(lua_copost_event.configList) do
		if #v.frontEventId > 0 then
			local frontEventIdList = v.frontEventId

			self._normalEventIdToUnlockEventMap[v.id] = frontEventIdList

			for _, eventId in ipairs(frontEventIdList) do
				self._unlockEventToNormalEventIdMap[eventId] = v.id
			end

			if SLFramework.FrameworkSettings.IsEditor then
				self:_checkEventFrontDependency({}, lua_copost_event.configDict, v.id)
			end
		end
	end
end

function CommandStationConfig:_initCharacterEvent()
	self._chaEventIdToUnlockEventMap = {}
	self._unlockEventToChaEventIdMap = {}

	for i, v in ipairs(lua_copost_character_event.configList) do
		if #v.frontEventId > 0 then
			local frontEventIdList = v.frontEventId

			self._chaEventIdToUnlockEventMap[v.id] = frontEventIdList

			for _, eventId in ipairs(frontEventIdList) do
				self._unlockEventToChaEventIdMap[eventId] = v.id
			end

			if SLFramework.FrameworkSettings.IsEditor then
				self:_checkEventFrontDependency({}, lua_copost_character_event.configDict, v.id)
			end
		end
	end
end

function CommandStationConfig:_initEventText()
	return
end

function CommandStationConfig:_initVersionTask()
	return
end

function CommandStationConfig:_initCatchTask()
	return
end

function CommandStationConfig:_initBonus()
	self._taskBonusList = {}

	for i, v in ipairs(lua_copost_bonus.configList) do
		table.insert(self._taskBonusList, v)
	end

	table.sort(self._taskBonusList, SortUtil.tableKeyLower({
		"versionId",
		"pointNum"
	}))
end

function CommandStationConfig:_initNpc()
	self._dialogueList = {}

	for i, v in ipairs(lua_copost_npc.configList) do
		self._dialogueList[v.condition] = v
	end
end

function CommandStationConfig:_initNpcText()
	return
end

function CommandStationConfig:_initPasswordPaper()
	self._paperList = {}

	for i, v in ipairs(lua_copost_password_paper.configList) do
		table.insert(self._paperList, v)
	end

	table.sort(self._paperList, SortUtil.keyLower("versionId"))
end

function CommandStationConfig:_initCharacterChain()
	self._page1ChainStateList = {}

	for i, v in ipairs(lua_copost_character_chain.configList) do
		for _, stateId in ipairs(v.stateId) do
			if v.id < CommandStationEnum.Page2_ChainId then
				self._page1ChainStateList[stateId] = true
			elseif self._page1ChainStateList[stateId] then
				logError("page2 chain stateId repeat:" .. stateId)
			end
		end
	end
end

function CommandStationConfig:_initCharacterState()
	self._characterFirstStateList = {}
	self._characterLastStateList = {}
	self._characterPosMap = {}
	self._characterFirstStateList2 = {}
	self._characterLastStateList2 = {}
	self._characterPosMap2 = {}

	for i, v in ipairs(lua_copost_character_state.configList) do
		local isPage1 = self._page1ChainStateList[v.stateId]

		if isPage1 then
			if not self._characterPosMap then
				local _characterPosMap = self._characterPosMap2

				if isPage1 then
					if not self._characterFirstStateList then
						local _characterFirstStateList = self._characterFirstStateList2

						if isPage1 then
							if not self._characterLastStateList then
								local _characterLastStateList = self._characterLastStateList2
								local chaId = tonumber(v.chaId)

								if SLFramework.FrameworkSettings.IsEditor then
									if _characterPosMap[chaId] and _characterPosMap[chaId] ~= v.positionId then
										logError(string.format("CommandStationConfig _initCharacterState chaId:%s stateId:%s oldPos:%s newPos:%s", chaId, v.stateId, _characterPosMap[chaId], v.positionId))
									end

									if #v.relationshipCha ~= #v.relationshipTxt then
										logError(string.format("CommandStationConfig _initCharacterState stateId:%s relationshipCha:%s relationshipTxt:%s 长度不一致", v.stateId, #v.relationshipCha, #v.relationshipTxt))
									end
								end

								_characterPosMap[chaId] = v.positionId
								_characterFirstStateList[chaId] = _characterFirstStateList[chaId] or v.stateId

								if not _characterLastStateList[chaId] then
									_characterLastStateList[chaId] = v
								elseif #v.chaTxt > #_characterLastStateList[chaId].chaTxt then
									_characterLastStateList[chaId] = v
								end
							end
						end
					end
				end
			end
		end
	end
end

function CommandStationConfig:getTimeIdUnlockEvent(timeId)
	return self._timeIdUnlockEventMap[timeId]
end

function CommandStationConfig:getActivatedTimeId(eventId)
	return self._unlockEventToTimeIdMap[eventId]
end

function CommandStationConfig:getActivatedNormalEventId(eventId)
	return self._unlockEventToNormalEventIdMap[eventId]
end

function CommandStationConfig:getActivatedCharEventId(eventId)
	return self._unlockEventToChaEventIdMap[eventId]
end

function CommandStationConfig:getActivatedEventId(eventId)
	return self:getActivatedNormalEventId(eventId) or self:getActivatedCharEventId(eventId)
end

function CommandStationConfig:isReadFinishEvent(eventId)
	local event = lua_copost_event.configDict[eventId]

	if event then
		return event.eventType == CommandStationEnum.EventType.Main or event.eventType == CommandStationEnum.EventType.Normal
	end

	event = lua_copost_character_event.configDict[eventId]

	if lua_copost_character_event.configDict[eventId] then
		return true
	end

	return nil
end

function CommandStationConfig:getUnlockEventList(eventId)
	return self._normalEventIdToUnlockEventMap[eventId] or self._chaEventIdToUnlockEventMap[eventId]
end

function CommandStationConfig:getMaxVersionId()
	return self._maxVersionId
end

function CommandStationConfig:getSceneConfig(id)
	local config = lua_copost_scene.configDict[id]

	if not config then
		logError(string.format("场景配置表不存在，id:%d", id))

		return nil
	end

	return config
end

function CommandStationConfig:getTimeIdByEpisodeId(id)
	return self._episodeIdTimeIdMap[id]
end

function CommandStationConfig:getTimeGroupByEpisodeId(id)
	local timePoint = self:getTimeIdByEpisodeId(id)

	return timePoint and self._timeGroup[timePoint]
end

function CommandStationConfig:getConstConfig(id)
	local config = lua_copost_const.configDict[id]

	if not config then
		logError("lua_copost_const config not found id:" .. id)
	end

	return config
end

function CommandStationConfig:getDialogByType(type)
	return self._dialogueList[type]
end

function CommandStationConfig:getRandomDialogTextId(type)
	local dialogue = self._dialogueList[type]
	local textId = dialogue.textId
	local weight = dialogue.weight
	local totalWeight = 0

	for i, v in ipairs(weight) do
		totalWeight = totalWeight + v
	end

	local randomWeight = math.random(1, totalWeight)
	local tempWeight = 0

	for i, v in ipairs(weight) do
		tempWeight = tempWeight + v

		if randomWeight <= tempWeight then
			return textId[i]
		end
	end
end

function CommandStationConfig:eventContainCharacterId(eventId, characterId)
	local config = lua_copost_character_event.configDict[eventId]

	if config.chaId == characterId then
		return true
	end

	return tabletool.indexOf(config.chasId, characterId) ~= nil
end

function CommandStationConfig:getVersionList()
	return lua_copost_version.configList
end

function CommandStationConfig:getVersionIndex(versionId, configList)
	if configList then
		for i, v in ipairs(configList) do
			if v.versionId == versionId then
				return i
			end
		end
	else
		logError("CommandStationConfig:getVersionIndex configList is nil")
	end

	return 1
end

function CommandStationConfig:getVersionTimeline(versionId)
	local list = self._verionTimeline[versionId]

	if not list then
		logError(string.format("CommandStationConfig getVersionTimeline not list versionId:%s", versionId))

		return {}
	end

	return list
end

function CommandStationConfig:getTimeGroupByTimeId(timeId)
	return self._timeGroup[timeId]
end

function CommandStationConfig:getTimeGroupByCharacterId(id)
	return self._characterTimeGroup[id]
end

function CommandStationConfig:getTimeGroupByCharacterEventId(id)
	local timeConfig = self._characterEventTime[id]

	return timeConfig and self:getTimeGroupByTimeId(timeConfig.id)
end

function CommandStationConfig:getTimeIdByEventId(id)
	if not self._normalEventTime[id] then
		return self._normalEventTime[id] and self._normalEventTime[id].id
	end
end

function CommandStationConfig:getCharacterEventList(timeId)
	local timePointConfig = lua_copost_time_point_event.configDict[timeId]

	if not timePointConfig then
		logError(string.format("CommandStationConfig getCharacterEventList not timePointConfig timeId:%s", timeId))

		return {}
	end

	return timePointConfig.chaEventId
end

function CommandStationConfig:getTimePointEpisodeId(timeId)
	local timePointConfig = lua_copost_time_point_event.configDict[timeId]

	if not timePointConfig then
		logError(string.format("CommandStationConfig getTimePointEpisodeId not timePointConfig timeId:%s", timeId))

		return nil
	end

	return timePointConfig.fightId
end

function CommandStationConfig:getEventList(timeId, filteredEventId, eventKey)
	local timePointConfig = lua_copost_time_point_event.configDict[timeId]

	if not timePointConfig then
		logError(string.format("CommandStationConfig getEventList not timePointConfig timeId:%s", timeId))

		return {}
	end

	local list = timePointConfig[eventKey or CommandStationEnum.EventCategoryKey.Normal]

	if filteredEventId then
		local index = tabletool.indexOf(list, filteredEventId)

		if index == -1 then
			logError(string.format("CommandStationConfig getEventList not filteredEventId timeId:%s filteredEventId:%s", timeId, filteredEventId))

			return {}
		end

		local filteredEventConfig = lua_copost_event.configDict[filteredEventId]

		if not filteredEventConfig then
			logError(string.format("CommandStationConfig getEventList not filteredEventConfig timeId:%s filteredEventId:%s", timeId, filteredEventId))

			return {}
		end

		local result = {}

		for i, v in ipairs(list) do
			local config = lua_copost_event.configDict[v]

			if config and config.eventType == filteredEventConfig.eventType then
				table.insert(result, v)
			end
		end

		return result
	end

	return list
end

function CommandStationConfig:forEachGetEventList(timeId, filteredEventId, eventKey, callback, callbackObj)
	local timePointConfig = lua_copost_time_point_event.configDict[timeId]

	if not timePointConfig then
		logError(string.format("CommandStationConfig getEventList not timePointConfig timeId:%s", timeId))

		return
	end

	local list = timePointConfig[eventKey or CommandStationEnum.EventCategoryKey.Normal]

	if filteredEventId then
		local index = tabletool.indexOf(list, filteredEventId)

		if index == -1 then
			logError(string.format("CommandStationConfig getEventList not filteredEventId timeId:%s filteredEventId:%s", timeId, filteredEventId))

			return
		end

		local filteredEventConfig = lua_copost_event.configDict[filteredEventId]

		if not filteredEventConfig then
			logError(string.format("CommandStationConfig getEventList not filteredEventConfig timeId:%s filteredEventId:%s", timeId, filteredEventId))

			return
		end

		for i, v in ipairs(list) do
			local config = lua_copost_event.configDict[v]

			if config and config.eventType == filteredEventConfig.eventType then
				callback(callbackObj, v)
			end
		end
	else
		for i, v in ipairs(list) do
			callback(callbackObj, v)
		end
	end
end

function CommandStationConfig:getTimePointName(timeId)
	local config = lua_copost_time_point.configDict[timeId]

	if not config then
		logError(string.format("CommandStationConfig getTimePointName not config timeId:%s", timeId))

		return ""
	end

	return config.time
end

function CommandStationConfig:getCurVersionId()
	self._curVersionId = self._curVersionId or CommonConfig.instance:getConstNum(CommandStationEnum.ConstId_CurVersion)

	return self._curVersionId
end

function CommandStationConfig:getCharacterPos(stateId, chaId)
	if self._page1ChainStateList[stateId] then
		return self._characterPosMap[chaId]
	end

	return self._characterPosMap2[chaId]
end

function CommandStationConfig:getCharacterFirstShowState(stateId, chaId)
	if self._page1ChainStateList[stateId] then
		return self._characterFirstStateList[chaId]
	end

	return self._characterFirstStateList2[chaId]
end

function CommandStationConfig:getCharacterLastShowState(stateId, chaId)
	if self._page1ChainStateList[stateId] then
		local config = self._characterLastStateList[chaId]

		return (config or nil) and (config.stateId or 0)
	end

	local config = self._characterLastStateList2[chaId]

	return (config or nil) and (config.stateId or 0)
end

function CommandStationConfig:getCampByLocation(location)
	return self._campLocationMap[location]
end

function CommandStationConfig:getPaperItemId()
	self._paperItemId = self._paperItemId or CommonConfig.instance:getConstNum(CommandStationEnum.ConstId_PaperItemId)

	return self._paperItemId
end

function CommandStationConfig:getCurTotalPaperCount(versionId)
	local num = 0
	local curVersionId = versionId or self:getCurVersionId()

	for i, v in ipairs(self._paperList) do
		if curVersionId >= v.versionId then
			num = num + v.allNum
		else
			break
		end
	end

	return num
end

function CommandStationConfig:getPaperList()
	local list = {}
	local curVersionId = self:getCurVersionId()

	for i, v in ipairs(self._paperList) do
		if curVersionId >= v.versionId then
			table.insert(list, v)
		end
	end

	return list
end

function CommandStationConfig:getCurPaperCount()
	local itemId = self:getPaperItemId()

	return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, itemId)
end

function CommandStationConfig:getTotalTaskRewards()
	local list = {}
	local itemCounts = {}
	local curVersionId = self:getCurVersionId()

	for _, v in ipairs(self._taskBonusList) do
		if curVersionId >= v.versionId then
			table.insert(list, v)
			table.insert(itemCounts, #GameUtil.splitString2(v.bonus))
		else
			break
		end
	end

	return list, itemCounts
end

CommandStationConfig.instance = CommandStationConfig.New()

return CommandStationConfig
