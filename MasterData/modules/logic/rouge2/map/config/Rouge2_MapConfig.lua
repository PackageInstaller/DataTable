-- chunkname: @modules/logic/rouge2/map/config/Rouge2_MapConfig.lua

module("modules.logic.rouge2.map.config.Rouge2_MapConfig", package.seeall)

local Rouge2_MapConfig = class("Rouge2_MapConfig", BaseConfig)

function Rouge2_MapConfig:reqConfigNames()
	return {
		"rouge2_layer",
		"rouge2_middle_layer",
		"rouge2_event_group",
		"rouge2_event",
		"rouge2_fight_event",
		"rouge2_choice",
		"rouge_shop_event",
		"rouge2_interactive",
		"rouge2_path_select",
		"rouge2_piece",
		"rouge2_piece_talk",
		"rouge2_piece_select",
		"rouge2_effect",
		"rouge2_entrust_desc",
		"rouge2_entrust",
		"rouge2_unlock_desc",
		"rouge_repair_shop_price",
		"rouge_repair_shop",
		"rouge2_event_type",
		"rouge2_short_voice_group",
		"rouge2_short_voice",
		"rouge2_weather",
		"rouge2_weather_rule",
		"rouge2_band",
		"rouge2_funnyfight_event",
		"rouge2_drop_type"
	}
end

function Rouge2_MapConfig:onInit()
	return
end

function Rouge2_MapConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge2_middle_layer" then
		self:initRougeMiddleLayerCo()
	elseif configName == "rouge_short_voice" then
		self:initMapVoiceCo()
	elseif configName == "rouge2_choice" then
		self:initChoiceConfig()
	elseif configName == "rouge2_layer" then
		self:initLayerConfig()
	elseif configName == "rouge2_drop_type" then
		self:initDropTypeConfig()
	end
end

function Rouge2_MapConfig:initChoiceConfig()
	self.eventChoiceMap = {}

	local configList = lua_rouge2_choice.configList

	for _, co in ipairs(configList) do
		local eventId = co.eventId

		self.eventChoiceMap[eventId] = self.eventChoiceMap[eventId] or {}

		table.insert(self.eventChoiceMap[eventId], co.id)
	end
end

function Rouge2_MapConfig:initLayerConfig()
	self.mapResPathMap = {}
	self.mapCellPosMap = {}

	for _, co in ipairs(lua_rouge2_layer.configList) do
		local mapResList = GameUtil.splitString2(co.mapRes)

		if not self.mapResPathMap[co.id] then
			for _, resInfo in ipairs(mapResList) do
				local weatherId = tonumber(resInfo[1])

				self.mapResPathMap[co.id][weatherId] = resInfo[2]
			end

			self.mapResPathMap[co.id] = self.mapResPathMap[co.id]

			self:initLayerCellConfig(co)
		end
	end
end

function Rouge2_MapConfig:initLayerCellConfig(layerCo)
	local cellMap = {}

	cellMap[1] = GameUtil.splitString2(layerCo.gridPosType1, true)
	cellMap[2] = GameUtil.splitString2(layerCo.gridPosType2, true)
	cellMap[3] = GameUtil.splitString2(layerCo.gridPosType3, true)
	self.mapCellPosMap[layerCo.id] = cellMap
end

function Rouge2_MapConfig:initDropTypeConfig()
	self.dropType2CostList = {}

	for _, co in ipairs(lua_rouge2_drop_type.configList) do
		self.dropType2CostList[co.id] = string.splitToNumber(co.refreshCost, "#")
	end
end

function Rouge2_MapConfig:initMapVoiceCo()
	self.groupVoiceList = {}
	self.groupTotalWeight = {}

	for _, co in ipairs(lua_rouge2_short_voice.configList) do
		local groupId = co.groupId
		local list = self.groupVoiceList[groupId]

		if not list then
			list = {}
			self.groupVoiceList[groupId] = list
		end

		if not self.groupTotalWeight[groupId] then
			local weight = 0

			self.groupTotalWeight[groupId] = weight + co.weight

			table.insert(list, co)
		end
	end
end

