-- chunkname: @modules/logic/room/model/map/building/RoomFormulaListModel.lua

module("modules.logic.room.model.map.building.RoomFormulaListModel", package.seeall)

local RoomFormulaListModel = class("RoomFormulaListModel", ListScrollModel)
local DEFAULT_IS_IN_LIST = true

RoomFormulaListModel.FormulaItemAnimationName = {
	collapse = "collapse",
	unfold = "unfold",
	idle = "idle"
}
RoomFormulaListModel.ANIMATION_WAIT_TIME = 0.15
RoomFormulaListModel.SET_DATA_WAIT_TIME = 0.01

function RoomFormulaListModel:onInit()
	self:_clearData()
end

function RoomFormulaListModel:reInit()
	self:_clearData()
end

function RoomFormulaListModel:clear()
	self:_clearData()
	RoomFormulaListModel.super.clear(self)
end

function RoomFormulaListModel:_clearData()
	self._formulaShowType = nil

	self:resetSelectFormulaStrId()
	self:resetIsInList()
end

function RoomFormulaListModel:isSelectedFormula(formulaStrId)
	if not formulaStrId then
		return false
	end

	local selectedFormulaStrId = self:getSelectFormulaStrId()

	return formulaStrId == selectedFormulaStrId
end

function RoomFormulaListModel:changeSelectFormulaToTopLevel()
	local selectFormulaStrId = self:getSelectFormulaStrId()

	if not selectFormulaStrId then
		return
	end

	local selectFormulaMo = RoomFormulaListModel.instance:getSelectFormulaMo()
	local curTreeLevel = selectFormulaMo:getFormulaTreeLevel()

	if curTreeLevel == RoomFormulaModel.DEFAULT_TREE_LEVEL then
		return
	end

	local topLevelFormulaStrId = RoomProductionHelper.getTopLevelFormulaStrId(selectFormulaStrId)
	local topLevelFormulaMo = RoomFormulaModel.instance:getFormulaMo(topLevelFormulaStrId)

	if selectFormulaMo and topLevelFormulaMo then
		local formulaCombineCount = selectFormulaMo:getFormulaCombineCount()

		topLevelFormulaMo:setFormulaCombineCount(formulaCombineCount)
		self:setSelectFormulaStrId(topLevelFormulaStrId)
		RoomMapController.instance:dispatchEvent(RoomEvent.ChangeSelectFormulaToTopLevel)
	end
end

function RoomFormulaListModel:setFormulaList(level)
	self:resetAllShowFormulaIsExpandTree()

	local moList = {}
	local formulaMOList = RoomFormulaModel.instance:getTopTreeLevelFormulaMoList(self._formulaShowType)

	for _, formulaMO in ipairs(formulaMOList) do
		table.insert(moList, formulaMO)
	end

	self.level = level

	table.sort(moList, self._sortFunction)

	moList = self:listAddTreeFormula(moList)

	self:setList(moList)
end

function RoomFormulaListModel._sortFunction(x, y)
	local order = RoomFormulaListModel.instance:getOrder()
	local level = RoomFormulaListModel.instance.level
	local xUnlock, _, xNeedProductionLevel, xNeedEpisodeId = RoomProductionHelper.isFormulaUnlock(x.config.id, level)
	local yUnlock, _, yNeedProductionLevel, yNeedEpisodeId = RoomProductionHelper.isFormulaUnlock(y.config.id, level)

	if xUnlock and not yUnlock then
		return true
	elseif not xUnlock and yUnlock then
		return false
	end

	if xUnlock and yUnlock then
		if order == RoomBuildingEnum.FormulaOrderType.RareUp and x.config.rare ~= y.config.rare then
			return x.config.rare < y.config.rare
		elseif order == RoomBuildingEnum.FormulaOrderType.RareDown and x.config.rare ~= y.config.rare then
			return x.config.rare > y.config.rare
		elseif order == RoomBuildingEnum.FormulaOrderType.CostTimeUp and x.config.costTime ~= y.config.costTime then
			return x.config.costTime < y.config.costTime
		elseif order == RoomBuildingEnum.FormulaOrderType.CostTimeDown and x.config.costTime ~= y.config.costTime then
			return x.config.costTime > y.config.costTime
		elseif order == RoomBuildingEnum.FormulaOrderType.OrderUp and x.config.order ~= y.config.order then
			return x.config.order < y.config.order
		elseif order == RoomBuildingEnum.FormulaOrderType.OrderDown and x.config.order ~= y.config.order then
			return x.config.order > y.config.order
		end
	elseif not xUnlock and not yUnlock then
		if xNeedProductionLevel and not yNeedProductionLevel then
			return false
		elseif not xNeedProductionLevel and yNeedProductionLevel then
			return true
		elseif xNeedProductionLevel and yNeedProductionLevel then
			if xNeedProductionLevel ~= yNeedProductionLevel then
				return xNeedProductionLevel < yNeedProductionLevel
			end

			if xNeedEpisodeId and not yNeedEpisodeId then
				return false
			elseif not xNeedEpisodeId and yNeedEpisodeId then
				return true
			end
		end
	end

	if x.config.order ~= y.config.order then
		return x.config.order < y.config.order
	end

	return x.id < y.id
