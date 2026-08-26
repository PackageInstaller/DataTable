-- chunkname: @modules/logic/playercard/model/PlayerCardMO.lua

module("modules.logic.playercard.model.PlayerCardMO", package.seeall)

local PlayerCardMO = pureTable("PlayerCardMO")

function PlayerCardMO:init(userId)
	self.id = userId
	self.userId = userId
end

function PlayerCardMO:updateInfo(cardInfo, playerInfo)
	self.playerInfo = playerInfo

	self:updateShowSetting(cardInfo.showSettings)
	self:updateProgressSetting(cardInfo.progressSetting)
	self:updateBaseInfoSetting(cardInfo.baseSetting)
	self:updateHeroCover(cardInfo.heroCover)
	self:updateThemeId(cardInfo.themeId)
	self:updateCritter(cardInfo.critter)

	self.showAchievement = cardInfo.showAchievement
	self.roomCollection = cardInfo.roomCollection
	self.layerId = cardInfo.layerId
	self.weekwalkDeepLayerId = cardInfo.weekwalkDeepLayerId
	self.exploreCollection = cardInfo.exploreCollection
	self.rougeDifficulty = cardInfo.rougeDifficulty
	self.act128SSSCount = cardInfo.act128SSSCount
	self.achievementCount = cardInfo.achievementCount
	self.assistTimes = cardInfo.assistTimes
	self.heroCoverTimes = cardInfo.heroCoverTimes
	self.maxFaithHeroCount = cardInfo.maxFaithHeroCount
	self.totalCostPower = cardInfo.totalCostPower
	self.skinCount = cardInfo.skinCount
	self.towerLayer = cardInfo.towerLayer
	self.towerBossPassCount = cardInfo.towerBossPassCount
	self.maxLevelHero = cardInfo.heroMaxLevelCount
	self.weekwalkVer2PlatinumCup = cardInfo.weekwalkVer2PlatinumCup
	self.towerLayerMetre = cardInfo.towerLayerMetre
	self.act128Level = cardInfo.act128Level

	self:updateEquipBadge(cardInfo.badgeIds)
	self:setHeroCount(cardInfo.heroCount)
end

function PlayerCardMO:updateShowSetting(showSetting)
	self._showSettings = {}

	local infoDict = {}

	if showSetting then
		for i = 1, #showSetting do
			local setting = showSetting[i]
			local split = string.split(setting, "#")
			local key = split[1]
			local value = split[2]

			if key and value then
				infoDict[tonumber(key)] = value
			end
		end

		for type, info in pairs(PlayerCardEnum.ShowSettingsInfo) do
			if self["_updateShowSetting_" .. type] then
				self["_updateShowSetting_" .. type](self, infoDict[type])
			end

			local value = infoDict[type]

			if value then
				if info.isNumber then
					value = tonumber(value)
				end

				self._showSettings[type] = value
			else
				self._showSettings[type] = info.Defalut
			end
		end
	end
end

function PlayerCardMO:_updateShowSetting_3(value)
	self._skinShowEnterAnimTypeDict = {}

	if not string.nilorempty(value) then
		local split = GameUtil.splitString2(value, true, "|", "_")

		for _, v in ipairs(split) do
			local skinId = v[1]
			local type = v[2]

			if skinId and type then
				self._skinShowEnterAnimTypeDict[skinId] = type
			end
		end
	end
end

function PlayerCardMO:setShowSetting(key, value)
	self._showSettings = self._showSettings or {}
	self._showSettings[key] = value

	return self._showSettings
end

function PlayerCardMO:getShowSetting()
	return self._showSettings
end

function PlayerCardMO:getShowSettingByType(type)
	return self._showSettings and self._showSettings[type]
end

function PlayerCardMO:setHeroCount(heroCount)
	self._allHeroCount = heroCount
end

function PlayerCardMO:updateThemeId(themeId)
	self.themeId = themeId
end

function PlayerCardMO:updateProgressSetting(setting)
	self.progressSettings = setting
	self.progressSettingsDict = GameUtil.splitString2(setting, true)

	self:setEmptyPosList()
end