function Rouge2_MapConfig:initRougeMiddleLayerCo()
	local handleDict = {
		pointPos = Rouge2_MapConfig.pointPosHandle,
		pathPointPos = Rouge2_MapConfig.pathPointPosHandle,
		path = Rouge2_MapConfig.pathHandle,
		pathDict = Rouge2_MapConfig.pathDictHandle,
		leavePos = Rouge2_MapConfig.leavePosHandle,
		nextLayerList = Rouge2_MapConfig.nextLayerListHandle,
		pathSelectList = Rouge2_MapConfig.pathSelectListHandle
	}
	local metaTable = getmetatable(lua_rouge2_middle_layer.configList[1])
	local src__index = metaTable.__index

	function metaTable.__index(t, k)
		local customHandle = handleDict[k]

		if customHandle then
			return customHandle(t, k, src__index)
		end

		return src__index(t, k)
	end
end

function Rouge2_MapConfig.pointPosHandle(t, k, src__index)
	local pointPosList = rawget(t, "pointPosList")

	if not pointPosList then
		pointPosList = {}

		rawset(t, "pointPosList", pointPosList)

		local pointPos = src__index(t, k)

		if not string.nilorempty(pointPos) then
			for _, str in ipairs(string.split(pointPos, "|")) do
				local arr = string.splitToNumber(str, "#")

				table.insert(pointPosList, Vector3.New(arr[1], arr[2], arr[3]))
			end
		end
	end

	return pointPosList
end

function Rouge2_MapConfig.pathPointPosHandle(t, k, src__index)
	local pathPointPosList = rawget(t, "pathPointPosList")

	if not pathPointPosList then
		pathPointPosList = {}

		rawset(t, "pathPointPos", pathPointPosList)

		local pathPointPos = src__index(t, k)

		if not string.nilorempty(pathPointPos) then
			for _, str in ipairs(string.split(pathPointPos, "|")) do
				local arr = string.splitToNumber(str, "#")

				table.insert(pathPointPosList, Vector2.New(arr[1], arr[2]))
			end
		end
	end

	return pathPointPosList
end

function Rouge2_MapConfig.pathHandle(t, k, src__index)
	local pathList = rawget(t, "pathList")

	if not pathList then
		pathList = {}

		rawset(t, "pathList", pathList)

		local path = src__index(t, k)

		if not string.nilorempty(path) then
			for _, str in ipairs(string.split(path, "|")) do
				local arr = string.splitToNumber(str, "#")

				table.insert(pathList, Vector2.New(arr[1], arr[2]))
			end
		end
	end

	return pathList
end

function Rouge2_MapConfig.pathDictHandle(t, k, src__index)
	local pathDict = rawget(t, "pathDict")

	if not pathDict then
		pathDict = {}

		rawset(t, "pathDict", pathDict)

		local path = src__index(t, "path")

		if not string.nilorempty(path) then
			for _, str in ipairs(string.split(path, "|")) do
				local arr = string.splitToNumber(str, "#")
				local startIndex = arr[1]
				local endIndex = arr[2]

				pathDict[startIndex] = pathDict[startIndex] or {}
				pathDict[endIndex] = pathDict[endIndex] or {}
				pathDict[startIndex][endIndex] = true
				pathDict[endIndex][startIndex] = true
			end
		end
	end

	return pathDict
end

function Rouge2_MapConfig.leavePosHandle(t, k, src__index)
	local leavePos = rawget(t, k)

	if not leavePos then
		leavePos = src__index(t, k)

		if string.nilorempty(leavePos) then
			return
		end

		leavePos = string.splitToNumber(leavePos, "#")
		leavePos = Vector3.New(leavePos[1], leavePos[2], leavePos[3])

		rawset(t, k, leavePos)
	end

	return leavePos
end

function Rouge2_MapConfig.nextLayerListHandle(t, k, src__index)
	local nextLayerList = rawget(t, k)

	if not nextLayerList then
		local nextLayer = src__index(t, "nextLayer")

		if string.nilorempty(nextLayer) then
			return
		end

		nextLayerList = string.splitToNumber(nextLayer, "#")

		rawset(t, k, nextLayerList)
	end

	return nextLayerList
end

function Rouge2_MapConfig.pathSelectListHandle(t, k, src__index)
	local pathSelectList = rawget(t, k)

	if not pathSelectList then
		local pathSelect = src__index(t, "pathSelect")

		if string.nilorempty(pathSelect) then
			return
		end

		pathSelectList = string.splitToNumber(pathSelect, "#")

		rawset(t, k, pathSelectList)
	end

	return pathSelectList
