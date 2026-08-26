-- chunkname: @modules/logic/rouge/model/RougeCollectionCompositeListModel.lua

module("modules.logic.rouge.model.RougeCollectionCompositeListModel", package.seeall)

local RougeCollectionCompositeListModel = class("RougeCollectionCompositeListModel", ListScrollModel)

function RougeCollectionCompositeListModel:onInitData(baseTagFilterMap, extraTagFilterMap)
	self._baseTagFilterMap = baseTagFilterMap
	self._extraTagFilterMap = extraTagFilterMap

	self:filterCollection()
end

function RougeCollectionCompositeListModel:filterCollection()
	local productCollections = {}
	local synthesisCfgs = RougeCollectionConfig.instance:getCollectionSynthesisList()

	if synthesisCfgs then
		for _, co in ipairs(synthesisCfgs) do
			local isTagFilter = RougeCollectionHelper.checkCollectionHasAnyOneTag(co.product, nil, self._baseTagFilterMap, self._extraTagFilterMap)
			local isContainVersion = RougeDLCHelper.isCurrentUsingContent(co.version)

			if isTagFilter and isContainVersion then
				table.insert(productCollections, co)
			end
		end
	end

	table.sort(productCollections, self.sortFunc)
	self:setList(productCollections)
end

function RougeCollectionCompositeListModel.sortFunc(a, b)
	local isACanComposite = RougeCollectionModel.instance:checkIsCanCompositeCollection(a.id)
	local isBCanComposite = RougeCollectionModel.instance:checkIsCanCompositeCollection(b.id)

	if isACanComposite ~= isBCanComposite then
		return isACanComposite
	end

	return a.id < b.id
end

function RougeCollectionCompositeListModel:isBagEmpty()
	return self:getCount() <= 0
end

function RougeCollectionCompositeListModel:selectCell(index, isSelect)
	local readySelectMO = self:getByIndex(index)

	if not readySelectMO then
		return
	end

	if isSelect then
		self._curSelectId = readySelectMO.id or 0
	end

	RougeCollectionCompositeListModel.super.selectCell(self, index, isSelect)
end

function RougeCollectionCompositeListModel:selectFirstOrDefault()
	if not self:isBagEmpty() then
		self:selectCell(1, true)
	end
end

function RougeCollectionCompositeListModel:getCurSelectCellId()
	return self._curSelectId or 0
end

function RougeCollectionCompositeListModel:isFiltering()
	return not GameUtil.tabletool_dictIsEmpty(self._baseTagFilterMap) or not GameUtil.tabletool_dictIsEmpty(self._extraTagFilterMap)
end

RougeCollectionCompositeListModel.instance = RougeCollectionCompositeListModel.New()

return RougeCollectionCompositeListModel
