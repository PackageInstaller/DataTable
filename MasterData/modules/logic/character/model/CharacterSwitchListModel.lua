-- chunkname: @modules/logic/character/model/CharacterSwitchListModel.lua

module("modules.logic.character.model.CharacterSwitchListModel", package.seeall)

local CharacterSwitchListModel = class("CharacterSwitchListModel", ListScrollModel)

function CharacterSwitchListModel:onInit()
	self._tempHeroId = nil
	self._tempSkinId = nil
end

function CharacterSwitchListModel:reInit()
	self._tempHeroId = nil
	self._tempSkinId = nil
end

function CharacterSwitchListModel:initHeroList()
	self._mainHeroList = {}
	self.curHeroId = nil

	local randomMo = CharacterMainHeroMO.New()

	randomMo:init(nil, 0, true)
	table.insert(self._mainHeroList, randomMo)

	local heroList = HeroModel.instance:getList()

	for i, heroMO in ipairs(heroList) do
		local defaultMainHeroMO = CharacterMainHeroMO.New()

		defaultMainHeroMO:init(heroMO, heroMO.config.skinId, false)
		table.insert(self._mainHeroList, defaultMainHeroMO)
	end
end

function CharacterSwitchListModel:_isDefaultSkinId(mainHeroMO)
	return mainHeroMO.skinId == mainHeroMO.heroMO.config.skinId
end

function CharacterSwitchListModel:_commonSort(a, b)
	if a.isRandom then
		return true
	end

	if b.isRandom then
		return false
	end

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

function CharacterSwitchListModel:sortByTime(asceTime)
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

function CharacterSwitchListModel:sortByRare(asceRare)
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

function CharacterSwitchListModel:getMoByHeroId(heroId)
	if not self._mainHeroList then
		return
	end

	for i, v in ipairs(self._mainHeroList) do
		if not v.heroMO and not heroId or v.heroMO and v.heroMO.heroId == heroId then
			return v
		end
	end
end

function CharacterSwitchListModel:getMoByHero(heroId, skinId)
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

function CharacterSwitchListModel:getMainHero(random)
	local mainHeroParam = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainHero)
	local mainHeros = string.splitToNumber(mainHeroParam, "#")
	local heroId = mainHeros[1]
	local skinId = mainHeros[2]
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

				CharacterController.instance:dispatchEvent(CharacterEvent.RandomMainHero, self._tempHeroId, self._tempSkinId)
			end
		else
			return self._tempHeroId, self._tempSkinId, true
		end
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

	local newMainHeroParam = ""

	if heroId then
		newMainHeroParam = tostring(heroId)

		if skinId then
			newMainHeroParam = newMainHeroParam .. "#" .. tostring(skinId)
		end
	end

	if not string.nilorempty(newMainHeroParam) and newMainHeroParam ~= mainHeroParam then
		PlayerModel.instance:forceSetSimpleProperty(PlayerEnum.SimpleProperty.MainHero, newMainHeroParam)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.MainHero, newMainHeroParam)
	end

	return heroId, skinId, isRandom
end

function CharacterSwitchListModel:getDefaultHeroId()
	local defaultHeroId = CommonConfig.instance:getConstNum(ConstEnum.MainViewDefaultHeroId)
	local heroList = HeroModel.instance:getList()

	if #heroList > 0 then
		if not heroList[1].config.id then
			local minHeroId

			for i, v in ipairs(heroList) do
				local id = v.config.id

				if id == defaultHeroId then
					return defaultHeroId
				end

				if id < minHeroId then
					minHeroId = id
				end
			end

			return minHeroId
		end
	end
end

function CharacterSwitchListModel:changeMainHero(heroId, skinId, isRandom)
	heroId = heroId and tonumber(heroId)
	skinId = skinId and tonumber(skinId)

	if isRandom then
		heroId = -1
		skinId = -1
	elseif not skinId or skinId == 0 then
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)

		skinId = heroConfig.skinId
	end

	local mainHeroParam = ""

	if heroId then
		mainHeroParam = tostring(heroId)

		if skinId then
			mainHeroParam = mainHeroParam .. "#" .. tostring(skinId)
		end
	end

	if not string.nilorempty(mainHeroParam) then
		PlayerModel.instance:forceSetSimpleProperty(PlayerEnum.SimpleProperty.MainHero, mainHeroParam)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.MainHero, tostring(mainHeroParam))
		CharacterController.instance:dispatchEvent(CharacterEvent.ChangeMainHero)
	end
end

CharacterSwitchListModel.instance = CharacterSwitchListModel.New()

return CharacterSwitchListModel