end

function Rouge2_MapConfig:getPathIndexList(pathDict, startIndex, endIndex, arriveList, level)
	arriveList = arriveList or {}
	level = level or 1

	if level > 20 then
		logError("房间配置死循环了！！！！！！请检查配置")

		return false
	end

	if tabletool.indexOf(arriveList, startIndex) then
		return false
	end

	table.insert(arriveList, startIndex)

	local nextDict = pathDict[startIndex]

	if nextDict then
		for nextIndex, _ in pairs(nextDict) do
			if nextIndex == endIndex then
				table.insert(arriveList, endIndex)

				return true
			elseif self:getPathIndexList(pathDict, nextIndex, endIndex, arriveList, level + 1) then
				return true
			end
		end
	end

	table.remove(arriveList)

	return false
end

function Rouge2_MapConfig:getNextLayerList(middleLayerId)
	local middleLayerCo = lua_rouge2_middle_layer.configDict[middleLayerId]

	if not middleLayerCo then
		logError("not found middle layer co .. " .. tostring(middleLayerId))

		return
	end

	return middleLayerCo.nextLayerList
end

function Rouge2_MapConfig:getPathSelectList(middleLayerId)
	local middleLayerCo = lua_rouge2_middle_layer.configDict[middleLayerId]

	if not middleLayerCo then
		logError("not found middle layer co .. " .. tostring(middleLayerId))

		return
	end

	return middleLayerCo.pathSelectList
end

function Rouge2_MapConfig:getMapResPath(layerId)
	local co = lua_rouge2_layer.configDict[layerId]

	return co.mapRes
end

function Rouge2_MapConfig:getMiddleMapResPath(layerId)
	local co = lua_rouge2_middle_layer.configDict[layerId]

	return co.mapRes
end

function Rouge2_MapConfig:getMiddleLayerCo(layerId)
	return lua_rouge2_middle_layer.configDict[layerId]
end

function Rouge2_MapConfig:getRougeEvent(id)
	local eventCo = lua_rouge2_event.configDict[id]

	if not eventCo then
		logError("找不到肉鸽事件配置 ID : " .. tostring(id))
	end

	return eventCo
end

function Rouge2_MapConfig:eventId2FightEventCo(eventId)
	local eventCo = self:getRougeEvent(eventId)
	local episodeId = eventCo and tonumber(eventCo.eventParam)

	return self:getFightEvent(episodeId)
end

function Rouge2_MapConfig:getFightEvent(id)
	local eventCo = lua_rouge2_fight_event.configDict[id]

	if not eventCo then
		logError("找不到肉鸽战斗事件配置 ID : " .. tostring(id))
	end

	return eventCo
end

function Rouge2_MapConfig:getPathSelectInitCameraSize()
	return tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.PathSelectCameraSize].value)
end

function Rouge2_MapConfig:getRandomVoice(groupId)
	local voiceList = self.groupVoiceList[groupId]

	if not voiceList then
		return
	end

	local voiceCount = #voiceList

	if voiceCount == 1 then
		return voiceList[1]
	end

	local totalWeight = self.groupTotalWeight[groupId]
	local randomWeight = math.random(totalWeight)
	local compareWeight = 0

	for _, co in ipairs(voiceList) do
		compareWeight = compareWeight + co.weight

		if randomWeight <= compareWeight then
			return co
		end
	end

	return voiceList[voiceCount]
end

function Rouge2_MapConfig:getVoiceGroupList()
	return lua_rouge2_short_voice_group.configList
end

function Rouge2_MapConfig:getRougeEffect(effectId)
	local effectCo = lua_rouge2_effect.configDict[effectId]

	if not effectCo then
		logError("rouge effect not find effectId : " .. effectId)
	end

	return effectCo
end

function Rouge2_MapConfig:getPieceCo(pieceId)
	if not pieceId then
		logError("piece id is nil")

		return
	end

	local co = lua_rouge2_piece.configDict[pieceId]

	if not co then
		logError("piece config not exist, id : " .. tostring(pieceId))

		return
	end

	return co
end

