-- chunkname: @modules/logic/character/model/HeroModel.lua

module("modules.logic.character.model.HeroModel", package.seeall)

local HeroModel = class("HeroModel", BaseModel)

function HeroModel:onInit()
	self._heroId2MODict = {}
	self._skinIdDict = {}
	self._touchHeadNumber = 0
	self._hookGetHeroId = {}
	self._hookGetHeroUid = {}
end

function HeroModel:reInit()
	self._heroId2MODict = {}
	self._skinIdDict = {}
	self._touchHeadNumber = 0
	self._hookGetHeroId = {}
	self._hookGetHeroUid = {}
end

function HeroModel:setTouchHeadNumber(count)
	self._touchHeadNumber = count
end

function HeroModel:getTouchHeadNumber()
	return self._touchHeadNumber
end

function HeroModel:addGuideHero(heroId)
	if self._heroId2MODict[heroId] then
		return
	end

	local config = HeroConfig.instance:getHeroCO(heroId)
	local heroMo = HeroMo.New()

	heroMo:init({
		heroId = heroId,
		skin = config.skinId
	}, config)

	heroMo.isGuideAdd = true
	self._heroId2MODict[heroId] = heroMo
end

function HeroModel:removeGuideHero(heroId)
	local heroMo = self._heroId2MODict[heroId]

	if heroMo and heroMo.isGuideAdd then
		self._heroId2MODict[heroId] = nil
	end
end

function HeroModel:onGetHeroList(serco)
	local moList = {}

	self._heroId2MODict = {}

	if serco then
		for _, v in ipairs(serco) do
			local config = HeroConfig.instance:getHeroCO(v.heroId)
			local heroMo = HeroMo.New()

			heroMo:init(v, config)
			table.insert(moList, heroMo)

			self._heroId2MODict[heroMo.heroId] = heroMo
		end
	end

	self:setList(moList)
end

function HeroModel:onGetSkinList(allHeroSkin)
	self._skinIdDict = {}

	if allHeroSkin then
		for _, v in ipairs(allHeroSkin) do
			self._skinIdDict[v] = true
		end
	end
end

function HeroModel:onGainSkinList(skinId)
	self._skinIdDict[skinId] = true

	CharacterController.instance:dispatchEvent(CharacterEvent.GainSkin, skinId)
end

function HeroModel:setHeroFavorState(heroId, isFavor)
	local heroMo = self:getByHeroId(heroId)

	heroMo.isFavor = isFavor
end

function HeroModel:setHeroLevel(heroId, lv)
	local heroMO = self:getByHeroId(heroId)

	heroMO.level = lv
end

function HeroModel:setHeroRank(heroId, rank)
	local heroMO = self:getByHeroId(heroId)

	heroMO.rank = rank
end

function HeroModel:onSetHeroChange(serco)
	if serco then
		local moList

		for _, v in ipairs(serco) do
			local existMo = self:getById(v.uid)

			if not existMo then
				local config = HeroConfig.instance:getHeroCO(v.heroId)
				local heroMo = HeroMo.New()

				heroMo:init(v, config)

				moList = moList or {}

				table.insert(moList, heroMo)

				self._heroId2MODict[heroMo.heroId] = heroMo
			else
				existMo:update(v)
			end
		end

		if moList then
			self:addList(moList)
		end
	end
end

function HeroModel:_sortSpecialTouch(voice, type)
	local sortList = {}

	for _, v in pairs(voice) do
		if v.type == type then
			table.insert(sortList, v)
		end
	end

	self._specialSortRule = self._specialSortRule or {
		2,
		1,
		3
	}

	table.sort(sortList, function(a, b)
		return self._specialSortRule[tonumber(a.param)] > self._specialSortRule[tonumber(b.param)]
	end)

	return sortList
end

