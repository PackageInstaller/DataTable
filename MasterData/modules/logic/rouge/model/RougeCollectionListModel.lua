-- chunkname: @modules/logic/rouge/model/RougeCollectionListModel.lua

module("modules.logic.rouge.model.RougeCollectionListModel", package.seeall)

local RougeCollectionListModel = class("RougeCollectionListModel", MixScrollModel)

function RougeCollectionListModel:onInitData(baseTagFilterMap, extraTagFilterMap, selectedType, updatePos)
	self._selectedConfig = nil
	self._baseTagFilterMap = baseTagFilterMap
	self._extraTagFilterMap = extraTagFilterMap
	self._selectedType = selectedType
	self._updatePos = updatePos

	if updatePos then
		self._posMap = {}
	end

	self:onCollectionDataUpdate()
end

function RougeCollectionListModel:getPos(id)
	local config = lua_rouge_collection_unlock.configDict[id]

	return (config or nil) and (config.sortId or 0)
end

function RougeCollectionListModel:setSelectedConfig(config)
	self._selectedConfig = config

	RougeController.instance:dispatchEvent(RougeEvent.OnClickCollectionListItem)
end

function RougeCollectionListModel:getSelectedConfig()
	return self._selectedConfig
end

function RougeCollectionListModel:_canShow(co)
	if not co.interactable then
		return false
	end

	if self._selectedType == 1 then
		return true
	end

	local isPass = RougeOutsideModel.instance:collectionIsPass(co.id)

	if self._selectedType == 2 then
		return isPass
	end

	return not isPass
end

function RougeCollectionListModel:onCollectionDataUpdate()
	local typeMap = {}
	local typeList = {}
	local result = {}
	local height = 0
	local typeHeight = {}
	local list = RougeCollectionConfig.instance:getAllInteractCollections()

	if list then
		for _, co in pairs(list) do
			local isTagFilter = RougeCollectionHelper.checkCollectionHasAnyOneTag(co.id, nil, self._baseTagFilterMap, self._extraTagFilterMap)

			if isTagFilter then
				local map = typeMap[co.type]

				if not map then
					map = {
						type = co.type
					}
					typeMap[co.type] = map

					table.insert(typeList, map)
				end

				if self:_canShow(co) then
					table.insert(map, co)
				end
			end
		end
	end

	table.sort(typeList, RougeCollectionListModel.sortType)

	local posIndex = 1

	self._firstType = nil

	for i, v in ipairs(typeList) do
		local list = typeMap[v.type]

		table.sort(list, RougeCollectionListModel.sortTypeList)

		local mo

		for k, editorConfig in ipairs(list) do
			if not mo then
				mo = {}

				if k == 1 and self._firstType then
					mo.type = v.type
				end

				self._firstType = self._firstType or v.type

				table.insert(result, mo)

				if mo.type then
					typeHeight[mo.type] = height
				end

				height = height + ((mo.type or nil) and (RougeEnum.CollectionHeight.Big or RougeEnum.CollectionHeight.Small))
			end

			table.insert(mo, editorConfig)

			if self._updatePos then
				self._posMap[editorConfig.id] = posIndex
				posIndex = posIndex + 1
			end

			if not self._selectedConfig then
				self:setSelectedConfig(editorConfig)
			end

			if #mo >= RougeEnum.CollectionListRowNum then
				mo = nil
			end
		end
	end

	if self._updatePos then
		self._enchantList = typeMap[RougeEnum.CollectionType.Enchant]
	end

	self._typeHeightMap = typeHeight
	self._typeList = typeList

	self:setList(result)
end

function RougeCollectionListModel:getTypeHeightMap()
	return self._typeHeightMap
end

function RougeCollectionListModel:getTypeList()
	return self._typeList
end

function RougeCollectionListModel:getFirstType()
	return self._firstType
end

function RougeCollectionListModel:getEnchantList()
	return self._enchantList
end

function RougeCollectionListModel.sortType(a, b)
	local aTypeSort = RougeEnum.CollectionTypeSort[a.type]
	local bTypeSort = RougeEnum.CollectionTypeSort[b.type]

	if not aTypeSort or not bTypeSort then
		if not aTypeSort then
			logError(string.format("无法查询到收藏夹造物类型排序，类型 = %s", a.type))
		end

		if not bTypeSort then
			logError(string.format("无法查询到收藏夹造物类型排序，类型 = %s", b.type))
		end

		return aTypeSort ~= nil
	end

	return aTypeSort < bTypeSort
end

function RougeCollectionListModel.getSize(id)
	return (RougeCollectionConfig.instance:getCollectionCellCount(id, RougeEnum.CollectionEditorParamType.Shape))
end

function RougeCollectionListModel.sortTypeList(a, b)
	local aPos = RougeCollectionListModel.instance:getPos(a.id)
	local bPos = RougeCollectionListModel.instance:getPos(b.id)

	if aPos ~= bPos then
		return aPos < bPos
	end

	return a.id < b.id
end

function RougeCollectionListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		if mo.type then
			if not RougeEnum.CollectionHeight.Big then
				local width = RougeEnum.CollectionHeight.Small
				local cellType = mo.type and 1 or 2
				local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(cellType, width)

				table.insert(self._mixCellInfo, mixCellInfo)
			end
		end
	end

	return self._mixCellInfo
end

function RougeCollectionListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self._extraTagFilterMap)
end

RougeCollectionListModel.instance = RougeCollectionListModel.New()

return RougeCollectionListModel