function PlayerCardMO:updateBaseInfoSetting(setting)
	self.baseInfoSettings = setting
	self.baseInfoSettingsDict = GameUtil.splitString2(setting, true)

	self:setEmptyBaseInfoPosList()
end

function PlayerCardMO:updateCritter(critter)
	local str = string.splitToNumber(critter, "#")
	local critterUid, critterId, isMute = str[1], str[2], str[3]

	self.critterUid = critterUid
	self.critterId = critterId

	if not self.critterId then
		return
	end

	self.critterSkinId = isMute == 1 and CritterConfig.instance:getCritterMutateSkin(tonumber(self.critterId)) or CritterConfig.instance:getCritterNormalSkin(tonumber(self.critterId))
end

function PlayerCardMO:updateAchievement(showAchievement)
	self.showAchievement = showAchievement
end

function PlayerCardMO:getShowAchievement()
	return self.showAchievement
end

function PlayerCardMO:getSelectCritterUid()
	return self.critterUid
end

function PlayerCardMO:setSelectCritterUid(uid)
	self.critterUid = uid
end

function PlayerCardMO:updateHeroCover(heroCover)
	self.heroCover = heroCover
end

function PlayerCardMO:getPlayerInfo()
	local info = self.playerInfo

	if not info and self:isSelf() then
		info = PlayerModel.instance:getPlayinfo()
	end

	return info
end

function PlayerCardMO:isSelf()
	return PlayerModel.instance:isPlayerSelf(self.userId)
end

function PlayerCardMO:setSetting(setting)
	return (string.splitToNumber(setting, "#"))
end

function PlayerCardMO:getProgressSetting()
	return self.progressSettingsDict
end

function PlayerCardMO:setEmptyBaseInfoPosList()
	self.emptyBaseInfoPosList = {
		false,
		true,
		true,
		true
	}

	if self.baseInfoSettingsDict and #self.baseInfoSettingsDict > 0 then
		for i = 1, 4 do
			for _, mo in ipairs(self.baseInfoSettingsDict) do
				if mo[1] == i then
					self.emptyBaseInfoPosList[i] = false
				end
			end
		end
	end
end

function PlayerCardMO:getEmptyBaseInfoPosList()
	return self.emptyBaseInfoPosList
end

function PlayerCardMO:setEmptyPosList()
	self.emptyPosList = {
		true,
		true,
		true,
		true,
		true
	}

	if self.progressSettingsDict and #self.progressSettingsDict > 0 then
		for i = 1, 5 do
			for _, mo in ipairs(self.progressSettingsDict) do
				if mo[1] == i then
					self.emptyPosList[i] = false
				end
			end
		end
	end
end

function PlayerCardMO:getEmptyPosList()
	return self.emptyPosList
end

function PlayerCardMO:getBaseInfoSetting()
	return self.baseInfoSettingsDict
end

function PlayerCardMO:getCritter()
	return self.critterId, self.critterSkinId
end

