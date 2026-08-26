-- chunkname: @modules/logic/rouge/config/RougeMapConfig.lua

module("modules.logic.rouge.config.RougeMapConfig", package.seeall)

local RougeMapConfig = class("RougeMapConfig", BaseConfig)

function RougeMapConfig:reqConfigNames()
	return {
		"rouge_layer",
		"rouge_middle_layer",
		"rouge_event",
		"rouge_fight_event",
		"rouge_choice_event",
		"rouge_choice",
		"rouge_shop_event",
		"rouge_interactive",
		"rouge_path_select",
		"rouge_piece",
		"rouge_piece_talk",
		"rouge_piece_select",
		"rouge_effect",
		"rouge_entrust_desc",
		"rouge_entrust",
		"rouge_unlock_desc",
		"rouge_repair_shop_price",
		"rouge_repair_shop",
		"rouge_event_type",
		"rouge_short_voice_group",
		"rouge_short_voice"
	}
end

function RougeMapConfig:onInit()
	return
end

function RougeMapConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge_middle_layer" then
		self:initRougeMiddleLayerCo()
	elseif configName == "rouge_short_voice" then
		self:initMapVoiceCo()
	elseif configName == "rouge_effect" then
		self:initRougeEffect()
	end
end

function RougeMapConfig:initRougeEffect()
	self.dropMaxRefreshNumDict = {}

	local configList = lua_rouge_effect.configList

	for _, co in ipairs(configList) do
		if co.type == RougeMapEnum.EffectType.UnlockFightDropRefresh then
			local paramList = string.splitToNumber(co.typeParam, "#")
			local fightType, maxNum = paramList[1], paramList[2]

			self.dropMaxRefreshNumDict[fightType] = maxNum
		end
	end
end

function RougeMapConfig:initMapVoiceCo()
	self.groupVoiceList = {}
	self.groupTotalWeight = {}

	for _, co in ipairs(lua_rouge_short_voice.configList) do
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

function RougeMapConfig:initRougeMiddleLayerCo()
	local handleDict = {
		pointPos = RougeMapConfig.pointPosHandle,
		pathPointPos = RougeMapConfig.pathPointPosHandle,
		path = RougeMapConfig.pathHandle,
		pathDict = RougeMapConfig.pathDictHandle,
		leavePos = RougeMapConfig.leavePosHandle,
		nextLayerList = RougeMapConfig.nextLayerListHandle,
		pathSelectList = RougeMapConfig.pathSelectListHandle
	}
	local metaTable = getmetatable(lua_rouge_middle_layer.configList[1])
	local src__index = metaTable.__index

	function metaTable.__index(t, k)
		local customHandle = handleDict[k]

		if customHandle then
			return customHandle(t, k, src__index)
		end

		return src__index(t, k)
	end
end

function RougeMapConfig.pointPosHandle(t, k, src__index)
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

function RougeMapConfig.pathPointPosHandle(t, k, src__index)
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

function RougeMapConfig.pathHandle(t, k, src__index)
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

function RougeMapConfig.pathDictHandle(t, k, src__index)
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

function RougeMapConfig.leavePosHandle(t, k, src__index)
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

function RougeMapConfig.nextLayerListHandle(t, k, src__index)
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

function RougeMapConfig.pathSelectListHandle(t, k, src__index)
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

function RougeMapConfig:getPathIndexList(pathDict, startIndex, endIndex, arriveList, level)
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

function RougeMapConfig:getNextLayerList(middleLayerId)
	local middleLayerCo = lua_rouge_middle_layer.configDict[middleLayerId]

	if not middleLayerCo then
		logError("not found middle layer co .. " .. tostring(middleLayerId))

		return
	end

	return middleLayerCo.nextLayerList
end

function RougeMapConfig:getPathSelectList(middleLayerId)
	local middleLayerCo = lua_rouge_middle_layer.configDict[middleLayerId]

	if not middleLayerCo then
		logError("not found middle layer co .. " .. tostring(middleLayerId))

		return
	end

	return middleLayerCo.pathSelectList
end

function RougeMapConfig:getMapResPath(layerId)
	local co = lua_rouge_layer.configDict[layerId]

	return co.mapRes
end

function RougeMapConfig:getMiddleMapResPath(layerId)
	local co = lua_rouge_middle_layer.configDict[layerId]

	return co.mapRes
end

function RougeMapConfig:getMiddleLayerCo(layerId)
	return lua_rouge_middle_layer.configDict[layerId]
end

function RougeMapConfig:getRougeEvent(id)
	local eventCo = lua_rouge_event.configDict[id]

	if not eventCo then
		logError("找不到肉鸽事件配置 ID : " .. tostring(id))
	end

	return eventCo
end

function RougeMapConfig:getFightEvent(id)
	local eventCo = lua_rouge_fight_event.configDict[id]

	if not eventCo then
		logError("找不到肉鸽战斗事件配置 ID : " .. tostring(id))
	end

	return eventCo
end

function RougeMapConfig:getPathSelectInitCameraSize()
	return tonumber(lua_rouge_const.configDict[RougeMapEnum.ConstKey.PathSelectCameraSize].value)
end

function RougeMapConfig:getStoreRefreshCost()
	local coststr = lua_rouge_const.configDict[RougeMapEnum.ConstKey.StoreRefreshCost]
	local arr = string.splitToNumber(coststr.value, "#")
	local cost, increment = arr[1], arr[2]

	return cost, increment
end

function RougeMapConfig:getRestStoreRefreshCount()
	local count = lua_rouge_const.configDict[RougeMapEnum.ConstKey.RestStoreRefreshCount]

	return tonumber(count.value)
end

function RougeMapConfig:getRestExchangeCount()
	local count = lua_rouge_const.configDict[RougeMapEnum.ConstKey.ExchangeCount]

	return tonumber(count.value)
end

function RougeMapConfig:getFightRetryNum()
	local count = lua_rouge_const.configDict[RougeMapEnum.ConstKey.FightRetryNum]

	return tonumber(count.value)
end

function RougeMapConfig:getRandomVoice(groupId)
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

function RougeMapConfig:getVoiceGroupList()
	return lua_rouge_short_voice_group.configList
end

function RougeMapConfig:getRougeEffect(effectId)
	local effectCo = lua_rouge_effect.configDict[effectId]

	if not effectCo then
		logError("rouge effect not find effectId : " .. effectId)
	end

	return effectCo
end

function RougeMapConfig:getFightDropMaxRefreshNum(type)
	return self.dropMaxRefreshNumDict[type] or 0
end

function RougeMapConfig:getPieceCo(pieceId)
	if not pieceId then
		logError("piece id is nil")

		return
	end

	local co = lua_rouge_piece.configDict[pieceId]

	if not co then
		logError("piece config not exist, id : " .. tostring(pieceId))

		return
	end

	return co
end

RougeMapConfig.instance = RougeMapConfig.New()

return RougeMapConfig