function HeroModel:getVoiceConfig(heroId, type, verifyCallback, targetSkinId)
	local hero = self:getByHeroId(heroId)

	if not hero then
		print("======not hero:", heroId)

		return
	end

	local voice = self:getHeroAllVoice(heroId, targetSkinId)

	if not voice or not next(voice) then
		return {}
	end

	if type == CharacterEnum.VoiceType.MainViewSpecialTouch then
		voice = self:_sortSpecialTouch(voice, type)
	end

	local result = {}

	for _, v in pairs(voice) do
		if v.type == type then
			if not verifyCallback then
				table.insert(result, v)
			else
				local status, callResult = xpcall(verifyCallback, __G__TRACKBACK__, v)

				if status and callResult then
					table.insert(result, v)
				end
			end
		end
	end

	return result
end

function HeroModel:getHeroAllVoice(heroId, targetSkinId)
	local voiceList = {}
	local colist = CharacterDataConfig.instance:getCharacterVoicesCo(heroId)
	local heroInfo = self:getByHeroId(heroId)

	if not colist then
		return voiceList
	end

	for _, config in pairs(colist) do
		if self:_checkSkin(heroInfo, config, targetSkinId) then
			local audio = config.audio

			if config.type == CharacterEnum.VoiceType.GetSkin and string.nilorempty(config.unlockCondition) and not string.nilorempty(config.param) then
				local skinId = tonumber(config.param)

				if heroInfo then
					for i, skinInfoMO in ipairs(heroInfo.skinInfoList) do
						if skinInfoMO.skin == skinId then
							voiceList[audio] = config

							break
						end
					end
				end
			elseif config.type == CharacterEnum.VoiceType.BreakThrough and string.nilorempty(config.unlockCondition) then
				if heroInfo and heroInfo.rank >= 2 then
					voiceList[audio] = config
				end
			elseif self:_cleckCondition(config.unlockCondition, heroId, audio) then
				voiceList[audio] = config
			end
		end
	end

	if heroInfo then
		local voices = heroInfo.voice

		for _, v in pairs(voices) do
			if not voiceList[v] then
				local config = CharacterDataConfig.instance:getCharacterVoiceCO(heroId, v)

				if self:_checkSkin(heroInfo, config, targetSkinId) then
					voiceList[v] = config
				end
			end
		end
	end

	return voiceList
end

function HeroModel:_checkSkin(heroMo, config, targetSkinId)
	if not config then
		return false
	end

	if heroMo and config.stateCondition ~= 0 then
		local defaultValue = CharacterVoiceController.instance:getDefaultValue(heroMo.heroId)
		local state = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.SkinState, heroMo.heroId, defaultValue)

		if config.stateCondition ~= state then
			return false
		end
	end

	if string.nilorempty(config.skins) then
		return true
	end

	return string.find(config.skins, targetSkinId or heroMo and heroMo.skin)
end

function HeroModel:_cleckCondition(condition, heroId, audio)
	if string.nilorempty(condition) then
		return true
	end

	local hero = self:getByHeroId(heroId)

	if hero then
		if not hero.faith then
			local faith = 0
			local faithPercent = HeroConfig.instance:getFaithPercent(faith)[1]
			local value = string.split(condition, "#")

			if tonumber(value[1]) == 1 then
				local value2 = tonumber(value[2])

				if value2 then
					return value2 <= faithPercent * 100
				else
					logError(string.format("HeroModel:_cleckCondition error condition:%s heroId:%s audio:%s", condition, heroId, audio))

					return false
				end
			end

			return true
		end
	end
end

function HeroModel:addHookGetHeroId(func)
	self._hookGetHeroId[func] = func
end

function HeroModel:removeHookGetHeroId(func)
	self._hookGetHeroId[func] = nil
end

function HeroModel:addHookGetHeroUid(func)
	self._hookGetHeroUid[func] = func
end

function HeroModel:removeHookGetHeroUid(func)
	self._hookGetHeroUid[func] = nil
end

function HeroModel:getById(id)
	for k, v in pairs(self._hookGetHeroUid) do
		local result = k(id)

		if result then
			return result
		end
	end

	return HeroModel.super.getById(self, id)
end

function HeroModel:getByHeroId(heroId)
	for k, v in pairs(self._hookGetHeroId) do
		local result = k(heroId)

		if result then
			return result
		end
	end

	return self._heroId2MODict[heroId]
end

function HeroModel:getAllHero()
	return self._heroId2MODict
end