end

function RoomFormulaListModel:expandOrHideTreeFormulaList(preFormulaStrId, isCollapse)
	local isDelay = false

	if not self.isInList then
		return isDelay
	end

	local selectFormulaStrId = self:getSelectFormulaStrId()

	if not preFormulaStrId then
		self:expandTreeFormulaList()

		return isDelay
	end

	if isCollapse then
		local formulaListHideTree

		if string.nilorempty(selectFormulaStrId) then
			formulaListHideTree = self:getFormulaListAfterHideTree(RoomFormulaModel.DEFAULT_TREE_LEVEL)
		else
			local selectFormulaMo = self:getSelectFormulaMo()

			if not selectFormulaMo then
				return isDelay
			end

			local selectFormulaTreeLevel = selectFormulaMo:getFormulaTreeLevel()

			formulaListHideTree = self:getFormulaListAfterHideTree(selectFormulaTreeLevel + 1)
		end

		TaskDispatcher.runDelay(function()
			self:setList(formulaListHideTree)
		end, nil, RoomFormulaListModel.ANIMATION_WAIT_TIME)

		isDelay = true
	else
		local selectFormulaMo = self:getSelectFormulaMo()

		if not selectFormulaMo then
			return isDelay
		end

		local selectFormulaIsExpand = selectFormulaMo:getIsExpandTree()

		if selectFormulaIsExpand then
			self:onModelUpdate()
		else
			local selectFormulaTreeLevel = selectFormulaMo:getFormulaTreeLevel()
			local formulaListHideTree = self:getFormulaListAfterHideTree(selectFormulaTreeLevel)

			TaskDispatcher.runDelay(function()
				self:expandTreeFormulaList(formulaListHideTree)
			end, nil, RoomFormulaListModel.ANIMATION_WAIT_TIME)

			isDelay = true
		end
	end

	return isDelay
end

function RoomFormulaListModel:expandTreeFormulaList(argsList)
	local curFormulaList = argsList or self:getList()
	local newFormulaList, newTreeLevelFormulaDic = self:listAddTreeFormula(curFormulaList, true)

	self:setList(newFormulaList)
	TaskDispatcher.runDelay(function()
		RoomMapController.instance:dispatchEvent(RoomEvent.PlayFormulaAnimation, newTreeLevelFormulaDic, RoomFormulaListModel.FormulaItemAnimationName.unfold)
	end, nil, RoomFormulaListModel.SET_DATA_WAIT_TIME)
end