function Rouge2_MapConfig:getWeatherConfig(weatherId)
	local weatherCo = lua_rouge2_weather.configDict[weatherId]

	if not weatherCo then
		logError(string.format("肉鸽地图天气配置不存在 weatherId = %s", weatherId))
	end

	return weatherCo
end

function Rouge2_MapConfig:getWeatherRuleConfig(weatherRuleId)
	local weatherRuleCo = lua_rouge2_weather_rule.configDict[weatherRuleId]

	if not weatherRuleCo then
		logError(string.format("肉鸽地图天气机制配置不存在 weatherId = %s", weatherRuleId))
	end

	return weatherRuleCo
end

function Rouge2_MapConfig:getChoiceConfig(choiceId)
	local choiceCo = lua_rouge2_choice.configDict[choiceId]

	if not choiceCo then
		logError(string.format("肉鸽选项配置不存在 choiceId = %s", choiceId))

		return
	end

	return choiceCo
end

function Rouge2_MapConfig:getChoiceListByEventId(eventId)
	if not self.eventChoiceMap or not self.eventChoiceMap[eventId] then
		return nil
	end

	return self.eventChoiceMap[eventId]
end

function Rouge2_MapConfig:getChoiceSelctDescByCheckResult(choiceId, checkResult)
	local choiceCo = lua_rouge2_choice.configDict[choiceId]

	if not choiceCo then
		return
	end

	local result = ""

	if checkResult == Rouge2_MapEnum.AttrCheckResult.Failure then
		result = choiceCo.descLose
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.Succeed then
		result = choiceCo.descSuccess
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.BigSucceed then
		result = choiceCo.descBigSuccess
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.None then
		result = choiceCo.descSuccess
	else
		logError(string.format("未定义检定类型 checkResult = %s", checkResult))
	end

	return result
end

function Rouge2_MapConfig:getPieceSelctDescByCheckResult(choiceId, checkResult)
	checkResult = checkResult or Rouge2_MapEnum.AttrCheckResult.None

	local choiceCo = lua_rouge2_piece_select.configDict[choiceId]

	if not choiceCo then
		return
	end

	local result = ""

	if checkResult == Rouge2_MapEnum.AttrCheckResult.Failure then
		result = choiceCo.descLose
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.Succeed then
		result = choiceCo.descSuccess
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.BigSucceed then
		result = choiceCo.descBigSuccess
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.None then
		result = choiceCo.descSuccess
	else
		logError(string.format("未定义检定类型 checkResult = %s", checkResult))
	end

	return result
end

function Rouge2_MapConfig:getPieceSelectDescByCheckResult(choiceId, checkResult)
	local choiceCo = lua_rouge2_piece_select.configDict[choiceId]

	if not choiceCo then
		return
	end

	local result = ""

	if checkResult == Rouge2_MapEnum.AttrCheckResult.Failure then
		result = choiceCo.descLose
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.Succeed then
		result = choiceCo.descSuccess
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.BigSucceed then
		result = choiceCo.descBigSuccess
	elseif checkResult == Rouge2_MapEnum.AttrCheckResult.None then
		result = choiceCo.descSuccess
	else
		logError(string.format("未定义检定类型 checkResult = %s", checkResult))
	end

	return result
end

function Rouge2_MapConfig:getEventMainDialogue(eventId)
	local eventCo = self:getRougeEvent(eventId)

	return eventCo and GameUtil.splitString2(eventCo.mainDesc, true)
end

function Rouge2_MapConfig:getLayerMapResPath(layerId, weatherId)
	if self.mapResPathMap then
		local layerResMap = self.mapResPathMap[layerId]
		local layerMapRes = layerResMap and layerResMap[weatherId]

		if string.nilorempty(layerMapRes) then
			logError(string.format("肉鸽路线层地图资源路径配置不存在 layerId = %s, weatherId = %s", layerId, weatherId))
		end

		return layerMapRes
	end
end

function Rouge2_MapConfig:getMaxAcceptEntrustNum()
	local maxEntrustNum = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.MaxAcceptEntrustNum]

	return maxEntrustNum and tonumber(maxEntrustNum.value) or 0
end

