-- chunkname: @modules/logic/udimo/config/UdimoConfig.lua

module("modules.logic.udimo.config.UdimoConfig", package.seeall)

local UdimoConfig = class("UdimoConfig", BaseConfig)

function UdimoConfig:reqConfigNames()
	return {
		"udimo_const",
		"udimo",
		"udimo_state",
		"udimo_info",
		"udimo_background",
		"udimo_background_area",
		"udimo_decoration",
		"udimo_weather",
		"udimo_temperature",
		"udimo_emoji",
		"udimo_interact",
		"udimo_friend",
		"udimo_lock_mode_setting"
	}
end

function UdimoConfig:onInit()
	return
end

function UdimoConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function UdimoConfig:udimo_decorationConfigLoaded(configTable)
	self.pos2DecorationDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local decorationId = cfg.id
		local pos = cfg.pos
		local decorationIdList = GameUtil.tabletool_checkDictTable(self.pos2DecorationDict, pos)

		decorationIdList[#decorationIdList + 1] = decorationId
	end
end

function UdimoConfig:udimo_weatherConfigLoaded(configTable)
	self._windLevelDict = {}
	self._weatherIdDict = {}

	for _, cfg in ipairs(configTable.configList) do
		local id = cfg.id
		local windLevel = cfg.windLevel

		if windLevel ~= 0 then
			if self._windLevelDict[windLevel] then
				logError(string.format("UdimoConfig.udimo_weatherConfigLoaded error, windLevel %s repeat", windLevel))
			end

			self._windLevelDict[windLevel] = id
		end

		for _, weatherId in ipairs(cfg.weatherIds) do
			if self._weatherIdDict[weatherId] then
				logError(string.format("UdimoConfig.udimo_weatherConfigLoaded error, weatherId %s repeat", weatherId))
			end

			self._weatherIdDict[weatherId] = id
		end
	end
end

function UdimoConfig:getUdimoConstCfg(constId, nilError)
	local cfg = lua_udimo_const.configDict[constId]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getUdimoConstCfg error, cfg is nil, constId:%s", constId))
	end

	return cfg
end

function UdimoConfig:getUdimoConst(constId, isNumber, delimiter, isToNumber)
	local result
	local cfg = self:getUdimoConstCfg(constId, true)

	if cfg then
		if isNumber then
			result = cfg.value
		else
			result = cfg.value2

			if not string.nilorempty(delimiter) then
				result = isToNumber and string.splitToNumber(result, delimiter) or string.split(result, delimiter)
			elseif isToNumber then
				result = tonumber(result)
			end
		end
	end

	return result
end

function UdimoConfig:getUdimoCfg(udimoId, nilError)
	local cfg = lua_udimo.configDict[udimoId]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getUdimoCfg error, cfg is nil, udimoId:%s", udimoId))
	end

	return cfg
end

function UdimoConfig:getAllUdimoList(getMO)
	local result = {}

	for _, cfg in ipairs(lua_udimo.configList) do
		result[#result + 1] = getMO and {
			id = cfg.id
		} or cfg.id
	end

	return result
end

function UdimoConfig:getName(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return (cfg or nil) and (cfg.name or "")
end

function UdimoConfig:getUdimoType(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.groupId
end

function UdimoConfig:getUdimoTypeCount(udimoType)
	if not self._udimoTypeCountDict then
		self._udimoTypeCountDict = {}

		for _, cfg in ipairs(lua_udimo.configList) do
			local type = cfg.groupId

			self._udimoTypeCountDict[type] = (self._udimoTypeCountDict[type] or 0) + 1
		end
	end

	return self._udimoTypeCountDict[udimoType] or 0
end

function UdimoConfig:getUdimoHeroId(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.heroId
end

function UdimoConfig:getUdimoEmojiPos(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.emojiPos
end

function UdimoConfig:getUdimoImgParam(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.imgParam
end

function UdimoConfig:getUdimoSpineRes(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.resource
end

function UdimoConfig:getUdimoColliderSize(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.colliderSize
end

function UdimoConfig:getUdimoColliderOffset(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.colliderOffset
end

function UdimoConfig:getUdimoSpineUIParam(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.spineParam
end

function UdimoConfig:getUdimoSceneSpineScale(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.resourceParam
end

function UdimoConfig:getUdimoOutlineRes(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.outlineRes
end

function UdimoConfig:getUdimoOrderLayer(udimoId)
	local cfg = self:getUdimoCfg(udimoId, true)

	return cfg and cfg.orderLayer
end

function UdimoConfig:getInfoCfg(infoId, nilError)
	local cfg = lua_udimo_info.configDict[infoId]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getInfoCfg error, cfg is nil, infoId:%s", infoId))
	end

	return cfg
end

function UdimoConfig:getShowInfoIdList()
	local result = {}

	for _, cfg in ipairs(lua_udimo_info.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function UdimoConfig:getInfoIcon(infoId)
	local cfg = self:getInfoCfg(infoId, true)

	return cfg and cfg.icon
end

function UdimoConfig:getInfoLangId(infoId)
	local cfg = self:getInfoCfg(infoId, true)

	return cfg and cfg.langId
end

function UdimoConfig:getStateCfg(udimoId, state, nilError)
	if lua_udimo_state.configDict[udimoId] then
		if not lua_udimo_state.configDict[udimoId] and nilError then
			logError(string.format("UdimoConfig:getStateCfg error, cfg is nil, udimoId:%s state:%s ", udimoId, state))
		end

		return lua_udimo_state.configDict[udimoId]
	end
end

function UdimoConfig:getStateEmoji(udimoId, state)
	local result
	local cfg = self:getStateCfg(udimoId, state)

	if cfg and not string.nilorempty(cfg.emoji) then
		local emojiArr = string.splitToNumber(cfg.emoji, "#")
		local index = math.random(1, #emojiArr)

		result = emojiArr[index]
	end

	return result
end

function UdimoConfig:getStateParamDict(udimoId, state)
	local result = {}
	local cfg = self:getStateCfg(udimoId, state)
	local stateParam = cfg and cfg.param

	if not string.nilorempty(stateParam) then
		local paramArr = GameUtil.splitString2(stateParam, true)

		for _, paramData in ipairs(paramArr) do
			if #paramData > 1 then
				local data = {}

				for i, v in ipairs(paramData) do
					if i ~= 1 then
						data[#data + 1] = v
					end
				end

				result[paramData[1]] = data
			else
				result[paramData[1]] = true
			end
		end
	end

	return result
end

function UdimoConfig:getBgCfg(bgId, nilError)
	local cfg = lua_udimo_background.configDict[bgId]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getBgCfg error, cfg is nil, bgId:%s", bgId))
	end

	return cfg
end

function UdimoConfig:getAllBgList()
	local result = {}

	for _, cfg in ipairs(lua_udimo_background.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function UdimoConfig:getDefaultBg()
	if not self._defaultBg then
		for _, cfg in ipairs(lua_udimo_background.configList) do
			if cfg.isDefault then
				self._defaultBg = cfg.id

				break
			end
		end
	end

	return self._defaultBg
end

function UdimoConfig:getBgName(bgId)
	local cfg = self:getBgCfg(bgId, true)

	return (cfg or nil) and (cfg.name or "")
end

function UdimoConfig:getBgImg(bgId)
	local cfg = self:getBgCfg(bgId, true)

	return cfg and cfg.img
end

function UdimoConfig:getSceneLevelId(bgId)
	local cfg = self:getBgCfg(bgId, true)

	return cfg and cfg.sceneLevel
end

function UdimoConfig:getBgAirPointList(bgId)
	local result = {}
	local cfg = self:getBgCfg(bgId, true)

	if cfg and not string.nilorempty(cfg.airPoints) then
		local arr = GameUtil.splitString2(cfg.airPoints, true)

		for _, point in ipairs(arr) do
			local x = point[1]
			local y = point[2]
			local z = point[3]

			if x and y and z then
				result[#result + 1] = {
					x = x,
					y = y,
					z = z
				}
			end
		end
	end

	return result
end

function UdimoConfig:getDefaultWeather(bgId)
	local cfg = self:getBgCfg(bgId, true)

	return cfg and cfg.defaultWeather
end

function UdimoConfig:getCameraMoveRange(bgId)
	local min, max = 0, 0
	local cfg = self:getBgCfg(bgId, true)

	if cfg and not string.nilorempty(cfg.cameraMoveRange) then
		local arr = string.splitToNumber(cfg.cameraMoveRange, "#")

		min = arr[1]
		max = arr[2]
	end

	return min, max
end

function UdimoConfig:getBgBgm(bgId)
	local cfg = self:getBgCfg(bgId, true)

	return cfg and cfg.bgm
end

function UdimoConfig:getBgAreaCfg(bgId, areaType, nilError)
	if lua_udimo_background_area.configDict[bgId] then
		if not lua_udimo_background_area.configDict[bgId] and nilError then
			logError(string.format("UdimoConfig:getBgAreaCfg error, cfg is nil, belongBg:%s areaType:%s ", bgId, areaType))
		end

		return lua_udimo_background_area.configDict[bgId]
	end
end

function UdimoConfig:getBgAreaZLevelList(bgId, areaType)
	local result
	local cfg = self:getBgAreaCfg(bgId, areaType, true)

	return (cfg and not string.nilorempty(cfg.zLevel) or nil) and string.splitToNumber(cfg.zLevel, "#")
end

function UdimoConfig:getBgAreaYLevelList(bgId, areaType)
	local result
	local cfg = self:getBgAreaCfg(bgId, areaType, true)

	return (cfg and not string.nilorempty(cfg.yLevel) or nil) and string.splitToNumber(cfg.yLevel, "#")
end

function UdimoConfig:getBgAreaXMoveRange(bgId, areaType)
	local result
	local cfg = self:getBgAreaCfg(bgId, areaType, true)

	return (cfg and not string.nilorempty(cfg.xMoveRange) or nil) and string.splitToNumber(cfg.xMoveRange, "#")
end

function UdimoConfig:getDecorationCfg(decorationId, nilError)
	local cfg = lua_udimo_decoration.configDict[decorationId]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getDecorationCfg error, cfg is nil, decorationId:%s", decorationId))
	end

	return cfg
end

function UdimoConfig:getDecorationName(decorationId)
	local cfg = self:getDecorationCfg(decorationId, true)

	return (cfg or nil) and (cfg.name or "")
end

function UdimoConfig:getDecorationImg(decorationId)
	local cfg = self:getDecorationCfg(decorationId, true)

	return cfg and cfg.img
end

function UdimoConfig:getAllDecorationList(pos)
	if self.pos2DecorationDict then
		return self.pos2DecorationDict or {}
	end
end

function UdimoConfig:getDecorationPos(decorationId)
	local cfg = self:getDecorationCfg(decorationId, true)

	return cfg and cfg.pos
end

function UdimoConfig:getDecorationRes(decorationId)
	local cfg = self:getDecorationCfg(decorationId, true)

	return cfg and cfg.resource
end

function UdimoConfig:getDecorationAirPointList(decorationId)
	local result = {}
	local cfg = self:getDecorationCfg(decorationId, true)

	if cfg and not string.nilorempty(cfg.airPoints) then
		local arr = GameUtil.splitString2(cfg.airPoints, true)

		for _, point in ipairs(arr) do
			local x = point[1]
			local y = point[2]

			if x and y then
				result[#result + 1] = {
					x = x,
					y = y,
					decorationId = decorationId
				}
			end
		end
	end

	return result
end

function UdimoConfig:getWeatherCfg(id, nilError)
	local cfg = lua_udimo_weather.configDict[id]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getWeatherCfg error, cfg is nil, id:%s ", id))
	end

	return cfg
end

function UdimoConfig:getCfgWeatherIdList(excludeId, temp, noWinLevel)
	local result = {}

	for _, cfg in ipairs(lua_udimo_weather.configList) do
		local id = cfg.id
		local winLevel = cfg.windLevel

		if (not excludeId or id ~= excludeId) and (not noWinLevel or winLevel == 0) then
			if temp then
				local minTemp = self:getWeatherMinTemperature(id)
				local maxTemp = self:getWeatherMaxTemperature(id)

				if not minTemp and not maxTemp then
					result[#result + 1] = id
				elseif minTemp and maxTemp then
					if minTemp <= temp and temp <= maxTemp then
						result[#result + 1] = id
					end
				elseif minTemp then
					if minTemp <= temp then
						result[#result + 1] = id
					end
				elseif maxTemp and temp <= maxTemp then
					result[#result + 1] = id
				end
			else
				result[#result + 1] = id
			end
		end
	end

	return result
end

function UdimoConfig:getWeatherIds(id)
	local cfg = self:getWeatherCfg(id, true)

	return cfg and cfg.weatherIds
end

function UdimoConfig:getWeatherMaxTemperature(id)
	local cfg = self:getWeatherCfg(id, true)

	if cfg and not string.nilorempty(cfg.maxTemperature) then
		return tonumber(cfg.maxTemperature)
	end
end

function UdimoConfig:getWeatherMinTemperature(id)
	local cfg = self:getWeatherCfg(id, true)

	if cfg and not string.nilorempty(cfg.minTemperature) then
		return tonumber(cfg.minTemperature)
	end
end

function UdimoConfig:findCfgWeatherId(weatherId, windLevel)
	if not weatherId or weatherId == 0 then
		return
	end

	local findId

	if windLevel then
		local reachLevel = 0

		for tWindLevel, tId in pairs(self._windLevelDict) do
			if reachLevel < tWindLevel and tWindLevel <= windLevel then
				findId = tId
				reachLevel = tWindLevel
			end
		end
	end

	if not findId then
		if self._weatherIdDict[weatherId] then
			findId = self._weatherIdDict[weatherId]
		else
			logNormal(string.format("UdimoConfig:findCfgWeatherId, not find id, weatherId:%s windLevel:%s", weatherId, windLevel))
		end
	end

	return findId
end

function UdimoConfig:getWeatherInfo(weatherId, windLevel)
	local id = self:findCfgWeatherId(weatherId, windLevel)
	local cfg = self:getWeatherCfg(id)

	if cfg then
		return {
			name = cfg.name,
			icon = cfg.icon,
			color = cfg.color
		}
	end
end

function UdimoConfig:getWeatherEffectDict(id)
	local result = {}
	local cfg = self:getWeatherCfg(id, true)

	if cfg and not string.nilorempty(cfg.effect) then
		local list = string.split(cfg.effect, "#")

		for _, effectName in ipairs(list) do
			result[effectName] = true
		end
	end

	return result
end

function UdimoConfig:getWeatherAudioId(id)
	local cfg = self:getWeatherCfg(id, true)

	return cfg and cfg.audioId
end

function UdimoConfig:getWeatherStopAudioId(id)
	local cfg = self:getWeatherCfg(id, true)

	return cfg and cfg.stopAudioId
end

function UdimoConfig:getTemperatureTip(weatherId, temperature)
	local result = ""
	local cfgDict = lua_udimo_temperature.configDict[weatherId]

	if cfgDict then
		local findTemp

		for cfgTemp, cfg in pairs(cfgDict) do
			if cfgTemp < temperature and (not findTemp or findTemp < cfgTemp) then
				result = cfg.description
				findTemp = cfgTemp
			end
		end
	end

	return result
end

function UdimoConfig:getInteractCfg(bgId, interactId, nilError)
	if lua_udimo_interact.configDict[bgId] then
		if not lua_udimo_interact.configDict[bgId] and nilError then
			logError(string.format("UdimoConfig:getInteractCfg error, cfg is nil, belongBg:%s interactId:%s ", bgId, interactId))
		end

		return lua_udimo_interact.configDict[bgId]
	end
end

function UdimoConfig:getInteractListAndDict(bgId)
	local list = {}
	local dict = {}
	local bgInteractDict = lua_udimo_interact.configDict[bgId]

	if bgInteractDict then
		for interactId, _ in pairs(bgInteractDict) do
			list[#list + 1] = interactId
			dict[interactId] = true
		end
	end

	return list, dict
end

function UdimoConfig:getInteractTypeDict(bgId, interactId)
	local result = {}
	local cfg = self:getInteractCfg(bgId, interactId, true)

	if cfg and cfg.groupIds then
		for _, type in ipairs(cfg.groupIds) do
			result[type] = true
		end
	end

	return result
end

function UdimoConfig:getInteractDirIsLeft(bgId, interactId)
	local cfg = self:getInteractCfg(bgId, interactId, true)

	return cfg and cfg.isLeft
end

function UdimoConfig:getInteractEmoji(bgId, interactId)
	local result
	local cfg = self:getInteractCfg(bgId, interactId)
	local strEmoji = cfg and cfg.emoji
	local idArr = string.splitToNumber(strEmoji, "#")

	if idArr and #idArr > 0 then
		local index = math.random(1, #idArr)

		result = idArr[index]
	end

	return result
end

function UdimoConfig:getInteractOrderLayer(bgId, interactId)
	local cfg = self:getInteractCfg(bgId, interactId, true)

	return cfg and cfg.orderLayer
end

function UdimoConfig:getInteractFriendCfg(bgId, friendId, nilError)
	if lua_udimo_friend.configDict[bgId] then
		if not lua_udimo_friend.configDict[bgId] and nilError then
			logError(string.format("UdimoConfig:getInteractFriendCfg error, cfg is nil, belongBg:%s friendId:%s ", bgId, friendId))
		end

		return lua_udimo_friend.configDict[bgId]
	end
end

function UdimoConfig:getUdimoRelativeFriend(bgId, udimoId, interactId)
	if not self._udimoFriendDict then
		self:_initUdimoFriendDict()
	end

	if not interactId then
		return
	end

	local friendId, friendUdimoId, friendInteractId
	local bgFriendData = self._udimoFriendDict[bgId]

	if bgFriendData then
		local friendData = bgFriendData[string.format("%s#%s", udimoId, interactId)]

		if friendData then
			friendId = friendData.friendId
			friendUdimoId = friendData.udimoId
			friendInteractId = friendData.interactId
		end
	end

	return friendId, friendUdimoId, friendInteractId
end

function UdimoConfig:_initUdimoFriendDict()
	self._udimoFriendDict = {}

	for _, cfg in ipairs(lua_udimo_friend.configList) do
		local bgId = cfg.belongBG
		local bgFriendData = self._udimoFriendDict[bgId]

		if not bgFriendData then
			bgFriendData = {}
			self._udimoFriendDict[bgId] = bgFriendData
		end

		local friendId = cfg.friendId
		local udimo1Data = string.splitToNumber(cfg.udimo1, "#")
		local udimo2Data = string.splitToNumber(cfg.udimo2, "#")

		bgFriendData[cfg.udimo1] = {
			friendId = friendId,
			udimoId = udimo2Data[1],
			interactId = udimo2Data[2]
		}
		bgFriendData[cfg.udimo2] = {
			friendId = friendId,
			udimoId = udimo1Data[1],
			interactId = udimo1Data[2]
		}
	end
end

function UdimoConfig:getFriendEmojiDataList(bgId, friendId)
	local result = {}
	local cfg = self:getInteractFriendCfg(bgId, friendId, true)

	if cfg and not string.nilorempty(cfg.emoji) then
		local arr1 = GameUtil.splitString2(cfg.emoji, true)

		for i, arr2 in ipairs(arr1) do
			local emojiData = {
				interactId = arr2[1],
				emojiId = arr2[2]
			}
			local num = #arr2

			if num > 2 then
				local randomIndex = math.random(2, num)

				emojiData.emojiId = arr2[randomIndex]
			end

			result[i] = emojiData
		end
	end

	return result
end

function UdimoConfig:getFriendUidmo(bgId, friendId)
	local udimo1, udimo2
	local cfg = self:getInteractFriendCfg(bgId, friendId, true)

	if cfg then
		local udimo1Data = string.splitToNumber(cfg.udimo1, "#")
		local udimo2Data = string.splitToNumber(cfg.udimo2, "#")

		udimo1 = udimo1Data and udimo1Data[1]
		udimo2 = udimo2Data and udimo2Data[1]
	end

	return udimo1, udimo2
end

function UdimoConfig:getEmojiCfg(emojiId, nilError)
	local cfg = lua_udimo_emoji.configDict[emojiId]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getEmojiCfg error, cfg is nil, id:%s ", emojiId))
	end

	return cfg
end

function UdimoConfig:getEmojiRes(emojiId)
	local cfg = self:getEmojiCfg(emojiId, true)

	return cfg and cfg.resource
end

function UdimoConfig:getLockModeSettingCfg(id, nilError)
	local cfg = lua_udimo_lock_mode_setting.configDict[id]

	if not cfg and nilError then
		logError(string.format("UdimoConfig:getLockModeSettingCfg error, cfg is nil, id:%s ", id))
	end

	return cfg
end

function UdimoConfig:getLockSettingIdList()
	local result = {}

	for _, cfg in ipairs(lua_udimo_lock_mode_setting.configList) do
		result[#result + 1] = cfg.id
	end

	return result
end

function UdimoConfig:getDefaultSettingId()
	for _, cfg in ipairs(lua_udimo_lock_mode_setting.configList) do
		if cfg.isDefault then
			return cfg.id
		end
	end
end

function UdimoConfig:getSettingName(id)
	local result
	local cfg = self:getLockModeSettingCfg(id, true)

	return (not string.nilorempty(cfg.name) or nil) and luaLang(cfg.name) or ""
end

function UdimoConfig:getSettingWaitTime(id)
	local cfg = self:getLockModeSettingCfg(id, true)

	return cfg and cfg.waitTime
end

UdimoConfig.instance = UdimoConfig.New()

return UdimoConfig
