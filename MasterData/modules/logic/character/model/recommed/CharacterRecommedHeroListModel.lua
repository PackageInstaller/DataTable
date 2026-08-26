-- chunkname: @modules/logic/character/model/recommed/CharacterRecommedHeroListModel.lua

module("modules.logic.character.model.recommed.CharacterRecommedHeroListModel", package.seeall)

local CharacterRecommedHeroListModel = class("CharacterRecommedHeroListModel", ListScrollModel)

function CharacterRecommedHeroListModel:onInit()
	self:reInit()
end

function CharacterRecommedHeroListModel:reInit()
	self._levelAscend = false
	self._rareAscend = false
end

function CharacterRecommedHeroListModel:setMoList(heroId)
	local moList = {}

	for _, mo in pairs(CharacterRecommedModel.instance:getAllHeroRecommendMos()) do
		if mo:isOwnHero() then
			table.insert(moList, mo)
		end
	end

	self._selectheroId = heroId

	self:_sortByLevel(moList)
	self:setList(moList)
end

function CharacterRecommedHeroListModel:selectById(id)
	local mo = self:getById(id)
	local index = self:getIndex(mo)

	self:selectCell(index, true)
end

function CharacterRecommedHeroListModel:_sortByLevel(moList)
	moList = moList or self:getList()

	table.sort(moList, function(a_heroMo, b_heroMo)
		local a_heroId = a_heroMo.heroId
		local b_heroId = b_heroMo.heroId

		if not a_heroMo or not b_heroMo then
			return b_heroId < a_heroId
		end

		local a_isFavor = a_heroMo:isFavor()
		local b_isFavor = b_heroMo:isFavor()

		if a_isFavor ~= b_isFavor then
			return a_isFavor
		end

		local a_level = a_heroMo:getHeroLevel()
		local b_level = b_heroMo:getHeroLevel()

		if a_level ~= b_level then
			if self._levelAscend then
				return a_level < b_level
			else
				return b_level < a_level
			end
		end

		local a_rare = a_heroMo:getHeroConfig().rare
		local b_rare = b_heroMo:getHeroConfig().rare

		if a_rare ~= b_rare then
			return b_rare < a_rare
		end

		local a_exSkillLevel = a_heroMo:getExSkillLevel()
		local b_exSkillLevel = b_heroMo:getExSkillLevel()

		if a_exSkillLevel ~= b_exSkillLevel then
			return b_exSkillLevel < a_exSkillLevel
		end

		return b_heroId < a_heroId
	end)
end

function CharacterRecommedHeroListModel:_sortByRare(moList)
	moList = moList or self:getList()

	table.sort(moList, function(a_heroMo, b_heroMo)
		local a_heroId = a_heroMo.heroId
		local b_heroId = b_heroMo.heroId

		if not a_heroMo or not b_heroMo then
			return b_heroId < a_heroId
		end

		local a_isFavor = a_heroMo:isFavor()
		local b_isFavor = b_heroMo:isFavor()

		if a_isFavor ~= b_isFavor then
			return a_isFavor
		end

		local a_rare = a_heroMo:getHeroConfig().rare
		local b_rare = b_heroMo:getHeroConfig().rare

		if a_rare ~= b_rare then
			if self._rareAscend then
				return a_rare < b_rare
			else
				return b_rare < a_rare
			end
		end

		local a_level = a_heroMo:getHeroLevel()
		local b_level = b_heroMo:getHeroLevel()

		if a_level ~= b_level then
			return b_level < a_level
		end

		local a_exSkillLevel = a_heroMo:getExSkillLevel()
		local b_exSkillLevel = b_heroMo:getExSkillLevel()

		if a_exSkillLevel ~= b_exSkillLevel then
			return b_exSkillLevel < a_exSkillLevel
		end

		return b_heroId < a_heroId
	end)
end

function CharacterRecommedHeroListModel:setSortLevel()
	self._levelAscend = not self._levelAscend

	self:_sortByLevel()
	self:onModelUpdate()
end

function CharacterRecommedHeroListModel:setSortByRare()
	self._rareAscend = not self._rareAscend

	self:_sortByRare()
	self:onModelUpdate()
end

function CharacterRecommedHeroListModel:getSortStatus()
	return self._levelAscend, self._rareAscend
end

CharacterRecommedHeroListModel.instance = CharacterRecommedHeroListModel.New()

return CharacterRecommedHeroListModel
