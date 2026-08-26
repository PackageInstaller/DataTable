-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_CollectionListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_CollectionListModel", package.seeall)

local Rouge2_CollectionListModel = class("Rouge2_CollectionListModel", MixScrollModel)

function Rouge2_CollectionListModel:onInitData(baseTagFilterMap, extraTagFilterMap, selectedType, updatePos)
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

function Rouge2_CollectionListModel:getPos(id)
	local config = lua_rouge2_item_list.configDict[id]

	return (config or nil) and (config.id or 0)
end

function Rouge2_CollectionListModel:setSelectedConfig(config)
	self._selectedConfig = config

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnClickCollectionListItem)
end

function Rouge2_CollectionListModel:getSelectedConfig()
	return self._selectedConfig
end

function Rouge2_CollectionListModel:_canShow(co)
	if self._selectedType == 1 then
		return true
	end

	local targetId = Rouge2_OutsideEnum.CollectionTagType[self._selectedType - 1]

	if targetId == nil then
		logError("当前指定的tag不存在 " .. "索引" .. self._selectedType)
	end

	local tag = Rouge2_BackpackHelper.itemId2Tag(co.id)

	return tag == targetId
end

function Rouge2_CollectionListModel:onCollectionDataUpdate()
	local typeMap = {}
	local typeList = {}
	local result = {}
	local height = 0
	local typeHeight = {}
	local list = Rouge2_OutSideConfig.instance:getAllInteractCollections()

	if list then
		for _, co in pairs(list) do
			if self:_canShow(co) then
				local type = Rouge2_BackpackHelper.itemId2Tag(co.id)
				local map = typeMap[type]

				if not map then
					map = {
						type = type
					}
					typeMap[type] = map

					table.insert(typeList, map)
				end

				table.insert(map, co)
			end
		end
	end

	table.sort(typeList, Rouge2_CollectionListModel.sortType)

	local posIndex = 1

	self._firstType = nil

	for i, v in ipairs(typeList) do
		local singleList = typeMap[v.type]

		table.sort(singleList, Rouge2_CollectionListModel.sortTypeList)

		local mo

		for k, config in ipairs(singleList) do
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

				height = height + ((mo.type or nil) and (Rouge2_OutsideEnum.CollectionHeight.Big or Rouge2_OutsideEnum.CollectionHeight.Small))
			end

			table.insert(mo, config)

			if self._updatePos then
				self._posMap[config.id] = posIndex

				logNormal("肉鸽2 增加造物 id: " .. config.id .. " index: " .. posIndex .. " rare: " .. config.sortId)

				posIndex = posIndex + 1
			end

			if not self._selectedConfig then
				self:setSelectedConfig(config)
			end

			if #mo >= Rouge2_OutsideEnum.CollectionListRowNum then
				mo = nil
			end
		end
	end

	self._typeHeightMap = typeHeight
	self._typeList = typeList

	self:setList(result)
end

function Rouge2_CollectionListModel:getTypeHeightMap()
	return self._typeHeightMap
end

function Rouge2_CollectionListModel:getTypeList()
	return self._typeList
end

function Rouge2_CollectionListModel:getFirstType()
	return self._firstType
end

function Rouge2_CollectionListModel.sortType(a, b)
	local aTypeSort = Rouge2_OutsideEnum.CollectionTypeSort[tonumber(a.type)]
	local bTypeSort = Rouge2_OutsideEnum.CollectionTypeSort[tonumber(b.type)]

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

function Rouge2_CollectionListModel.sortTypeList(a, b)
	if a.sortId ~= b.sortId then
		return a.sortId < b.sortId
	end

	if a.rare ~= b.rare then
		return a.rare < b.rare
	end

	return a.id < b.id
end

function Rouge2_CollectionListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	local list = self:getList()

	for i, mo in ipairs(list) do
		if mo.type then
			if not Rouge2_OutsideEnum.CollectionHeight.Big then
				local width = Rouge2_OutsideEnum.CollectionHeight.Small
				local cellType = mo.type and 1 or 2
				local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(cellType, width)

				table.insert(self._mixCellInfo, mixCellInfo)
			end
		end
	end

	return self._mixCellInfo
end

function Rouge2_CollectionListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self._extraTagFilterMap)
end

function Rouge2_CollectionListModel:getItemIndex(id)
	return self._posMap[id] or 0
end

Rouge2_CollectionListModel.instance = Rouge2_CollectionListModel.New()

return Rouge2_CollectionListModel