function PlayerCardMO:getMainHero(random)
	local mainHeroParam = self.heroCover
	local mainHeros = string.splitToNumber(mainHeroParam, "#")
	local heroId = mainHeros[1]
	local skinId = mainHeros[2]
	local isL2d = mainHeros[3] ~= 0
	local isRandom = heroId == -1

	if isRandom then
		if random or not self._tempHeroId or not self._tempSkinId then
			local heroList = HeroModel.instance:getList()
			local heroMO = heroList[math.random(#heroList)]

			if heroMO then
				local skinList = {
					heroMO.config.skinId
				}

				for _, skinInfo in ipairs(heroMO.skinInfoList) do
					table.insert(skinList, skinInfo.skin)
				end

				self._tempHeroId = heroMO.heroId
				self._tempSkinId = skinList[math.random(#skinList)]
			end
		end

		return self._tempHeroId, self._tempSkinId, true, isL2d
	else
		if not heroId or heroId == 0 or not HeroConfig.instance:getHeroCO(heroId) then
			heroId = self:getDefaultHeroId()
			skinId = nil
		end

		if (not skinId or skinId == 0) and heroId and heroId ~= 0 then
			local config = HeroConfig.instance:getHeroCO(heroId)

			skinId = config and config.skinId
		end

		self._tempHeroId = heroId
		self._tempSkinId = skinId
	end

	return heroId, skinId, isRandom, isL2d
end

function PlayerCardMO:getDefaultHeroId()
	if self:isSelf() then
		return CharacterSwitchListModel.instance:getMainHero()
	else
		return 3028
	end
end

function PlayerCardMO:getThemeId()
	return self.themeId
end

function PlayerCardMO:getProgressByIndex(index)
	if index == PlayerCardEnum.LeftContent.RougeDifficulty then
		if self.rougeDifficulty > 0 then
			return RougeConfig1.instance:getDifficultyCOTitle(self.rougeDifficulty)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.WeekWalkDeep then
		if self.weekwalkDeepLayerId > 0 then
			local mapco = WeekWalkConfig.instance:getMapConfig(self.weekwalkDeepLayerId)

			if mapco and mapco.sceneId then
				local co = lua_weekwalk_scene.configDict[mapco.sceneId]

				if co and co.typeName and co.name then
					return co.typeName .. co.name
				end
			end
		end

		return -1
	elseif index == PlayerCardEnum.LeftContent.RoomCollection then
		return self.roomCollection
	elseif index == PlayerCardEnum.LeftContent.ExploreCollection then
		return self.exploreCollection
	elseif index == PlayerCardEnum.LeftContent.Act148SSSCount then
		if self.act128SSSCount > 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_act128SSSCount"), self.act128SSSCount)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.TowerLayer then
		if self.towerLayer > 0 then
			if self.towerLayerMetre <= 500 then
				local towerco = TowerConfig.instance:getPermanentEpisodeCo(self.towerLayer)
				local temp = string.splitToNumber(towerco.episodeIds, "|")
				local curMaxPassEpisodeId = temp[#temp]
				local episodeConfig = DungeonConfig.instance:getEpisodeCO(curMaxPassEpisodeId)

				return episodeConfig.name
			else
				local co = TowerConfig.instance:getTowerPermanentTimeCo(PlayerCardEnum.TowerMaxStageId)
				local name = co and co.name

				return name .. self.towerLayerMetre .. "M"
			end
		end

		return -1
	elseif index == PlayerCardEnum.LeftContent.TowerBossPassCount then
		if self.towerBossPassCount > 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_towerbosspasscount"), self.towerBossPassCount)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.WeekwalkVer2PlatinumCup then
		if self.weekwalkVer2PlatinumCup >= 0 then
			return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("playercard_weekwalkVer2PlatinumCup"), self.weekwalkVer2PlatinumCup)
		else
			return -1
		end
	elseif index == PlayerCardEnum.LeftContent.Act128Level then
		if self.act128Level >= 0 then
			return luaLang("playercard_Act128Level") .. self.act128Level
		else
			return -1
		end
	end
end

function PlayerCardMO:getBaseInfoByIndex(index, returndesc)
	local info = self:getPlayerInfo()

	if not info then
		return
	end

	if index == PlayerCardEnum.RightContent.LoginDay then
		if returndesc then
			return info.totalLoginDays, luaLang("time_day")
		else
			local str = luaLang("time_day")

			return info.totalLoginDays .. str
		end
	elseif index == PlayerCardEnum.RightContent.HeroCount then
		return self:getHeroCount()
	elseif index == PlayerCardEnum.RightContent.CreatTime then
		return (TimeUtil.timestampToString3(ServerTime.timeInLocal(info.registerTime / 1000)))
	elseif index == PlayerCardEnum.RightContent.AssitCount then
		return self.assistTimes or 0
	elseif index == PlayerCardEnum.RightContent.CompleteConfidence then
		return self.maxFaithHeroCount or 0
	elseif index == PlayerCardEnum.RightContent.MaxLevelHero then
		return self.maxLevelHero or 0
	elseif index == PlayerCardEnum.RightContent.SkinCount then
		return self.skinCount or 0
	elseif index == PlayerCardEnum.RightContent.TotalCostPower then
		if not self.totalCostPower then
			local count = 0

			if returndesc then
				return count, luaLang("p_mainview_power")
			else
				local str = luaLang("p_mainview_power")

				return count .. str
			end
		end
	elseif index == PlayerCardEnum.RightContent.HeroCoverTimes then
		if not self.heroCoverTimes then
			local count = 0

			if returndesc then
				return count, luaLang("p_newwelfarepanelview_txt1_Title")
			else
				local str = luaLang("p_newwelfarepanelview_txt1_Title")

				return count .. str
			end
		end
	end
end

function PlayerCardMO:getHeroCount()
	return self._allHeroCount or 0
end

function PlayerCardMO:getTowerLayerMetre()
	return self.towerLayerMetre or 0
end

function PlayerCardMO:getHeroRarePercent()
	local info = self:getPlayerInfo()

	if not info then
		return nil
	end

	local AllRareNNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local AllRareNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local AllRareRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local AllRareSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local AllRareSSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)

	if AllRareNNHeroCount > 0 then
		local heroRareNNPercent = math.min(info.heroRareNNCount / AllRareNNHeroCount or 1, 1)

		if AllRareNHeroCount > 0 then
			local heroRareNPercent = math.min(info.heroRareNCount / AllRareNHeroCount or 1, 1)

			if AllRareRHeroCount > 0 then
				local heroRareRPercent = math.min(info.heroRareRCount / AllRareRHeroCount or 1, 1)

				if AllRareSRHeroCount > 0 then
					local heroRareSRPercent = math.min(info.heroRareSRCount / AllRareSRHeroCount or 1, 1)

					if AllRareSSRHeroCount > 0 then
						local heroRareSSRPercent = math.min(info.heroRareSSRCount / AllRareSSRHeroCount or 1, 1)

						return heroRareNNPercent, heroRareNPercent, heroRareRPercent, heroRareSRPercent, heroRareSSRPercent
					end
				end
			end
		end
	end
end

function PlayerCardMO:updateEquipBadge(badgeIds)
	self._badgeList = {}

	for i = 1, PlayerCardEnum.MaxEquipBadgeCount do
		table.insert(self._badgeList, (badgeIds or nil) and (badgeIds[i] or 0))
	end
end

function PlayerCardMO:getEquipBadges()
	return self._badgeList
end

function PlayerCardMO:modifyEquipBadges(badgeId)
	local index = self:getEquipIndexBadge(badgeId)
	local isModify = false

	if index > 0 then
		self._badgeList[index] = 0
		isModify = true
	else
		for i, id in ipairs(self._badgeList) do
			if id <= 0 then
				self._badgeList[i] = badgeId
				isModify = true

				break
			end
		end
	end

	return self._badgeList, isModify
end

function PlayerCardMO:getEquipBadgeIdsStr()
	local value = ""

	for i, badgeId in ipairs(self._badgeList) do
		value = i == 1 and tostring(badgeId) or value .. "|" .. badgeId
	end

	return value
end

function PlayerCardMO:isEquipBadge(id)
	return self:getEquipIndexBadge(id) > 0
end

function PlayerCardMO:getEquipIndexBadge(id)
	local list = self:getEquipBadges()

	for i, badgeId in ipairs(list) do
		if badgeId == id then
			return i
		end
	end

	return -1
end

function PlayerCardMO:setShowEnterAnimType(skinId, type)
	skinId = skinId or self:getThemeId()

	local key = PlayerCardEnum.ShowSettingsType.ShowEnterAnimType

	if self._skinShowEnterAnimTypeDict then
		self._skinShowEnterAnimTypeDict = {}
	end

	self._skinShowEnterAnimTypeDict[skinId] = type

	local value = ""

	for _skinId, _type in pairs(self._skinShowEnterAnimTypeDict) do
		value = value .. _skinId .. "_" .. _type .. "|"
	end

	local settings = self:setShowSetting(key, value)

	PlayerCardRpc.instance:sendSetPlayerCardShowSettingRequest(settings)
end

function PlayerCardMO:getShowEnterAnimType(skinId)
	skinId = skinId or self:getThemeId()

	if self._skinShowEnterAnimTypeDict then
		return self._skinShowEnterAnimTypeDict[skinId] or 1
	end

	return 1
end

return PlayerCardMO