function Rouge2_MapConfig:getCellPosList(layerId, type)
	if self.mapCellPosMap then
		local cellPosMap = self.mapCellPosMap[layerId]
		local typePosList = cellPosMap and cellPosMap[type]

		if not typePosList then
			logError(string.format("肉鸽路线层网格配置不存在 layerId = %s, type = %s", layerId, type))

			return
		end

		return typePosList
	end
end

function Rouge2_MapConfig:getCellPos(layerId, type, episodeIndex, index)
	local cellIndex = (episodeIndex - 1) * type + index
	local cellPosList = self:getCellPosList(layerId, type)
	local cellPos = cellPosList and cellPosList[cellIndex]

	if not cellPos then
		logError(string.format("肉鸽路线层棋子网格缺少坐标配置 layerId = %s, type = %s, episodeIndex = %s, index = %s", layerId, type, episodeIndex, index))
	end

	return cellPos
end

function Rouge2_MapConfig:getBandConfig(bandId)
	local bandCo = lua_rouge2_band.configDict[bandId]

	if not bandCo then
		logError(string.format("肉鸽乐队配置不存在 bandId = %s", bandId))
	end

	return bandCo
end

function Rouge2_MapConfig:getBandRelicsId()
	return tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.RecruitRelicsId].value)
end

function Rouge2_MapConfig:getMaxBandCost()
	return tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.MaxBandCost].value)
end

function Rouge2_MapConfig:BXSMaxBoxPoint()
	return tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.BXSMaxBoxPoint].value)
end

function Rouge2_MapConfig:getBXSAttrIdList()
	if not self._bxsAttrIdList then
		local attrIdStr = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.BXSBoxAttrIds].value

		self._bxsAttrIdList = string.splitToNumber(attrIdStr, "#") or {}
	end

	return self._bxsAttrIdList
end

function Rouge2_MapConfig:getBXSAttrId(index)
	local attrIdList = self:getBXSAttrIdList(index)

	return attrIdList and attrIdList[index]
end

function Rouge2_MapConfig:getFunnyTaskIdList(episodeId)
	local fightEventCo = Rouge2_MapConfig.instance:getFightEvent(episodeId)
	local fightTaskIdStr = fightEventCo and fightEventCo.fightTaskId

	if string.nilorempty(fightTaskIdStr) then
		return
	end

	return string.splitToNumber(fightTaskIdStr, "#")
end

function Rouge2_MapConfig:getFunnyTaskCofig(funnyTaskId)
	local funnyTaskCo = lua_rouge2_funnyfight_event.configDict[funnyTaskId]

	if not funnyTaskCo then
		logError(string.format("肉鸽趣味任务配置不存在 funnyTaskId = %s", funnyTaskId))
	end

	return funnyTaskCo
end

function Rouge2_MapConfig:getFunnyTaskTitle(episodeId)
	local funnyTaskIdList = self:getFunnyTaskIdList(episodeId)

	if not funnyTaskIdList then
		return
	end

	for _, funnyTaskId in ipairs(funnyTaskIdList) do
		local funnyTaskCo = self:getFunnyTaskCofig(funnyTaskId)

		if funnyTaskCo and funnyTaskCo.isTopic == 1 then
			return funnyTaskCo.fightTaskDesc
		end
	end

	logError(string.format("肉鸽趣味任务没有标题 episodeId = %s", episodeId))
end

function Rouge2_MapConfig:isRelicsUnRemove(relicsId)
	if not self._unRemoveRelicsIdMap then
		self._unRemoveRelicsIdMap = {}

		local unRemoveRelicsIdStr = lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.UnRemoveRelicsIds].value
		local unRemoveRelicsIdList = string.splitToNumber(unRemoveRelicsIdStr, "#")

		if unRemoveRelicsIdList then
			for _, unRemoveRelicsId in ipairs(unRemoveRelicsIdList) do
				self._unRemoveRelicsIdMap[unRemoveRelicsId] = true
			end
		end
	end

	return self._unRemoveRelicsIdMap and self._unRemoveRelicsIdMap[relicsId] == true
end

function Rouge2_MapConfig:getItemRefreshCost(dropType, refreshNum)
	if self.dropType2CostList then
		return self.dropType2CostList and self.dropType2CostList[refreshNum]
	end
end

Rouge2_MapConfig.instance = Rouge2_MapConfig.New()

return Rouge2_MapConfig
