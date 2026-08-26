-- chunkname: @modules/logic/rouge/model/RougeCollectionHandBookListModel.lua

module("modules.logic.rouge.model.RougeCollectionHandBookListModel", package.seeall)

local RougeCollectionHandBookListModel = class("RougeCollectionHandBookListModel", ListScrollModel)

function RougeCollectionHandBookListModel:onInit(baseTagFilterMap, extraTagFilterMap)
	self._baseTagFilterMap = baseTagFilterMap
	self._extraTagFilterMap = extraTagFilterMap
	self._curSelectId = nil

	self:onCollectionDataUpdate()
	self:selectFirstOrDefault()
end

function RougeCollectionHandBookListModel:onCollectionDataUpdate()
	local productCollections = {}
	local synthesisCfgs = RougeCollectionConfig.instance:getCollectionSynthesisList()

	if synthesisCfgs then
		for _, co in ipairs(synthesisCfgs) do
			local isTagFilter = RougeCollectionHelper.checkCollectionHasAnyOneTag(co.product, nil, self._baseTagFilterMap, self._extraTagFilterMap)

			if isTagFilter then
				table.insert(productCollections, co)
			end
		end
	end

	self:setList(productCollections)
end

function RougeCollectionHandBookListModel:isBagEmpty()
	return self:getCount() <= 0
end

function RougeCollectionHandBookListModel:selectCell(index, isSelect)
	local readySelectMO = self:getByIndex(index)

	if not readySelectMO then
		self._curSelectId = nil

		return
	end

	if isSelect then
		self._curSelectId = readySelectMO.id or 0
	end

	RougeCollectionHandBookListModel.super.selectCell(self, index, isSelect)
end

function RougeCollectionHandBookListModel:selectFirstOrDefault()
	local hasSelectCell = self:getById(self._curSelectId)

	if not hasSelectCell then
		self:selectCell(1, true)
	end
end

function RougeCollectionHandBookListModel:getCurSelectCellId()
	return self._curSelectId or 0
end

function RougeCollectionHandBookListModel:updateFilterMap(baseTagFilterMap, extraTagFilterMap)
	self._baseTagFilterMap = baseTagFilterMap
	self._extraTagFilterMap = extraTagFilterMap

	self:onCollectionDataUpdate()
	self:selectFirstOrDefault()
end

function RougeCollectionHandBookListModel:isCurSelectTargetId(targetId)
	return self._curSelectId == targetId
end

function RougeCollectionHandBookListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self._extraTagFilterMap)
end

RougeCollectionHandBookListModel.instance = RougeCollectionHandBookListModel.New()

return RougeCollectionHandBookListModel
