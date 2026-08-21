-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/model/heroskin/HeroSkinModel.lua

module("logic.extensions.charactersystem.model.heroskin.HeroSkinModel", package.seeall)

local M = class("HeroSkinModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._heroSkinData = {}
	self._heroSkinWearList = {}
	self._ownedSkinIds = {}
	self._heroId2SkinDataList = {}
	self._curSkinId = nil
end

function M:onInit()
	return
end

function M:onReset()
	table.clear(self._heroSkinData)
	table.clear(self._ownedSkinIds)
	table.clear(self._heroId2SkinDataList)
end

function M:initConfig()
	if #self._heroSkinData > 0 then
		printError("initConfig twice!")
		table.clear(self._heroSkinData)
		table.clear(self._heroSkinWearList)
	end

	local defaultClothes = CharacterConfig.instance:getCharacterDataList()

	for i = 1, #defaultClothes do
		local data = HeroSkinData.New()

		data:initByCharacterConfig(defaultClothes[i])

		local heroId = data:getHeroId()

		self._heroSkinWearList[heroId] = data

		table.insert(self._heroSkinData, data)
		self:addHeroSkinData(heroId, data)
	end

	local skinCOList = HeroSkinConfig.instance:getAllInfo()

	for _, v in pairs(skinCOList) do
		if v.id then
			local data = HeroSkinData.New()

			data:initByConfig(v)
			table.insert(self._heroSkinData, data)
			self:addHeroSkinData(data:getHeroId(), data)
		end
	end
end

function M:initAgent(heroSkinInfo)
	local data = false

	if heroSkinInfo.skinId == 0 then
		data = self:getDefaultMoByHeroId(heroSkinInfo.heroId)
	else
		data = self:getMoById(heroSkinInfo.skinId)
	end

	local heroId = heroSkinInfo.heroId
	local preData = self._heroSkinWearList[heroId]

	if preData then
		preData:setIsWear(false)
	end

	if data then
		data:setIsWear(true)

		self._heroSkinWearList[heroId] = data
	end

	local ownedSkinList = heroSkinInfo.hasbuy

	self:_refreshByAgent(ownedSkinList, heroId)
end

function M:_refreshByAgent(skinlist, heroId)
	for i = 1, #self._heroSkinData do
		local skinMO = self._heroSkinData[i]

		if skinlist then
			for _, v in pairs(skinlist) do
				if skinMO:getId() == v then
					skinMO:setIsUnlock(true)
				end
			end
		end
	end
end

function M:initAllUnlockSkins(ownedSkinIds)
	for i = 1, #ownedSkinIds do
		self._ownedSkinIds[ownedSkinIds[i]] = true

		local skinMO = self:getMoById(ownedSkinIds[i])

		if skinMO then
			skinMO:setIsUnlock(true)
		end
	end
end

function M:getIsSkinUnlock(skinId)
	return self._ownedSkinIds[skinId] or false
end

function M:getDefaultMoByHeroId(heroId)
	for i = 1, #self._heroSkinData do
		if self._heroSkinData[i]:getHeroId() == heroId and self._heroSkinData[i]:getIsDefault() then
			return self._heroSkinData[i]
		end
	end

	return nil
end

function M:getMoById(id)
	for _, v in ipairs(self._heroSkinData) do
		if v:getId() == id then
			return self._heroSkinData[_]
		end
	end

	printError("物品表缺少皮肤配置 code:", code)

	return nil
end

function M:getSkinListByHeroId(heroId)
	local skinList = {}

	for _, skinData in ipairs(self._heroId2SkinDataList[heroId] or {}) do
		if skinData:getIsOnline() then
			table.insert(skinList, skinData)
		end
	end

	return skinList
end

function M:getSaleSkinListByHero(heroId)
	local skinList = {}

	for _, skinData in ipairs(self._heroId2SkinDataList[heroId] or {}) do
		if skinData:getIsOnline() and skinData:isSale() then
			table.insert(skinList, skinData)
		end
	end

	return skinList
end

function M:getSkinMo(heroId, skinId)
	local skinList = self._heroId2SkinDataList[heroId]

	for _, v in ipairs(skinList or {}) do
		if v:getId() == skinId then
			return v
		end
	end

	return false
end

function M.skinSortFunc(moA, moB)
	if not moA or not moB then
		return false
	end

	local idA = moA:getId()
	local idB = moB:getId()

	if idA == 0 or idB == 0 then
		return idA < idB
	end

	if moA:getIsUnlock() and moB:getIsUnlock() then
		return idA < idB
	elseif moA:getIsUnlock() ~= moB:getIsUnlock() then
		return moA:getIsUnlock()
	end

	local coA = moA:isSale()
	local coB = moB:isSale()

	if coA ~= coB then
		return coA and true or false
	end

	return idA < idB
end

function M:addHeroSkinData(heroId, skinData)
	local dataList = self._heroId2SkinDataList[heroId] or {}

	table.insert(dataList, skinData)

	self._heroId2SkinDataList[heroId] = dataList
end

function M:setCurSkin(skinId)
	self._curSkinId = skinId
end

function M:getCurSkin()
	return self._curSkinId
end

M.instance = M.New()

return M
