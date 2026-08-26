-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_CollectionFormulaListModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_CollectionFormulaListModel", package.seeall)

local Rouge2_CollectionFormulaListModel = class("Rouge2_CollectionFormulaListModel", ListScrollModel)

function Rouge2_CollectionFormulaListModel:onInit(baseTagFilterMap, extraTagFilterMap, selectIndex)
	self._baseTagFilterMap = baseTagFilterMap
	self._extraTagFilterMap = extraTagFilterMap
	self._curSelectId = nil
	self._posDic = {}

	self:onCollectionDataUpdate()
	self:selectFirstOrDefault(selectIndex)
end

function Rouge2_CollectionFormulaListModel:onCollectionDataUpdate()
	local productCollections = {}
	local formulaConfigList = Rouge2_OutSideConfig.instance:getFormulaConfigList()

	if formulaConfigList then
		for _, co in ipairs(formulaConfigList) do
			local isTagFilter = true

			if isTagFilter then
				local mo = {}

				mo.itemId = co.id
				mo.type = Rouge2_OutsideEnum.CollectionType.Formula
				mo.showRedDot = true

				table.insert(productCollections, mo)
			end
		end
	end

	self:setList(productCollections)

	self._posDic = {}

	local list = self:getList()

	for _, mo in ipairs(list) do
		self._posDic[mo.itemId] = mo.id
	end
end

function Rouge2_CollectionFormulaListModel:isBagEmpty()
	return self:getCount() <= 0
end

function Rouge2_CollectionFormulaListModel:selectCell(index, isSelect)
	local readySelectMO = self:getByIndex(index)

	if not readySelectMO then
		self._curSelectId = nil

		return
	end

	if isSelect then
		self._curSelectId = readySelectMO.id or 0
	end

	Rouge2_CollectionFormulaListModel.super.selectCell(self, index, isSelect)
end

function Rouge2_CollectionFormulaListModel:selectFirstOrDefault(selectItemId)
	local hasSelectCell = self:getById(self._curSelectId)

	if not hasSelectCell then
		local defaultIndex = 1

		if selectItemId then
			for index, mo in ipairs(self._list) do
				if mo.itemId == selectItemId then
					defaultIndex = index

					break
				end
			end
		end

		self:selectCell(defaultIndex, true)
	end
end

function Rouge2_CollectionFormulaListModel:getCurSelectCellId()
	return self._curSelectId or 0
end

function Rouge2_CollectionFormulaListModel:getCellIndexByItemId(formulaId)
	return self._posDic[formulaId]
end

function Rouge2_CollectionFormulaListModel:updateFilterMap(baseTagFilterMap, extraTagFilterMap)
	self._baseTagFilterMap = baseTagFilterMap
	self._extraTagFilterMap = extraTagFilterMap

	self:onCollectionDataUpdate()
	self:selectFirstOrDefault()
end

function Rouge2_CollectionFormulaListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self._extraTagFilterMap)
end

Rouge2_CollectionFormulaListModel.instance = Rouge2_CollectionFormulaListModel.New()

return Rouge2_CollectionFormulaListModel
