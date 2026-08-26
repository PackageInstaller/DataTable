-- chunkname: @modules/logic/room/model/interact/RoomInteractCharacterListModel.lua

module("modules.logic.room.model.interact.RoomInteractCharacterListModel", package.seeall)

local RoomInteractCharacterListModel = class("RoomInteractCharacterListModel", ListScrollModel)

function RoomInteractCharacterListModel:onInit()
	self:_clearData()
end

function RoomInteractCharacterListModel:reInit()
	self:_clearData()
end

function RoomInteractCharacterListModel:clear()
	RoomInteractCharacterListModel.super.clear(self)
	self:_clearData()
end

function RoomInteractCharacterListModel:_clearData()
	self:clearMapData()
	self:clearFilterData()

	self._heroMODict = nil
end

function RoomInteractCharacterListModel:clearMapData()
	RoomInteractCharacterListModel.super.clear(self)

	self._selectHeroId = nil
end

function RoomInteractCharacterListModel:clearFilterData()
	self._filterCareerDict = {}
	self._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

function RoomInteractCharacterListModel:setCharacterList()
	local moList = {}
	local heroMOList = HeroModel.instance:getList()

	self._heroMODict = self._heroMODict or {}

	local tRoomInteractBuildingModel = RoomInteractBuildingModel.instance

	for i, heroMO in ipairs(heroMOList) do
		local career = heroMO.config.career
		local roomCharacterConfig = RoomConfig.instance:getRoomCharacterConfig(heroMO.skin)
		local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroMO.heroId)

		if roomCharacterConfig and roomCharacterMO then
			local heroId = heroMO.heroId
			local isFilterCareer = self:isFilterCareer(career)

			if isFilterCareer then
				local interactCharacterMO = self._heroMODict[heroId]

				if not interactCharacterMO then
					interactCharacterMO = RoomInteractCharacterMO.New()

					interactCharacterMO:init({
						use = false,
						heroId = heroId
					})

					self._heroMODict[heroId] = interactCharacterMO
				end

				interactCharacterMO.use = tRoomInteractBuildingModel:isSelectHeroId(heroId)

				table.insert(moList, interactCharacterMO)
			end
		end
	end

	table.sort(moList, self:_getSortFunction())
	self:setList(moList)
	self:_refreshSelect()
end

function RoomInteractCharacterListModel:updateCharacterList()
	local moList = self:getList()
	local tRoomInteractBuildingModel = RoomInteractBuildingModel.instance

	for _, mo in ipairs(moList) do
		mo.use = tRoomInteractBuildingModel:isSelectHeroId(mo.heroId)
	end

	self:onModelUpdate()
end

function RoomInteractCharacterListModel:_getSortFunction()
	if self._sortFunc then
		return self._sortFunc
	end

	function self._sortFunc(a, b)
		if a.heroConfig.rare ~= b.heroConfig.rare then
			local order = self:getOrder()

			if order == RoomCharacterEnum.CharacterOrderType.RareUp then
				return a.heroConfig.rare < b.heroConfig.rare
			elseif order == RoomCharacterEnum.CharacterOrderType.RareDown then
				return a.heroConfig.rare > b.heroConfig.rare
			end
		end

		if a.id ~= b.id then
			return a.id < b.id
		end
	end

	return self._sortFunc
end

function RoomInteractCharacterListModel:setOrder(order)
	self._order = order
end

function RoomInteractCharacterListModel:getOrder()
	return self._order
end

function RoomInteractCharacterListModel:setFilterCareer(careerList)
	self._filterCareerDict = {}

	if careerList and #careerList > 0 then
		for i, career in ipairs(careerList) do
			self._filterCareerDict[career] = true
		end
	end
end

function RoomInteractCharacterListModel:getFilterCareer()
	for k, v in pairs(self._filterCareerDict) do
		if v == true then
			return k
		end
	end
end

function RoomInteractCharacterListModel:isFilterCareer(career)
	return self:isFilterCareerEmpty() or self._filterCareerDict[career]
end

function RoomInteractCharacterListModel:isFilterCareerEmpty()
	return not LuaUtil.tableNotEmpty(self._filterCareerDict)
end

function RoomInteractCharacterListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectHeroId = nil
end

function RoomInteractCharacterListModel:_refreshSelect()
	local selectMO
	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.id == self._selectHeroId then
			selectMO = mo
		end
	end

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomInteractCharacterListModel:setSelect(characterUid)
	self._selectHeroId = characterUid

	self:_refreshSelect()
end

function RoomInteractCharacterListModel:initCharacter()
	self:setCharacterList()
end

function RoomInteractCharacterListModel:initFilter()
	self:setFilterCareer()
end

function RoomInteractCharacterListModel:initOrder()
	self._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

RoomInteractCharacterListModel.instance = RoomInteractCharacterListModel.New()

return RoomInteractCharacterListModel
