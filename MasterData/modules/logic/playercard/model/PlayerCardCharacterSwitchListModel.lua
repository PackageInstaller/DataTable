-- chunkname: @modules/logic/playercard/model/PlayerCardCharacterSwitchListModel.lua

module("modules.logic.playercard.model.PlayerCardCharacterSwitchListModel", package.seeall)

local PlayerCardCharacterSwitchListModel = class("PlayerCardCharacterSwitchListModel", ListScrollModel)

function PlayerCardCharacterSwitchListModel:onInit()
	self._tempHeroId = nil
	self._tempSkinId = nil
end

function PlayerCardCharacterSwitchListModel:reInit()
	self._tempHeroId = nil
	self._tempSkinId = nil
end

function PlayerCardCharacterSwitchListModel:initHeroList()
	self._mainHeroList = {}
	self.curHeroId = nil

	local heroList = HeroModel.instance:getList()

	for i, heroMO in ipairs(heroList) do
		local defaultMainHeroMO = CharacterMainHeroMO.New()

		defaultMainHeroMO:init(heroMO, heroMO.config.skinId, false)
		table.insert(self._mainHeroList, defaultMainHeroMO)
	end
end

function PlayerCardCharacterSwitchListModel:_isDefaultSkinId(mainHeroMO)
	return mainHeroMO.skinId == mainHeroMO.heroMO.config.skinId
end

function PlayerCardCharacterSwitchListModel:_commonSort(a, b)
	if a.heroMO.heroId == self.curHeroId then
		return true
	end

	if b.heroMO.heroId == self.curHeroId then
		return false
	end

	if a.heroMO.heroId == b.heroMO.heroId then
		return self:_isDefaultSkinId(a) and not self:_isDefaultSkinId(b)
	end

	return nil
end

function PlayerCardCharacterSwitchListModel:sortByTime(asceTime)
	table.sort(self._mainHeroList, function(a, b)
		local result = self:_commonSort(a, b)

		if result ~= nil then
			return result
		end

		if a.heroMO.createTime ~= b.heroMO.createTime then
			if asceTime then
				return a.heroMO.createTime < b.heroMO.createTime
			else
				return a.heroMO.createTime > b.heroMO.createTime
			end
		end

		return a.heroMO.heroId < b.heroMO.heroId
	end)
	self:setList(self._mainHeroList)
end

function PlayerCardCharacterSwitchListModel:sortByRare(asceRare)
	table.sort(self._mainHeroList, function(a, b)
		local result = self:_commonSort(a, b)

		if result ~= nil then
			return result
		end

		if a.heroMO.config.rare == b.heroMO.config.rare then
			return a.heroMO.config.id < b.heroMO.config.id
		end

		if a.heroMO.config.rare ~= b.heroMO.config.rare then
			if asceRare then
				return a.heroMO.config.rare < b.heroMO.config.rare
			else
				return a.heroMO.config.rare > b.heroMO.config.rare
			end
		end

		return a.heroMO.heroId < b.heroMO.heroId
	end)
	self:setList(self._mainHeroList)
end

function PlayerCardCharacterSwitchListModel:getMoByHeroId(heroId)
	if not self._mainHeroList then
		return
	end

	for i, v in ipairs(self._mainHeroList) do
		if not v.heroMO and not heroId or v.heroMO and v.heroMO.heroId == heroId then
			return v
		end
	end
end

function PlayerCardCharacterSwitchListModel:getMoByHero(heroId, skinId)
	if not self._mainHeroList then
		return
	end

	for i, v in ipairs(self._mainHeroList) do
		if skinId and v.skinId == skinId then
			return v
		end

		if not skinId and v.heroMO.heroId and v.skinId == v.heroMO.config.skinId then
			return v
		end
	end
end

function PlayerCardCharacterSwitchListModel:changeMainHero(heroId, skinId, isRandom, isL2d)
	heroId = heroId and tonumber(heroId)
	skinId = skinId and tonumber(skinId)

	local l2dKey = isL2d and 1 or 0

	if not skinId or skinId == 0 then
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)

		skinId = heroConfig.skinId
	end

	local mainHeroParam = table.concat({
		heroId,
		skinId,
		l2dKey
	}, "#")

	if not string.nilorempty(mainHeroParam) then
		local flag = PlayerCardModel.instance:isCharacterSwitchFlag()

		if flag == nil then
			ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchTipsView, {
				heroParam = mainHeroParam
			})
		else
			self:changeMainHeroByParam(mainHeroParam, flag)
		end
	end
end

function PlayerCardCharacterSwitchListModel:changeMainHeroByParam(heroParam, flag)
	if string.nilorempty(heroParam) then
		return
	end

	if flag then
		local param = string.splitToNumber(heroParam, "#")
		local heroId = param[1]
		local skinId = param[2]

		CharacterSwitchListModel.instance:changeMainHero(heroId, skinId)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshMainHeroSkin)
		CharacterController.instance:dispatchEvent(CharacterEvent.MainThumbnailSignature, heroId)
	end

	PlayerCardRpc.instance:sendSetPlayerCardHeroCoverRequest(heroParam)
end

PlayerCardCharacterSwitchListModel.instance = PlayerCardCharacterSwitchListModel.New()

return PlayerCardCharacterSwitchListModel
