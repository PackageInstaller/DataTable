-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotCollectionListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionListModel", package.seeall)

local V1a6_CachotCollectionListModel = class("V1a6_CachotCollectionListModel", MixScrollModel)

V1a6_CachotCollectionListModel.instance = V1a6_CachotCollectionListModel.New()

function V1a6_CachotCollectionListModel:release()
	self._curCategory = nil
	self._newCollectionAndClickList = nil
	self._unlockCollectionsNew = nil
	self._curPlayAnimCellIndex = nil
end

function V1a6_CachotCollectionListModel:onInitData(categoryType, maxCollectionNumSingleLine)
	self._curCategory = categoryType or V1a6_CachotEnum.CollectionCategoryType.All
	self._maxCollectionNumSingleLine = maxCollectionNumSingleLine

	self:buildUnLockCollectionsNew()
	self:buildAllConfigData()
	self:switchCategory(self._curCategory)
end

function V1a6_CachotCollectionListModel:buildUnLockCollectionsNew()
	local rogueStateInfo = V1a6_CachotModel.instance:getRogueStateInfo()

	if rogueStateInfo then
		self._unlockCollectionsNew = rogueStateInfo.unlockCollectionsNew
	end
end

function V1a6_CachotCollectionListModel:buildAllConfigData()
	self:intCategoryDataTab()
	self:initCollectionStateMap()

	local configs = V1a6_CachotCollectionConfig.instance:getAllConfig()

	if configs then
		table.sort(configs, self.configSortFunc)

		local wholeList = self._collectionDic[V1a6_CachotEnum.CollectionCategoryType.All]
		local hasGetList = self._collectionDic[V1a6_CachotEnum.CollectionCategoryType.HasGet]
		local unGetList = self._collectionDic[V1a6_CachotEnum.CollectionCategoryType.UnGet]

		for _, v in ipairs(configs) do
			if v.inHandBook == V1a6_CachotEnum.CollectionInHandBook then
				self:buildCollectionListMO(v, wholeList)
				self:buildCollectionListMO(v, hasGetList, {
					V1a6_CachotEnum.CollectionState.HasGet
				})
				self:buildCollectionListMO(v, unGetList, {
					V1a6_CachotEnum.CollectionState.UnLocked,
					V1a6_CachotEnum.CollectionState.Locked
				})
			end
		end
	end
end

local CheckResult = {
	ListFull = 2,
	MisMatchState = 1,
	Success = 3
}

function V1a6_CachotCollectionListModel:buildCollectionListMO(config, moList, matchCollectionStateList)
	local checkResult = self:collectionCheckFunc(config, moList, matchCollectionStateList)
	local lastListMO = moList and moList[#moList]

	if checkResult == CheckResult.MisMatchState then
		return
	elseif checkResult == CheckResult.ListFull then
		local listMO = V1a6_CachotCollectionListMO.New()
		local isTop = not lastListMO or lastListMO.collectionType ~= config.type

		listMO:init(config.type, isTop, self._maxCollectionNumSingleLine)
		listMO:addCollection(config)
		table.insert(moList, listMO)
	elseif checkResult == CheckResult.Success then
		local listMO = moList[#moList]

		listMO:addCollection(config)
	end
end

function V1a6_CachotCollectionListModel:collectionCheckFunc(config, moList, matchCollectionStateList)
	local lastLineMO = moList and moList[#moList]
	local collectionState = self:getCollectionState(config.id)

	if matchCollectionStateList and not tabletool.indexOf(matchCollectionStateList, collectionState) then
		return CheckResult.MisMatchState
	elseif not lastLineMO or lastLineMO:isFull() or lastLineMO.collectionType ~= config.type then
		return CheckResult.ListFull
	else
		return CheckResult.Success
	end
end

function V1a6_CachotCollectionListModel.configSortFunc(a, b)
	if a.type ~= b.type then
		return a.type < b.type
	end

	return a.id < b.id
end

local CellType = {
	Top = 1,
	Others = 2
}

function V1a6_CachotCollectionListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		if mo._isTop then
			if not CellType.Top then
				local cellType = CellType.Others
				local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(cellType, mo:getLineHeight(), i)

				table.insert(mixCellInfos, mixCellInfo)
			end
		end
	end

	return mixCellInfos
end

function V1a6_CachotCollectionListModel:intCategoryDataTab()
	self._collectionDic = {}

	for _, v in pairs(V1a6_CachotEnum.CollectionCategoryType) do
		self._collectionDic[v] = {}
	end
end

function V1a6_CachotCollectionListModel:initCollectionStateMap()
	self._collectionStateMap = {}

	local rogueStateInfo = V1a6_CachotModel.instance:getRogueStateInfo()

	if rogueStateInfo then
		self:buildCollectionMap(self._collectionStateMap, rogueStateInfo.unlockCollections, V1a6_CachotEnum.CollectionState.UnLocked)
		self:buildCollectionMap(self._collectionStateMap, rogueStateInfo.hasCollections, V1a6_CachotEnum.CollectionState.HasGet)
	end
end

function V1a6_CachotCollectionListModel:buildCollectionMap(map, souceDataList, collectionState)
	if souceDataList and map and collectionState then
		for _, v in ipairs(souceDataList) do
			map[v] = collectionState
		end
	end
end

function V1a6_CachotCollectionListModel:getCollectionState(collectionId)
	if self._collectionStateMap then
		return self._collectionStateMap[collectionId] or V1a6_CachotEnum.CollectionState.Locked
	end
end

function V1a6_CachotCollectionListModel:switchCategory(categoryType)
	if self._collectionDic then
		if self._collectionDic then
			self:setList(self._collectionDic)

			self._curCategory = categoryType
		end
	end
end

function V1a6_CachotCollectionListModel:getCurCategory()
	return self._curCategory
end

function V1a6_CachotCollectionListModel:getCurCategoryFirstCollection()
	local firstLineMOs = self:getByIndex(1)

	if firstLineMOs and firstLineMOs.collectionList and firstLineMOs.collectionList[1] then
		return firstLineMOs.collectionList[1].id
	end
end

function V1a6_CachotCollectionListModel:markSelectCollecionId(collectionId)
	self._curSelectCollectionId = collectionId

	local isCollectionNew = self:isCollectionNew(collectionId)

	if isCollectionNew then
		self._newCollectionAndClickList = self._newCollectionAndClickList or {}

		table.insert(self._newCollectionAndClickList, collectionId)

		self._unlockCollectionsNew[collectionId] = nil
	end
end

function V1a6_CachotCollectionListModel:isCollectionNew(collectionId)
	return self._unlockCollectionsNew and self._unlockCollectionsNew[collectionId]
end

function V1a6_CachotCollectionListModel:getNewCollectionAndClickList()
	return self._newCollectionAndClickList
end

function V1a6_CachotCollectionListModel:getCurSelectCollectionId()
	return self._curSelectCollectionId
end

function V1a6_CachotCollectionListModel:markCurPlayAnimCellIndex(cellIndex)
	self._curPlayAnimCellIndex = cellIndex
end

function V1a6_CachotCollectionListModel:getCurPlayAnimCellIndex()
	return self._curPlayAnimCellIndex
end

function V1a6_CachotCollectionListModel:resetCurPlayAnimCellIndex()
	self._curPlayAnimCellIndex = nil
end

return V1a6_CachotCollectionListModel
