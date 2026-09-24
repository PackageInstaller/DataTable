-- chunkname: @modules/logic/character/model/skin/CharacterPastModel.lua

module("modules.logic.character.model.skin.CharacterPastModel", package.seeall)

local CharacterPastModel = class("CharacterPastModel", BaseModel)

function CharacterPastModel:onInit()
	self:reInit()
end

function CharacterPastModel:reInit()
	self._pastSkinItems = nil
end

function CharacterPastModel:getHeroPastSkins(heroId)
	local pastDict = self:hadPastSkins()

	return pastDict[heroId]
end

function CharacterPastModel:isPastSkin(heroId, skinId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId)

	if skinCo and skinCo.isPast == 1 then
		return true
	end
end

function CharacterPastModel:isHasPastSkin(heroId, skinId)
	local pastDict = self:getHeroPastSkins(heroId)

	if pastDict and LuaUtil.tableContains(pastDict, skinId) then
		return true
	end

	local isPastSkin = self:isPastSkin(heroId, skinId)

	if not isPastSkin then
		return false
	end

	local count = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.HeroSkin, skinId) or 0

	if count > 0 then
		return true
	end
end

function CharacterPastModel:hasPastSkinsByHeroId(heroId)
	local skins = self:getHeroPastSkins(heroId)

	return skins and #skins > 0
end

function CharacterPastModel:hadPastSkins()
	local items = ItemModel.instance:getItemsBySubType(ItemEnum.SubType.CharacterPast)

	return self:hadPastSkinsByItems(items)
end

function CharacterPastModel:hadPastSkinsByItems(items)
	local pastDict = {}

	if items then
		for _, item in pairs(items) do
			local info = self:getPastHeroSkinByItemId(item.id)

			if info then
				for _, v in ipairs(info) do
					local heroId = v[1]
					local skinId = v[2]

					pastDict[heroId] = pastDict[heroId] or {}

					table.insert(pastDict[heroId], skinId)
				end
			end
		end
	end

	return pastDict
end

function CharacterPastModel:getPastHeroSkinByItemId(itemId)
	self._pastSkinItems = self._pastSkinItems or {}

	if not self._pastSkinItems[itemId] then
		local co = ItemConfig.instance:getItemCo(itemId)
		local effect = co and co.effect

		if not string.nilorempty(effect) then
			self._pastSkinItems[itemId] = GameUtil.splitString2(effect, true)
		end
	end

	return self._pastSkinItems[itemId]
end

function CharacterPastModel:getVoiceConfig(heroId, type, verifyCallback, skinId)
	local voice = self:getHeroAllVoice(heroId, skinId)

	if not voice or not next(voice) then
		return {}
	end

	if type == CharacterEnum.VoiceType.MainViewSpecialTouch then
		voice = HeroModel.instance:_sortSpecialTouch(voice, type)
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

function CharacterPastModel:getHeroAllVoice(heroId, targetSkinId)
	local voiceList = {}
	local colist = CharacterDataConfig.instance:getCharacterPostCOs(heroId)

	if not colist then
		return voiceList
	end

	for i, config in pairs(colist) do
		if self:_checkSkin(heroId, config, targetSkinId) then
			local audio = config.audio

			voiceList[audio] = config
		end
	end

	return voiceList
end

function CharacterPastModel:_checkSkin(heroId, config, targetSkinId)
	if not config then
		return false
	end

	if string.nilorempty(config.skins) then
		return true
	end

	return string.find(config.skins, targetSkinId)
end

function CharacterPastModel:checkPopupCharacterPastSkinGainView(materialDataMOList)
	if not materialDataMOList then
		return
	end

	local hasPast = false

	for _, mo in ipairs(materialDataMOList) do
		local config = ItemConfig.instance:getItemConfig(mo.materilType, mo.materilId)

		if config and config.subType == ItemEnum.SubType.CharacterPast then
			local info = self:getPastHeroSkinByItemId(mo.materilId)

			if info then
				for _, v in ipairs(info) do
					local heroId = v[1]
					local skinId = v[2]
					local param = {
						heroId = heroId,
						skinId = skinId,
						materialDataMOList = materialDataMOList
					}

					PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropConvertView, ViewName.CharacterPastSkinGainView, param)

					hasPast = true
				end
			end
		end
	end

	return hasPast
end

function CharacterPastModel:getHeroAllPastSkins(heroId)
	self._heroPastSkins = self._heroPastSkins or {}

	if not self._heroPastSkins[heroId] then
		self._heroPastSkins[heroId] = {}

		local cos = SkinConfig.instance:getCharacterSkinCoList(heroId)

		if cos then
			for _, co in ipairs(cos) do
				if co.isPast == 1 then
					table.insert(self._heroPastSkins[heroId], co.id)
				end
			end
		end
	end

	return self._heroPastSkins[heroId]
end

CharacterPastModel.instance = CharacterPastModel.New()

return CharacterPastModel
