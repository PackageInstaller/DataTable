-- chunkname: @modules/logic/room/model/map/building/RoomFormulaMO.lua

module("modules.logic.room.model.map.building.RoomFormulaMO", package.seeall)

local RoomFormulaMO = pureTable("RoomFormulaMO")
local DEFAULT_COUNT = 1
local DEFAULT_IS_LAST = true
local DEFAULT_IS_EXPAND = false

function RoomFormulaMO:init(info)
	self.id = info.id
	self.formulaId, self.treeLevel = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(info.id)
	self.config = RoomConfig.instance:getFormulaConfig(self.formulaId)

	if not self.config then
		logError("找不到配方id: " .. tostring(self.formulaId))
	end

	self:setIsLast(info.isLast)
	self:setParentStrId(info.parentStrId)
	self:resetIsExpandTree()
end

function RoomFormulaMO:getId()
	return self.id
end

function RoomFormulaMO:getFormulaId()
	return self.formulaId
end

function RoomFormulaMO:getFormulaCombineCount()
	if not self.formulaCombineCount then
		self:resetFormulaCombineCount()
	end

	return self.formulaCombineCount
end

function RoomFormulaMO:getIsExpandTree()
	return self.isExpandTree
end

function RoomFormulaMO:getConfig()
	return self.config
end

function RoomFormulaMO:getFormulaTreeLevel()
	if not self.treeLevel then
		self:setFormulaTreeLevel(RoomFormulaModel.DEFAULT_TREE_LEVEL)
	end

	return self.treeLevel
end

function RoomFormulaMO:getIsLast()
	return self.isLast
end

function RoomFormulaMO:getParentStrId()
	return self.parentStrId
end

function RoomFormulaMO:isTreeFormula()
	return self.treeLevel ~= RoomFormulaModel.DEFAULT_TREE_LEVEL
end

function RoomFormulaMO:resetFormulaCombineCount()
	local formulaStrId = self:getId()
	local needQuantity = RoomProductionHelper.getFormulaNeedQuantity(formulaStrId)
	local formulaId = self:getFormulaId()
	local produceItemParam = RoomProductionHelper.getFormulaProduceItem(formulaId)
	local leftCount = ((produceItemParam or nil) and ItemModel.instance:getItemQuantity(produceItemParam.type, produceItemParam.id)) - needQuantity

	self:setFormulaCombineCount((leftCount < 0 or nil) and math.abs(leftCount))
end

function RoomFormulaMO:resetIsExpandTree()
	self:setIsExpandTree(DEFAULT_IS_EXPAND)
end

function RoomFormulaMO:setFormulaCombineCount(count)
	count = count > 0 and count or DEFAULT_COUNT
	self.formulaCombineCount = count

	self:syncChildFormulaCombineCount()

	local formulaStrId = self:getId()

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshFormulaCombineCount, formulaStrId)
end

function RoomFormulaMO:syncChildFormulaCombineCount()
	local isExpand = self:getIsExpandTree()

	if not isExpand then
		return
	end

	local formulaId = self:getFormulaId()
	local curCombineCount = self:getFormulaCombineCount()
	local curTreeLevel = self:getFormulaTreeLevel()
	local costItemList = RoomProductionHelper.getCostItemListWithFormulaId(formulaId)

	for _, costItem in ipairs(costItemList) do
		if costItem.formulaId and costItem.formulaId ~= 0 then
			local childFormulaStrId = RoomProductionHelper.getFormulaStrUID(costItem.formulaId, curTreeLevel + 1)
			local childFormulaMo = RoomFormulaModel.instance:getFormulaMo(childFormulaStrId, true)

			if childFormulaMo then
				local childNeedQuantity = costItem.quantity * curCombineCount
				local childOwnQuantity = ItemModel.instance:getItemQuantity(costItem.type, costItem.id)
				local leftCount = childOwnQuantity - childNeedQuantity

				childFormulaMo:setFormulaCombineCount((leftCount < 0 or nil) and math.abs(leftCount))
			end
		end
	end
end

function RoomFormulaMO:setFormulaTreeLevel(treeLevel)
	if treeLevel < 0 then
		treeLevel = RoomFormulaModel.DEFAULT_TREE_LEVEL
	elseif treeLevel > RoomFormulaModel.MAX_FORMULA_TREE_LEVEL then
		treeLevel = RoomFormulaModel.MAX_FORMULA_TREE_LEVEL
	end

	self.treeLevel = treeLevel
end

function RoomFormulaMO:setIsLast(isLast)
	if isLast == nil then
		isLast = DEFAULT_IS_LAST
	end

	self.isLast = isLast
end

function RoomFormulaMO:setParentStrId(parentStrId)
	self.parentStrId = parentStrId
end

function RoomFormulaMO:setIsExpandTree(isExpandTree)
	self.isExpandTree = isExpandTree
end

return RoomFormulaMO