function RoomFormulaListModel:getFormulaListAfterHideTree(hideTreeLevel)
	local curFormulaList = self:getList()

	if hideTreeLevel > RoomFormulaModel.MAX_FORMULA_TREE_LEVEL then
		return curFormulaList
	end

	local hideTreeLevelFormulaDic = {}
	local newFormulaList = {}

	for _, formulaMO in ipairs(curFormulaList) do
		local treeLevel = formulaMO:getFormulaTreeLevel()

		if hideTreeLevel <= treeLevel then
			formulaMO:setIsExpandTree(false)

			if hideTreeLevel < treeLevel then
				local formulaStrId = formulaMO:getId()

				hideTreeLevelFormulaDic[formulaStrId] = true
			end
		end

		if treeLevel <= hideTreeLevel then
			table.insert(newFormulaList, formulaMO)
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.PlayFormulaAnimation, hideTreeLevelFormulaDic, RoomFormulaListModel.FormulaItemAnimationName.collapse)

	return newFormulaList
end

function RoomFormulaListModel:listAddTreeFormula(originalList, isLogError)
	local newTreeLevelFormulaDic = {}
	local isInList = self:getIsInList()
	local selectFormulaStrId = self:getSelectFormulaStrId()

	if not selectFormulaStrId or not isInList then
		return originalList, newTreeLevelFormulaDic
	end

	local selectIndex, curSelectFormulaMo

	for i, formulaMO in ipairs(originalList) do
		local formulaId = formulaMO:getId()

		if formulaId == selectFormulaStrId then
			selectIndex = i
			curSelectFormulaMo = formulaMO

			break
		end
	end

	if not selectIndex or not curSelectFormulaMo then
		if isLogError then
			logError("RoomFormulaListModel:listAddTreeFormula error,can't find select formula,id:" .. (self._selectFormulaStrId or "nil"))
		end

		return originalList, newTreeLevelFormulaDic
	end

	local resultList = {}

	for i = 1, selectIndex do
		table.insert(resultList, originalList[i])
	end

	local curFormulaStrId = curSelectFormulaMo:getId()
	local treeLevelFormulaList = self:_getTreeLevelFormulaList(curFormulaStrId)

	for i = 1, #treeLevelFormulaList do
		local treeLevelFormula = treeLevelFormulaList[i]
		local treeFormulaStrId = treeLevelFormula:getId()

		newTreeLevelFormulaDic[treeFormulaStrId] = true

		table.insert(resultList, treeLevelFormula)
	end

	for i = selectIndex + 1, #originalList do
		table.insert(resultList, originalList[i])
	end

	curSelectFormulaMo:setIsExpandTree(true)

	return resultList, newTreeLevelFormulaDic
end

function RoomFormulaListModel:_getTreeLevelFormulaList(formulaStrId)
	local result = {}

	if not formulaStrId then
		return result
	end

	local curFormulaId, curTreeLevel = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(formulaStrId)
	local treeLevel = curTreeLevel + 1

	if treeLevel > RoomFormulaModel.MAX_FORMULA_TREE_LEVEL then
		return result
	end

	local costMaterialFormulaParam = RoomProductionHelper.getCostMaterialFormulaList(curFormulaId)
	local totalCount = #costMaterialFormulaParam

	for i, costItemFormulaId in ipairs(costMaterialFormulaParam) do
		if costItemFormulaId and costItemFormulaId ~= 0 then
			local isLast = i == totalCount
			local strUID = RoomProductionHelper.getFormulaStrUID(costItemFormulaId, treeLevel)
			local info = {
				id = strUID,
				isLast = isLast,
				parentStrId = formulaStrId
			}
			local formulaMO = RoomFormulaModel.instance:getFormulaMoWithInfo(strUID, info)

			if formulaMO then
				table.insert(result, formulaMO)
			end
		end
	end

	return result
end

function RoomFormulaListModel:setSelectFormulaStrId(formulaStrId)
	local preTopExpandFormulaMo
	local preTopExpandFormulaStrId = self:getTopExpandFormulaStrId()

	if preTopExpandFormulaStrId and preTopExpandFormulaStrId ~= formulaStrId then
		preTopExpandFormulaMo = RoomFormulaModel.instance:getFormulaMo(preTopExpandFormulaStrId, true)
	end

	if formulaStrId then
		local formulaId, treeLevel = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(formulaStrId)

		if formulaId and formulaId ~= 0 then
			if treeLevel == RoomFormulaModel.DEFAULT_TREE_LEVEL then
				if preTopExpandFormulaMo then
					preTopExpandFormulaMo:resetFormulaCombineCount()
				end

				self:setTopExpandFormulaStrId(formulaStrId)
			end

			self._selectFormulaStrId = formulaStrId
		end
	else
		self._selectFormulaStrId = nil

		self:resetTopExpandFormulaStrId()

		if preTopExpandFormulaMo then
			preTopExpandFormulaMo:resetFormulaCombineCount()
		end
	end
