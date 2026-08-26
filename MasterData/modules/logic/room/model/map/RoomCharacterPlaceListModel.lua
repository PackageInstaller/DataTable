-- chunkname: @modules/logic/room/model/map/RoomCharacterPlaceListModel.lua

module("modules.logic.room.model.map.RoomCharacterPlaceListModel", package.seeall)

local RoomCharacterPlaceListModel = class("RoomCharacterPlaceListModel", ListScrollModel)

function RoomCharacterPlaceListModel:onInit()
	self:_clearData()
end

function RoomCharacterPlaceListModel:reInit()
	self:_clearData()
end

function RoomCharacterPlaceListModel:clear()
	RoomCharacterPlaceListModel.super.clear(self)
	self:_clearData()
end

function RoomCharacterPlaceListModel:_clearData()
	self:clearMapData()
	self:clearFilterData()
end

function RoomCharacterPlaceListModel:clearMapData()
	RoomCharacterPlaceListModel.super.clear(self)

	self._selectHeroId = nil
end

function RoomCharacterPlaceListModel:clearFilterData()
	self._filterCareerDict = {}
	self._order = RoomCharacterEnum.CharacterOrderType.RareDown

	self:setIsFilterOnBirthday()
end

function RoomCharacterPlaceListModel:setCharacterPlaceList()
	local moList = {}
	local heroMOList = HeroModel.instance:getList()

	for i, heroMO in ipairs(heroMOList) do
		local career = heroMO.config.career
		local roomCharacterConfig = RoomConfig.instance:getRoomCharacterConfig(heroMO.skin)

		if roomCharacterConfig then
			local isFilterCareer = self:isFilterCareer(career)
			local isFilterBirthday = self:isFilterBirthday(heroMO.heroId)

			if isFilterBirthday and isFilterCareer then
				local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroMO.heroId)
				local use = roomCharacterMO and roomCharacterMO:isPlaceSourceState() and (roomCharacterMO.characterState == RoomCharacterEnum.CharacterState.Map or roomCharacterMO.characterState == RoomCharacterEnum.CharacterState.Revert)
				local CharacterPlaceMO = RoomCharacterPlaceMO.New()

				CharacterPlaceMO:init({
					heroId = heroMO.heroId,
					use = use
				})
				table.insert(moList, CharacterPlaceMO)
			end
		end
	end

	table.sort(moList, self._sortFunction)
	self:setList(moList)
	self:_refreshSelect()
end

function RoomCharacterPlaceListModel._sortFunction(x, y)
	if x.use and not y.use then
		return true
	elseif not x.use and y.use then
		return false
	end

	local selectHeroId = RoomCharacterPlaceListModel.instance._selectHeroId

	if selectHeroId and not x.use and not y.use then
		if x.heroId == selectHeroId and y.heroId ~= selectHeroId then
			return true
		elseif x.heroId ~= selectHeroId and y.heroId == selectHeroId then
			return false
		end
	end

	local order = RoomCharacterPlaceListModel.instance:getOrder()

	if order == RoomCharacterEnum.CharacterOrderType.RareUp and x.heroConfig.rare ~= y.heroConfig.rare then
		return x.heroConfig.rare < y.heroConfig.rare
	elseif order == RoomCharacterEnum.CharacterOrderType.RareDown and x.heroConfig.rare ~= y.heroConfig.rare then
		return x.heroConfig.rare > y.heroConfig.rare
	end

	local xFaith = HeroConfig.instance:getFaithPercent(x.heroMO.faith)[1]
	local yFaith = HeroConfig.instance:getFaithPercent(y.heroMO.faith)[1]

	if order == RoomCharacterEnum.CharacterOrderType.FaithUp then
		if xFaith ~= yFaith then
			return xFaith < yFaith
		end

		if x.heroConfig.rare ~= y.heroConfig.rare then
			return x.heroConfig.rare > y.heroConfig.rare
		end
	elseif order == RoomCharacterEnum.CharacterOrderType.FaithDown then
		if xFaith ~= yFaith then
			return yFaith < xFaith
		end

		if x.heroConfig.rare ~= y.heroConfig.rare then
			return x.heroConfig.rare > y.heroConfig.rare
		end
	end

	local xIsOnBirthday = RoomCharacterModel.instance:isOnBirthday(x.heroId)
	local yIsOnBirthday = RoomCharacterModel.instance:isOnBirthday(y.heroId)

	if xIsOnBirthday ~= yIsOnBirthday then
		return xIsOnBirthday
	end

	return x.id < y.id
end

function RoomCharacterPlaceListModel:setOrder(order)
	self._order = order
end

function RoomCharacterPlaceListModel:getOrder()
	return self._order
end

function RoomCharacterPlaceListModel:setFilterCareer(careerList)
	self._filterCareerDict = {}

	if careerList and #careerList > 0 then
		for i, career in ipairs(careerList) do
			self._filterCareerDict[career] = true
		end
	end

	self:setIsFilterOnBirthday()
end

function RoomCharacterPlaceListModel:getFilterCareer()
	for k, v in pairs(self._filterCareerDict) do
		if v == true then
			return k
		end
	end
end

function RoomCharacterPlaceListModel:isFilterCareer(career)
	return self:isFilterCareerEmpty() or CharacterModel.instance:filterHerobyCareer_1(self._filterCareerDict, career)
end

function RoomCharacterPlaceListModel:isFilterCareerEmpty()
	return not LuaUtil.tableNotEmpty(self._filterCareerDict)
end

function RoomCharacterPlaceListModel:getIsFilterOnBirthday()
	return self._isFilterOnBirthday
end

function RoomCharacterPlaceListModel:setIsFilterOnBirthday(isFilter)
	self._isFilterOnBirthday = isFilter
end

function RoomCharacterPlaceListModel:isFilterBirthday(heroId)
	local isFilterOnBirthday = self:getIsFilterOnBirthday()

	return (heroId and isFilterOnBirthday or nil) and RoomCharacterModel.instance:isOnBirthday(heroId)
end

function RoomCharacterPlaceListModel:hasHeroOnBirthday()
	local result = false
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		local isOnBirthday = RoomCharacterModel.instance:isOnBirthday(mo.id)

		if isOnBirthday then
			result = true

			break
		end
	end

	return result
end

function RoomCharacterPlaceListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectHeroId = nil
end

function RoomCharacterPlaceListModel:_refreshSelect()
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

function RoomCharacterPlaceListModel:setSelect(characterUid)
	self._selectHeroId = characterUid

	self:_refreshSelect()
end

function RoomCharacterPlaceListModel:initCharacterPlace()
	self:setCharacterPlaceList()
end

function RoomCharacterPlaceListModel:initFilter()
	self:setFilterCareer()
end

function RoomCharacterPlaceListModel:initOrder()
	self._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

RoomCharacterPlaceListModel.instance = RoomCharacterPlaceListModel.New()

return RoomCharacterPlaceListModel
