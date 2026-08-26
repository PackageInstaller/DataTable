-- chunkname: @modules/logic/room/model/critter/RoomTrainHeroListModel.lua

module("modules.logic.room.model.critter.RoomTrainHeroListModel", package.seeall)

local RoomTrainHeroListModel = class("RoomTrainHeroListModel", ListScrollModel)

function RoomTrainHeroListModel:onInit()
	self:_clearData()
end

function RoomTrainHeroListModel:reInit()
	self:_clearData()
end

function RoomTrainHeroListModel:clear()
	RoomTrainHeroListModel.super.clear(self)
	self:_clearData()
end

function RoomTrainHeroListModel:_clearData()
	self:clearData()
	self:clearFilterData()
end

function RoomTrainHeroListModel:clearData()
	RoomTrainHeroListModel.super.clear(self)

	self._selectHeroId = nil
end

function RoomTrainHeroListModel:clearFilterData()
	self._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

function RoomTrainHeroListModel:setHeroList(critterFilterMO)
	self.critterFilterMO = critterFilterMO

	self:updateHeroList()
end

function RoomTrainHeroListModel:updateHeroList(needShowHeroId)
	local critterMOList = CritterModel.instance:getCultivatingCritters()
	local trainHeroIdMap = {}

	for _, critterMO in ipairs(critterMOList) do
		if needShowHeroId ~= critterMO.trainInfo.heroId then
			trainHeroIdMap[critterMO.trainInfo.heroId] = true
		end
	end

	local moList = {}

	self._trainHeroMODict = self._trainHeroMODict or {}

	local heroMOList = HeroModel.instance:getList()
	local tCritterConfig = CritterConfig.instance
	local isRaceFilter = self:_isHasFilterType(CritterEnum.FilterType.Race)

	for i, heroMO in ipairs(heroMOList) do
		local cfg = tCritterConfig:getCritterHeroPreferenceCfg(heroMO.heroId)

		if cfg ~= nil then
			local culitvateHeroMO = self:getById(heroMO.heroId)

			if culitvateHeroMO == nil then
				culitvateHeroMO = RoomTrainHeroMO.New()

				culitvateHeroMO:initHeroMO(heroMO)

				self._trainHeroMODict[heroMO.heroId] = culitvateHeroMO
			else
				culitvateHeroMO:updateSkinId(heroMO.skin)
			end

			if trainHeroIdMap[heroMO.heroId] or isRaceFilter and not self:_checkFilterisPass(culitvateHeroMO) then
				-- block empty
			else
				table.insert(moList, culitvateHeroMO)
			end
		end
	end

	table.sort(moList, self:_getSortFunction())
	self:setList(moList)
	self:_refreshSelect()
end

function RoomTrainHeroListModel:_isHasFilterType(filteType)
	if self.critterFilterMO then
		local filterDict = self.critterFilterMO:getFilterCategoryDict()
		local filterTabList = filterDict and filterDict[filteType]

		if filterTabList and #filterTabList > 0 then
			return true
		end
	end

	return false
end

function RoomTrainHeroListModel:_checkFilterisPass(trainHeroMO)
	local pType = trainHeroMO:getPrefernectType()
	local pids = trainHeroMO:getPrefernectIds()

	if pType == CritterEnum.PreferenceType.All then
		return true
	elseif pType == CritterEnum.PreferenceType.Catalogue then
		for i = 1, #pids do
			if self.critterFilterMO:checkRaceByCatalogueId(pids[pids]) then
				return true
			end
		end
	elseif pType == CritterEnum.PreferenceType.Critter then
		for i = 1, #pids do
			local catalogueId = CritterConfig.instance:getCritterCatalogue(pids[i])

			if self.critterFilterMO:checkRaceByCatalogueId(catalogueId) then
				return true
			end
		end
	end

	return false
end

function RoomTrainHeroListModel:sortByAttrId(attrId, isHightToLow)
	if attrId ~= nil then
		self._sortAttrId = attrId
	end

	if isHightToLow ~= nil then
		self._isSortHightToLow = isHightToLow
	end

	self:sort(self:_getSortFunction())
end

function RoomTrainHeroListModel:_getSortFunction()
	self._critterMO = RoomTrainCritterListModel.instance:getById(RoomTrainCritterListModel.instance:getSelectId())

	if self._sortFunc then
		return self._sortFunc
	end

	function self._sortFunc(a, b)
		if self._critterMO then
			local aCt = self:_getCritterValue(a, self._critterMO)
			local bCt = self:_getCritterValue(b, self._critterMO)

			if aCt ~= bCt then
				return bCt < aCt
			end
		end

		local aValue = self:_getAttrValue(a, self._sortAttrId)
		local bValue = self:_getAttrValue(b, self._sortAttrId)

		if aValue ~= bValue then
			if self._isSortHightToLow then
				return bValue < aValue
			end

			return aValue < bValue
		end

		if a.heroConfig.rare ~= b.heroConfig.rare then
			return a.heroConfig.rare > b.heroConfig.rare
		end

		if a.heroId ~= b.heroId then
			return a.heroId > b.heroId
		end
	end

	return self._sortFunc
end

function RoomTrainHeroListModel:_getAttrValue(a, attrId)
	local aAttr = a:getAttributeInfoMO()

	if aAttr.attributeId == attrId then
		return 100
	end

	return 0
end

function RoomTrainHeroListModel:_getCritterValue(a, critterMO)
	if a:chcekPrefernectCritterId(critterMO:getDefineId()) then
		local pfType = a:getPrefernectType()

		if pfType == CritterEnum.PreferenceType.All then
			return 110
		elseif pfType == CritterEnum.PreferenceType.Catalogue then
			return 120
		elseif pfType == CritterEnum.PreferenceType.Critter then
			return 130
		end

		return 10
	end

	return 0
end

function RoomTrainHeroListModel:setOrder(order)
	self._order = order
end

function RoomTrainHeroListModel:getOrder()
	return self._order
end

function RoomTrainHeroListModel:getById(id)
	local mo = RoomTrainHeroListModel.super.getById(self, id)
	local var_18_0

	if not mo then
		::label_18_0::

		var_18_0 = self._trainHeroMODict and self._trainHeroMODict[id]
	end

	return var_18_0
end

function RoomTrainHeroListModel:clearSelect()
	for i, view in ipairs(self._scrollViews) do
		view:setSelect(nil)
	end

	self._selectHeroId = nil
end

function RoomTrainHeroListModel:_refreshSelect()
	local selectMO = self:getById(self._selectHeroId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomTrainHeroListModel:getSelectId()
	return self._selectHeroId
end

function RoomTrainHeroListModel:setSelect(characterUid)
	self._selectHeroId = characterUid

	self:_refreshSelect()
end

function RoomTrainHeroListModel:initFilter()
	self:setFilterCareer()
end

function RoomTrainHeroListModel:initOrder()
	self._order = RoomCharacterEnum.CharacterOrderType.RareDown
end

RoomTrainHeroListModel.instance = RoomTrainHeroListModel.New()

return RoomTrainHeroListModel