end

function RoomFormulaListModel:setFormulaShowType(formulaShowType)
	self._formulaShowType = formulaShowType
end

function RoomFormulaListModel:setOrder(order)
	self._order = order
end

function RoomFormulaListModel:setTopExpandFormulaStrId(topExpandFormulaStrId)
	if topExpandFormulaStrId then
		local _, treeLevel = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(topExpandFormulaStrId)

		if treeLevel == RoomFormulaModel.DEFAULT_TREE_LEVEL then
			self._topExpandFormulaStrId = topExpandFormulaStrId
		else
			logError("RoomFormulaListModel:setTopExpandFormulaStrId error,id:" .. topExpandFormulaStrId .. "isn't top formula")
		end
	else
		self._topExpandFormulaStrId = nil
	end
end

function RoomFormulaListModel:setIsInList(isInList)
	self.isInList = isInList
end

function RoomFormulaListModel:resetSelectFormulaStrId()
	self:setSelectFormulaStrId()
end

function RoomFormulaListModel:resetAllShowFormulaIsExpandTree()
	local curFormulaList = self:getList()

	for _, formulaMo in ipairs(curFormulaList) do
		formulaMo:resetIsExpandTree()
	end
end

function RoomFormulaListModel:resetIsInList()
	self:setIsInList(DEFAULT_IS_IN_LIST)
end

function RoomFormulaListModel:resetTopExpandFormulaStrId()
	self:setTopExpandFormulaStrId()
end

function RoomFormulaListModel:getSelectFormulaStrId()
	return self._selectFormulaStrId
end

function RoomFormulaListModel:getSelectFormulaId()
	local selectFormulaStrId = self:getSelectFormulaStrId()

	return (selectFormulaStrId or nil) and RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(self._selectFormulaStrId)
end

function RoomFormulaListModel:getSelectFormulaMo()
	local selectFormulaStrId = self:getSelectFormulaStrId()

	if selectFormulaStrId then
		return RoomFormulaModel.instance:getFormulaMo(selectFormulaStrId)
	end
end

function RoomFormulaListModel:getOrder()
	return self._order
end

function RoomFormulaListModel:getTopExpandFormulaStrId()
	return self._topExpandFormulaStrId
end

function RoomFormulaListModel:getIsInList()
	if self.isInList == nil then
		self:resetIsInList()
	end

	return self.isInList
end

function RoomFormulaListModel:getSelectFormulaCombineCount()
	local selectFormulaMo = self:getSelectFormulaMo()

	return (selectFormulaMo or nil) and selectFormulaMo:getFormulaCombineCount()
end

function RoomFormulaListModel:getSelectFormulaStrIdIndex()
	local result = 0
	local selectFormulaStrId = self:getSelectFormulaStrId()
	local list = self:getList()

	for i, formulaMo in ipairs(list) do
		local strId = formulaMo:getId()

		if strId == selectFormulaStrId then
			result = i

			break
		end
	end

	return result
end

function RoomFormulaListModel:refreshRankDiff()
	self._idIdxList = {}

	local dataList = self:getList()

	for _, mo in ipairs(dataList) do
		table.insert(self._idIdxList, mo.id)
	end
end

function RoomFormulaListModel:clearRankDiff()
	self._idIdxList = nil
end

function RoomFormulaListModel:getRankDiff(mo)
	if self._idIdxList and mo then
		local oldIdx = tabletool.indexOf(self._idIdxList, mo.id)
		local curIdx = self:getIndex(mo)

		if oldIdx and curIdx then
			return curIdx - oldIdx
		end
	end

	return 0
end

RoomFormulaListModel.instance = RoomFormulaListModel.New()

return RoomFormulaListModel