function HeroModel:getAllFavorHeros()
	local heros = {}

	for _, v in pairs(self._heroId2MODict) do
		if v.isFavor then
			table.insert(heros, v.heroId)
		end
	end

	return heros
end

function HeroModel:checkHasSkin(skinId)
	if self._skinIdDict[skinId] then
		return true
	end

	local skinCo = SkinConfig.instance:getSkinCo(skinId)
	local heroMO = skinCo and self:getByHeroId(skinCo.characterId)

	if heroMO then
		if heroMO.config.skinId == skinId then
			return true
		end

		for i, skin in ipairs(heroMO.skinInfoList) do
			if skin.skin == skinId then
				return true
			end
		end
	end

	return false
end

function HeroModel:getAllHeroGroup()
	local herogroup = {}

	for _, v in pairs(self._heroId2MODict) do
		local num = string.byte(v.config.initials)

		if herogroup[num] == nil then
			herogroup[num] = {}
		end

		table.insert(herogroup[num], v.heroId)
		table.sort(herogroup[num], function(a, b)
			local arare = self:getByHeroId(a).config.rare
			local brare = self:getByHeroId(b).config.rare

			if arare == brare then
				return a < b
			else
				return brare < arare
			end
		end)
	end

	return herogroup
end

function HeroModel:checkGetRewards(heroId, id)
	local unlockItem = self._heroId2MODict[heroId].itemUnlock

	for i = 1, #unlockItem do
		if unlockItem[i] == id then
			return true
		end
	end

	return false
end

function HeroModel:getCurrentSkinConfig(heroId)
	local config = SkinConfig.instance:getSkinCo(self:getCurrentSkinId(heroId))

	if config then
		return config
	else
		logError("获取当前角色的皮肤配置失败， heroId : " .. tonumber(heroId))
	end
end

function HeroModel:getCurrentSkinId(heroId)
	local skinId = self._heroId2MODict[heroId].skin

	if not skinId then
		logError("获取当前角色的皮肤Id失败， heroId : " .. tonumber(heroId))
	end

	return skinId
end

function HeroModel:getHighestLevel()
	local highestLevel = 0

	for _, heroMO in pairs(self._heroId2MODict) do
		if highestLevel < heroMO.level then
			highestLevel = heroMO.level
		end
	end

	return highestLevel
end

function HeroModel:takeoffAllTalentCube(heroId)
	local hero = self:getByHeroId(heroId)

	if not hero then
		logError("找不到英雄!!!  id:", heroId)

		return
	end

	hero:clearCubeData()
end

function HeroModel:getCurTemplateId(heroId)
	local heroMo = self:getByHeroId(heroId)

	return (heroMo or nil) and (heroMo.useTalentTemplateId or 1)
end

function HeroModel:isMaxExSkill(heroId, withArtificeCount)
	local result = false
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return result
	end

	local exSkillLevel = heroMo.exSkillLevel

	if withArtificeCount then
		local artificeCount = 0
		local duplicateItem = heroMo.config.duplicateItem

		if not string.nilorempty(duplicateItem) then
			local items = string.split(duplicateItem, "|")
			local item = items[1]

			if item then
				local itemParams = string.splitToNumber(item, "#")

				artificeCount = ItemModel.instance:getItemQuantity(itemParams[1], itemParams[2])
			end
		end

		exSkillLevel = exSkillLevel + artificeCount
	end

	result = exSkillLevel >= CharacterEnum.MaxSkillExLevel

	return result
end

function HeroModel:getHeroSkillCount(heroId, withArtificeCount)
	local result = 0
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if not heroMo then
		return result
	end

	local exSkillLevel = heroMo.exSkillLevel

	if withArtificeCount then
		local artificeCount = 0
		local duplicateItem = heroMo.config.duplicateItem

		if not string.nilorempty(duplicateItem) then
			local items = string.split(duplicateItem, "|")
			local item = items[1]

			if item then
				local itemParams = string.splitToNumber(item, "#")

				artificeCount = ItemModel.instance:getItemQuantity(itemParams[1], itemParams[2])
			end
		end

		exSkillLevel = exSkillLevel + artificeCount
	end

	result = exSkillLevel

	return exSkillLevel
end

HeroModel.instance = HeroModel.New()

return HeroModel
